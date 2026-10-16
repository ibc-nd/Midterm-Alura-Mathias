#bash script for Question 3
##Instructions: to use the script, create a directory with all gene and proteome fasta files of interest
###In the directory, type bash run_pipeline.sh into the command line

#script organizes fasta files into folders
mkdir ref_sequences/ proteomes/
mv *gene*.fasta ref_sequences/
mv proteome*.fasta proteomes/

#script builds an alignment for given gene fasta sequences
for sequence in ref_sequences/*.fasta
do
cat $sequence >> reference.fasta
done

#to get muscle and hmmer
module load bio

#script aligns sequences and then builds hmm profile
/software/b/bio/0326/bin/muscle -align reference.fasta -output aligned.afa

/software/b/bio/0326/bin/hmmbuild profile.hmm aligned.afa

#compare hmm profile to every protein in the directory. 
##results are saved in pipeline_results.csv 
###columns are proteome, num_hits

for proteome in proteomes/*.fasta
do
name=$(basename "$proteome")
/software/b/bio/0326/bin/hmmsearch --tblout tmp.txt profile.hmm "$proteome"
hits=$(grep -v "^#" tmp.txt | awk '$5<0.001' | wc -l)
#echo proteome, num_hits >> tmp_pipeline_results.csv
echo "$name,$hits" >> tmp_pipeline_results.csv
done

echo proteome, num_hits > pipeline_results.csv
cat tmp_pipeline_results.csv >> pipeline_results.csv

#getting rid of extra files
rm tmp.txt tmp_pipeline_results.csv

