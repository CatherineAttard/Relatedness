#!/usr/bin/perl
use strict;
use warnings;

use Cwd;

my $proportion = $ARGV[0];
my $workingdirectory = $ARGV[1];

print "This perl script was written by Catherine Attard\nPlease cite Attard et al. (2018) \"Genotyping-by-sequencing for estimating relatedness in nonmodel organisms: Avoiding the trap of precise bias\" Molecular Ecology Resources 28: 381-390 when using this script\nCatherine makes no guarantee that this script is bug-free; use at your own risk and please report bugs to catherine.r.attard\@gmail.com\n";
print "\nThe script is designed for introducing allelic dropout to genotype data simulated in Coancestry without genotyping error and with or without missing data\n";

if (not defined ($proportion)) {
	print "\nYou have not defined the allelic dropout rate. The correct command useage for this perl script is:\nperl CoancestryAllelicDropout.pl allelic_dropout_rate working_directory_(optional)\n";
	exit;
	}

if (defined ($workingdirectory)){
	print "\nI will use $workingdirectory as my working directory\n"
	}
	
if (not defined ($workingdirectory)){
	$workingdirectory = getcwd();
	print "\nAs you have not defined a working directory, I will use the current directory of this perl script as the working directory. This is $workingdirectory\n"
	}

open (IN, "<${workingdirectory}/GenotypeData.txt") or die "\nCan not open input file: $!. Check that it is in the working directory and called GenotypeData.txt\n";
my @lines = <IN>;
close IN;

rename("${workingdirectory}/GenotypeData.txt", "${workingdirectory}/GenotypeDataOriginal.txt") or die "\nRename of your input file, GenotypeData.txt, to GenotypeDataOriginal.txt was unsuccessful: $!.\n To fix this, try continuing through the tabs in the Coancestry GUI, press \"Check and Save\" in the \"Analysis Parameters\" tab, and then re-run this script\n";

open (OUT, ">>${workingdirectory}/GenotypeData.txt") or die "\nCan not create output file: $!\n";

print "\nI have successfully renamed your original GenotypeData.txt file to GenotypeDataOriginal.txt (just in case you want a copy!)\n\nI am now introducing $proportion allelic dropout to this data and outputting it into a file called GenotypeData.txt\n";

foreach my $line (@lines) {
	if ($line =~ /^\n/) {
		print OUT "$line";
	}
	else {
		chomp $line;
		my @columns = split(/\s/, $line);
		print OUT "$columns[0] ";
		my $colnum = scalar(@columns)-1;
		for (my $count=1; $count <= $colnum; $count+=2) {
			if ($columns[$count] == $columns[$count+1]) {
				print OUT "$columns[$count] $columns[$count+1] ";
				next;
			}
			elsif ($columns[$count] != $columns[$count+1]) {
				my $randomnumber = rand();
				if ($randomnumber < $proportion) {
					my $alleletochange = int(rand(2));
					my $homozygoteallele;
					if ($alleletochange == 0) {
						$homozygoteallele = 1;}
					elsif ($alleletochange == 1) {
						$homozygoteallele = 0;}
					$columns[$count+$alleletochange] = $columns[$count+$homozygoteallele];
				}
			print OUT "$columns[$count] $columns[$count+1] ";
			}
		}
	print OUT "\n";
	}
}
close OUT;
print "\nI have finished! Do not accidentally repeat this script as you'll be introducing more allelic dropout to your allelic dropout dataset!\n";
print "\nNow it's time for you to run your simulation project in Coancestry to estimate relatedness!\n";
