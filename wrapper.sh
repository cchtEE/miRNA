#!/bin/sh
#SBATCH --time=30:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=priitpaluoja@gmail.com
#SBATCH -J sRNAbench1
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15000

# Use in ROCKET only, not working in ATLAS
./mirna.sh "mirnaloc.txt"
