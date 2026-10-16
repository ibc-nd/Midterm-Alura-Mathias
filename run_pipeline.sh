#bash script for Question 3
##Instructions: to use the script, move run_pipeline.sh into the folder with all the fasta sequences of interest and type bash run_pipeline.sh into the command line


#script builds an alignment for given fasta sequences
for sequence in *.fasta
do
cat $sequence >> reference.fasta
done

#to get muscle and hmmer
module load bio

#script aligns sequences and then builds hmm profile
/software/b/bio/0326/bin/muscle -align reference.fasta -output aligned.afa

/software/b/bio/0326/bin/hmmbuild profile.hmm aligned.afa

