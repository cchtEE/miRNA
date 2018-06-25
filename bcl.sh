#!/bin/bash

#SBATCH --job-name=bcl
#SBATCH --mail-user=priitpaluoja@gmail.com
#SBATCH --mail-type=ALL

#SBATCH --partition=main
#SBATCH --cpus=4
#SBATCH --mem=8000
#SBATCH --time=02:00:00
module load bcl2fastq2

bcl2fastq --barcode-mismatches 0
