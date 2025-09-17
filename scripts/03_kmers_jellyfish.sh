#!/usr/bin/env bash
#SBATCH --cpus-per-task=4
#SBATCH --mem=48G
#SBATCH --time=08:00:00
#SBATCH --job-name=jf_k21
#SBATCH --partition=pibu_el8
#SBATCH --output=%x_%j.o
#SBATCH --error=%x_%j.e

set -euo pipefail

USERNAME=$(whoami)
PROJ=/data/users/$USERNAME/assembly_annotation_course
OUT=$PROJ/read_QC/kmer_counting
mkdir -p "$OUT"


K=21                         
HASH=5G                      
T=${SLURM_CPUS_PER_TASK:-4} 

module load Jellyfish/2.3.0-GCC-10.3.0
jellyfish --version

HIFI=$(ls $PROJ/Kas-1/*.fastq.gz | head -n1)


jellyfish count -C -m ${K} -s ${HASH} -t ${T} \
  <(zcat "$HIFI") \
  -o $OUT/mer_counts_k${K}.jf


jellyfish histo -t ${T} $OUT/mer_counts_k${K}.jf > $OUT/mer_counts_k${K}.histo


echo "Histogram ready: $OUT/mer_counts_k${K}.histo"
head -n 5 $OUT/mer_counts_k${K}.histo || true

