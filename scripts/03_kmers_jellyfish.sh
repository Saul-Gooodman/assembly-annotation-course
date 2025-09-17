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

# 参数
K=21                         # GenomeScope2 常用 k=21
HASH=5G                      # 哈希表大小（按课程要求）
T=${SLURM_CPUS_PER_TASK:-4}  # 线程

# 加载 jellyfish 模块（注意大小写）
module load Jellyfish/2.3.0-GCC-10.3.0
jellyfish --version

# HiFi 输入（Kas-1，gz 压缩，用 zcat 过程替换）
HIFI=$(ls $PROJ/Kas-1/*.fastq.gz | head -n1)

# 1) k-mer 计数（-C canonical；-m k；-s 哈希；-t 线程）
jellyfish count -C -m ${K} -s ${HASH} -t ${T} \
  <(zcat "$HIFI") \
  -o $OUT/mer_counts_k${K}.jf

# 2) 生成直方图
jellyfish histo -t ${T} $OUT/mer_counts_k${K}.jf > $OUT/mer_counts_k${K}.histo

# 3) 小提示
echo "Histogram ready: $OUT/mer_counts_k${K}.histo"
head -n 5 $OUT/mer_counts_k${K}.histo || true

