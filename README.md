# Assembly & Annotation Course – Kas-1 (Arabidopsis thaliana)

This repository documents a reproducible workflow for my course work on accession **Kas-1**.

---

## Data links on cluster

- **Genomic (PacBio HiFi):** `Kas-1/ERR11437309.fastq.gz` (symlink inside project)  
- **Transcriptomic (Illumina RNA-seq, Sha):** `RNAseq_Sha/ERR754081_1/2.fastq.gz` (symlink)  

> ⚠️ Raw data and QC outputs are kept on the cluster and **not** tracked in Git.

---

## Scripts

- `scripts/01_fastqc.sh` – run **FastQC** on PacBio HiFi and RNA-seq  
- `scripts/02_fastp.sh` – trim/filter RNA-seq with **fastp**; pass-through stats for PacBio  

---

## Results summary

### FastQC
- RNA-seq (Sha): paired-end, good overall quality; adapters present pre-trimming.  
- PacBio HiFi: long reads, consistent length distribution, high quality.

### fastp
- **RNA-seq before:** 45,241,360 reads / 4.57 Gb  
- **RNA-seq after:** 40,704,842 reads / 4.09 Gb  
- **Trimmed/filtered:** 4,536,518 reads  
- **Q30:** 78.55% → 83.06% (+4.5 pp)

- **PacBio total bases:** ~4.48 Gb  
- **Estimated coverage (vs 135 Mb Arabidopsis genome):** ~33×  

---

## Notes
- Scripts are executed via `sbatch` on the cluster.  
- Only code and summaries are versioned here; large FASTQ/HTML/ZIP files stay on the cluster.
