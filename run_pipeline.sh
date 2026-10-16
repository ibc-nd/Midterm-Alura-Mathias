#Usage: bash run_pipeline.sh reference.fasta proteome.fasta
#In the directory, there should be a reference.fasta ($1) file for the gene of interest and a sub directory with all the proteome fasta files ($2)
#For example, $1 input can be mcrA_reference_sequence.fasta and $2 can be proteome/

#error checking where $1 refers to all the fasta sequences for a given gene and $2 refers to all the proteomes
set -e
ls "$1" "$2"

#make sure muscle and hmmer are loaded
module load bio

#script aligns sequences and then builds hmm profile
/software/b/bio/0326/bin/muscle -align "$1" -output aligned.afa

/software/b/bio/0326/bin/hmmbuild profile.hmm aligned.afa

#compare hmm profile to every protein in the directory. 
##results are saved in pipeline_results.csv 
###columns are proteome, num_hits

for proteome in "$2"/*.fasta
do
name=$(basename "$proteome")
/software/b/bio/0326/bin/hmmsearch --tblout tmp.txt profile.hmm "$proteome"
hits=$(grep -v "^#" tmp.txt | awk '$5<0.001' | wc -l)
echo "$name,$hits" >> tmp_pipeline_results.csv
done

echo proteome, num_hits > pipeline_results.csv
cat tmp_pipeline_results.csv >> pipeline_results.csv

#getting rid of extra files
rm tmp.txt tmp_pipeline_results.csv

