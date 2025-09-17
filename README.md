mkdir -p figures results
cat > README.md << 'EOF'
# Assembly & Annotation Course – Kas-1 (Arabidopsis thaliana)

This repository documents a reproducible workflow for my course work on accession **Kas-1**.

## Data links on cluster
- Genomic (PacBio HiFi): `Kas-1/ERR11437309.fastq.gz` (symlink inside project)
- Transcriptomic (Illumina RNA-seq, Sha): `RNAseq_Sha/ERR754081_1/2.fastq.gz` (symlink)

> Raw data and QC outputs are kept on the cluster and **not** tracked in Git.

## Scripts
- `scripts/01_fastqc.sh` – run FastQC on PacBio HiFi and RNA-seq
- `scripts/02_fastp.sh`  – trim/filter RNA-seq with fastp; pass-through stats for PacBio

## Results summary
### FastQC
- RNA-seq (Sha): paired-end, good overall quality; adapters present pre-trimming.
- PacBio HiFi (Kas-1): long reads with high per-base quality.

### fastp
- RNA-seq reads before/after: **45,241,360 → 40,704,842** (trimmed/filtered **4,536,518**)
- Q30 ratio improved: **78.55% → 83.06%** (+4.51 pp)
- PacBio total bases: **~4.48 Gb**, estimated coverage vs 135 Mb genome: **~33.2×**

## Reproducibility notes
- All commands are executed from scripts; scripts are numbered by execution order.
- Paths and variables defined at the top of scripts for easy reuse.
- Outputs grouped by step: `read_QC/fastqc`, `read_QC/fastp`.

## Next steps
- Jellyfish k-mer counting → GenomeScope2 (will add `scripts/04_jellyfish.sh` and summary)
- De novo assembly and evaluation
EOF
