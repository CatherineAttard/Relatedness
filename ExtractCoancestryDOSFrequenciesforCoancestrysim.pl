#!/usr/bin/perl -w
use strict;
use warnings;
open (OUT, ">>C:/ZSL/Coancestry/FrequencyData.txt")or die "Can not create FrequencyData.txt $!\n";
open (IN, "<C:/ZSL/Coancestry/Output/OutPut.txt") or die "Can not open input $!\n";
my @lines=<IN>;
close IN;
my $linenum=scalar(@lines)-1;
for (my $count=1; $count <= $linenum; $count++) {
	chomp ($lines[$count]);
	if ($lines[$count]=~ /^ Locus:/) {
		my @alleles = split(/\s+/, $lines[$count+1]);
		print OUT $alleles[1];
		print OUT " ";
		print OUT $alleles[2];
		print OUT " ";
		print OUT "\n";
		my @frequency = split(/\s+/, $lines[$count+2]);
		print OUT $frequency[1];
		print OUT " ";
		print OUT $frequency[2];
		print OUT " ";
		print OUT "\n";
	}
}