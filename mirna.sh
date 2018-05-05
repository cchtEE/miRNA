#!/bin/sh
#SBATCH --time=60:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=priitpaluoja@gmail.com
#SBATCH -J sRNAbench
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15000

# Use in ROCKET only
module load R-3.3.0
module load java-1.8.0_40
module load viennarna-2.8.1
module load python-2.7.6
module load fastx_toolkit-0.0.14

home=/gpfs/hpchome/ppaluoja/software/sRNAtoolboxDB
export PATH="${PATH}:$home/exec/bowtie-1.2.2-linux-x86_64"

for f in *.gz
do
	name=$(basename "$f" | cut -d. -f1)
	# FASTQ -> FASTA
	# Remove adapter + everything following.
	# Discard sequences shorter than 18 nucleotides.
	# Keep only sequences which contained the adapter.
	# Discard sequences longer than 25 nucleotides.
	zcat $f | fastq_to_fasta | fastx_clipper -a "AGATCGGAAG" -l 18 -c | fastx_trimmer -l 25 | fastx_collapser -o $name.fasta
	# sRNAbench
	java -Xms20m -Xmx14900m -jar $home/exec/sRNAbench.jar input=$name.fasta output=$name.out dbPath=$home graphics=true sep="-" microRNA=hsa species=hg38 mature=mature.fa hairpin=hairpin.fa
done
