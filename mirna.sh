#!/bin/sh

# Use in ROCKET only, not working in ATLAS
module load R-3.3.0
module load java-1.8.0_40
module load viennarna-2.8.1
module load python-2.7.6
module load fastx_toolkit-0.0.14

# Provide locations file with command line argument.
home=/gpfs/hpchome/ppaluoja/software/sRNAtoolboxDB
export PATH="${PATH}:$home/exec/bowtie-1.2.2-linux-x86_64"
locations="locations"

while IFS='' read -r line || [[ -n "$line" ]]; do
	location=$line
	sample=$(basename "$line" | cut -d. -f1)
	echo $sample
	# FASTQ -> FASTAmi
	# Remove adapter + everything following.
	# Discard sequences shorter than 18 nucleotides.
	# Keep only sequences which contained the adapter.
	# Discard sequences longer than 25 nucleotides.
	#zcat $f | fastq_to_fasta | fastx_clipper -a "AGATCGGAAG" -l 18 -c | fastx_trimmer -l 25 | fastx_collapser -o $name.fasta
	zcat $line --force | fastq_to_fasta | fastx_clipper -a "AGATCGGAAG" -l 18 -c | fastx_trimmer -l 25 | fastx_collapser -o $sample.fasta
	# sRNAbench
	java -Xms20m -Xmx10000m -jar $home/exec/sRNAbench.jar input=$sample.fasta output=$sample.out predict=true isoMiR=true dbPath=$home graphics=true sep="-" microRNA=hsa species=hg38 mature=mature.fa hairpin=hairpin.fa libs=hg38_prim_ncRNA libs=hg38_prim_RNAcentral libs=hg38_prim_cdna 
	# Cleanup
	rm -rf $sample.out/genomeDistribution &
	rm -rf $sample.out/hairpin
	rm -rf $sample.out/genome.parsed
	rm -rf $sample.out/genome.parsed.zip
done < "$1"
