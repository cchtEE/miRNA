#!/bin/sh

module load java-1.8.0_40
module load viennarna-2.8.1
module load python-3.6.3

source activate rna # edgeR, DEseq, NOISeq, Viennarna

home=/gpfs/hpchome/ppaluoja/software/sRNAtoolboxDB
export PATH="${PATH}:$home/exec/bowtie-1.2.2-linux-x86_64"

java -Xms20m -Xmx10000m -jar $home/exec/sRNAde.jar input="/gpfs/hpchome/ppaluoja/projects/sanna/miRNA/test" grpString="Immature_oocyte_1_S1_L001_R1_001.out:Immature_oocyte_2_S2_L001_R1_001.out:BC1_S1_L001_R1_001.out:BC15_S15_L001_R1_001.out:BC18_S18_L001_R1_001.out:BC19_S19_L001_R1_001.out#BC20_S20_L001_R1_001.out:BC21_S21_L001_R1_001.out:BC22_S22_L001_R1_001.out#BC2_S2_L001_R1_001.out:BC3_S3_L001_R1_001.out:BC16_S16_L001_R1_001.out:BC17_S17_L001_R1_001.out#Mature_oocyte_1_S3_L001_R1_001.out:Mature_oocyte_2_S4_L001_R1_001.out:BC27_S27_L001_R1_001.out:BC31_S31_L001_R1_001.out:BC32_S32_L001_R1_001.out#4_cell_embryo_1_S5_L001_R1_001.out:4_cell_embryo_2_S6_L001_R1_001.out:BC23_S23_L001_R1_001.out:BC24_S24_L001_R1_001.out:BC25_S25_L001_R1_001.out#8_cell_embryo_1_S7_L001_R1_001.out:8_cell_embryo_2_S8_L001_R1_001.out:BC28_S28_L001_R1_001.out:BC29_S29_L001_R1_001.out:BC30_S30_L001_R1_001.out" output="some" diffExpr=true diffExprFiles="mature_sense_SA.grouped"
