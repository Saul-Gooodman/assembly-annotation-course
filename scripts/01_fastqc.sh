#!/usr/bin/env bash
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc_all
#SBATCH --partition=pibu_el8
#SBATCH --output=%x_%j.o
#SBATCH --error=%x_%j.e

set -euo pipefail

USERNAME=$(whoami)
PROJ=/data/users/$USERNAME/assembly_annotation_course
ACCESSION=Kas-1
OUT=$PROJ/read_QC/fastqc
mkdir -p "$OUT"

module load FastQC/0.11.9-Java-11

for fq in $PROJ/$ACCESSION/*.fastq.gz $PROJ/RNAseq_Sha/*.fastq.gz; do
  [ -e "$fq" ] || continue
  echo "Running FastQC on: $fq"
  fastqc -t ${SLURM_CPUS_PER_TASK:-2} -o "$OUT" "$fq"
done
