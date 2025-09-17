#!/usr/bin/env bash
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=04:00:00
#SBATCH --job-name=fastp_all
#SBATCH --partition=pibu_el8
#SBATCH --output=%x_%j.o
#SBATCH --error=%x_%j.e

set -euo pipefail
set -x  

USERNAME=$(whoami)
PROJ=/data/users/$USERNAME/assembly_annotation_course
OUT=$PROJ/read_QC/fastp
mkdir -p "$OUT"

echo "PWD=$(pwd)"
echo "PROJ=$PROJ"
echo "OUT=$OUT"


module load fastp/0.23.4 || module load fastp/0.23.2-GCC-10.3.0 || true
module list || true
which fastp || true
fastp --version || true


ls -lh $PROJ/RNAseq_Sha/ERR754081_1.fastq.gz
ls -lh $PROJ/RNAseq_Sha/ERR754081_2.fastq.gz
HIFI_IN=$(ls $PROJ/Kas-1/*.fastq.gz | head -n1)
ls -lh "$HIFI_IN"


fastp \
  -i $PROJ/RNAseq_Sha/ERR754081_1.fastq.gz \
  -I $PROJ/RNAseq_Sha/ERR754081_2.fastq.gz \
  -o $OUT/RNAseq_Sha_1.clean.fastq.gz \
  -O $OUT/RNAseq_Sha_2.clean.fastq.gz \
  -j $OUT/RNAseq_Sha.json \
  -h $OUT/RNAseq_Sha.html \
  --thread ${SLURM_CPUS_PER_TASK:-8}


fastp \
  -i "$HIFI_IN" \
  -o $OUT/Kas-1.pass_through.fastq.gz \
  -j $OUT/Kas-1.json \
  -h $OUT/Kas-1.html \
  --disable_adapter_trimming \
  --disable_length_filtering \
  --disable_quality_filtering \
  --thread ${SLURM_CPUS_PER_TASK:-8}


ls -lh "$OUT"
