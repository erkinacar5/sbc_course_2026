# Spatial Biology of Cancer — R tutorials (2026)

Hands-on R tutorials from the **Spatial Biology of Cancer (SBC)** course at the Department of Biosystems Science and Engineering (D-BSSE), ETH Zurich, spring semester 2026.

Over four sessions the tutorials analyse one human breast cancer sample with single-cell and spatial transcriptomics. They go from single-cell annotation to Visium deconvolution and cell-type co-occurrence, and end with high-resolution Visium HD.

**New since the [2024 edition](https://github.com/erkinacar5/sbc_course_2024):**

- a ready-made Docker image, so students don't have to install the packages themselves
- a new Visium HD session
- code updated for Seurat 5

## Tutorials

| # | Date | Topic |
|---|------|-------|
| 1 | 29.04.2026 | [**Single-cell analysis**](01_sbc_290426_tutorial.Rmd): QC, normalization, clustering, marker genes, cell-type scoring with the 10x Xenium breast panel, manual annotation |
| 2 | 06.05.2026 | [**Visium (1)**](02_sbc_060526_tutorial.Rmd): spatial QC, SCTransform, spatially variable genes (Moran's I), clustering, characterizing tissue regions |
| 3 | 13.05.2026 | [**Visium (2)**](03_sbc_130526_tutorial.Rmd): spot deconvolution with RCTD, composition clusters and cell-type co-occurrence with ISCHIA |
| 4 | 20.05.2026 | [**Visium HD**](04_sbc_200526_tutorial.Rmd): 16 µm bins, QC, region subsetting, clustering, and how Visium HD compares with Visium and Xenium |

## Setup

The tutorials run in RStudio inside a Docker container with all packages preinstalled: [`erkinacar5/sboc26`](https://hub.docker.com/r/erkinacar5/sboc26) (~2 GB compressed). It's built from the [Dockerfile](Dockerfile) in this repo, which uses `rocker/rstudio:4.5.3` with Seurat, spacexr (RCTD), ISCHIA and their dependencies. To build it yourself, run `docker build -t sboc26 .`.

```bash
mkdir tutorial
docker run -d -p 8787:8787 -e PASSWORD=<choose-a-password> -v "$PWD/tutorial":/tutorial erkinacar5/sboc26:v2
```

Then open <http://localhost:8787> and log in as `rstudio` with the password you chose. Put the input data in the `tutorial` folder; inside the container it appears as `/tutorial`.

[00_setup_sboc_2026.html](00_setup_sboc_2026.html) is the original setup handout for students, with step-by-step Docker Desktop instructions.

## Data

All datasets are public 10x Genomics human breast cancer samples:

- [Chromium FFPE single-cell](https://cf.10xgenomics.com/samples/cell-exp/7.0.1/Chromium_FFPE_Human_Breast_Cancer_Chromium_FFPE_Human_Breast_Cancer/Chromium_FFPE_Human_Breast_Cancer_Chromium_FFPE_Human_Breast_Cancer_count_sample_filtered_feature_bc_matrix.h5): filtered feature–barcode matrix
- [CytAssist FFPE Visium](https://cf.10xgenomics.com/samples/spatial-exp/2.0.0/CytAssist_FFPE_Human_Breast_Cancer/CytAssist_FFPE_Human_Breast_Cancer_filtered_feature_bc_matrix.h5): filtered matrix plus the [spatial folder](https://cf.10xgenomics.com/samples/spatial-exp/2.0.0/CytAssist_FFPE_Human_Breast_Cancer/CytAssist_FFPE_Human_Breast_Cancer_spatial.tar.gz)
- [Visium HD fresh-frozen human breast cancer](https://www.10xgenomics.com/datasets/visium-hd-cytassist-gene-expression-libraries-human-breast-cancer-ff-ultima): "Binned outputs (all bin levels)", ~20 GB
- [10x Xenium human breast gene panel](https://cf.10xgenomics.com/supp/xenium/panels/hBreast_v1.csv) (280 genes)

The cell-type annotation used for deconvolution comes from the original study: Janesick et al., *Nature Communications* (2023), [doi:10.1038/s41467-023-43458-x](https://doi.org/10.1038/s41467-023-43458-x).

Main packages: [Seurat](https://satijalab.org/seurat/), [SeuratDisk](https://github.com/mojaveazure/seurat-disk), [spacexr (RCTD)](https://github.com/dmcable/spacexr), [ISCHIA](https://github.com/ati-lz/ISCHIA), tidyverse and patchwork.
