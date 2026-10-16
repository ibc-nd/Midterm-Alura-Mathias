# Midterm-Alura-Mathias
Intro to Biocomputing Midterm Project

This project uses bioinformatic tools, muscle and hmmer, to identify candidate methanogenic Arcahe that are pH-resistant from a collection of 50 proteomes. The pipeline searches for two genes of interest: McrA (methyl-coenzyme M reductase gene) and Hsp70 (protein biogensis and folding gene). The pipeline uses multiple sequence alignment and HMM profile to search each proteome for homologs of the genes of interest

The pipeline requires access to muscle, hmmer, a reference protein sequence in fasta format, and proteome files in fasta format. If using the CRC, muscle and hmmer can be loaded using module load bio command.

Run the pipeling by providing the reference FASTA file and directory containing the proteomes: 
bash run_pipeline.sh refsequence.fasta proteomes/

The pipeline produces pipeline_results.csv as the output which summarizes the search results for each proteome.

Contributors: Mathias Mazzocco and Alura D'Souza
