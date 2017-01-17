README for CoancestryAllelicDropout.pl

-------------------
BACKGROUND INFORMATION

CoancestryAllelicDropout.pl was written by Catherine Attard. She makes no guarantee that this script is bug-free; use at your own risk and please report bugs to catherine.r.attard@gmail.com.

The script is designed for introducing allelic dropout to genotype data simulated in COANCESTRY in versions up to 1.0.1.6 without genotyping error and with or without missing 
data.

--------------------
RUNNING SCRIPT

The user needs Perl installed, with distributions freely available from https://www.perl.org/get.html .

Run the script after genotypes are simulated in COANCESTRY (i.e. after pressing “Simulate Genotypes” button in COANCESTRY GUI).

To run the script, in the Windows command line go to the location of the script and run as:
perl CoancestryAllelicDropout.pl proportion_allelic_dropout working_directory_(optional) 
e.g.: perl CoancestryAllelicDropout.pl 0.2 C:/ZSL/Coancestry/Simulation

The working directory should be the location of the GenotypeData.txt file that COANCESTRY outputs during simulations. It is also where the script will 
write its output. If no working directory is specified, the current location of the script will be used; this is appropriate if, for example, the 
script was copied into the folder of the COANCESTRY simulation project.

The script first renames the GenotypeData.txt file to GenotypeDataOriginal.txt (in case the user wants to keep the original copy). It then considers 
each simulated heterozygous genotype, randomly samples a decimal number between 0 and 1, and changes the heterozygote to a homozygote if this number 
is less than the user-supplied value for allelic dropout. One of the two alleles in the heterozygote are randomly chosen to form the homozygote. The 
result is output to a new GenotypeData.txt file. The user can then continue with the simulation project in the COANCESTRY GUI.