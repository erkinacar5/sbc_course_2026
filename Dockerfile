# syntax=docker/dockerfile:1
FROM rocker/rstudio:4.5.3

LABEL maintainer="Erkin (github.com/erkinacar5)" \
      description="R env for SBoC 26"

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

ENV LIBARROW_MINIMAL=false \
    ARROW_WITH_ZSTD=ON

RUN apt-get update && apt-get install -y \
    build-essential gfortran pkg-config cmake \
    libcurl4-openssl-dev libssl-dev libxml2-dev \
    zlib1g-dev libzstd-dev \
    libpng-dev libjpeg-dev libtiff5-dev \
    libcairo2-dev libfreetype6-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev \
    libblas-dev liblapack-dev libopenblas-dev libglpk-dev \
    libhdf5-dev \
    openjdk-8-jdk \
    python3-dev python3-pip \
    wget git libfftw3-dev libgsl-dev libhdf5-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'install.packages("arrow", repos = c("https://apache.r-universe.dev", "https://cloud.r-project.org"))'
RUN Rscript -e 'install.packages(c("renv", "Seurat", "hdf5r", "tidyverse", "yaml", "remotes", "BiocManager"), repos="https://cloud.r-project.org")'
RUN Rscript -e 'remotes::install_github("mojaveazure/seurat-disk")'
RUN Rscript -e 'withr::with_makevars(c(CXX11STD = "-std=gnu++14"), remotes::install_github("immunogenomics/presto"), assignment = "=")'
RUN Rscript -e 'remotes::install_github("dmcable/spacexr", build_vignettes = FALSE)'
RUN Rscript -e 'BiocManager::install(c("limma","MAST", "glmGamPoi","Rfast2"))'
RUN Rscript -e 'remotes::install_github("JEFworks-Lab/STdeconvolve")'
RUN Rscript -e 'remotes::install_github("jokergoo/ComplexHeatmap")'
RUN Rscript -e 'remotes::install_github("saeyslab/nichenetr")'
RUN Rscript -e 'remotes::install_github("griffithdan/cooccur")'
RUN Rscript -e 'remotes::install_github("Biclustering/biclust")'
RUN Rscript -e 'remotes::install_github("ati-lz/ISCHIA")'

# Expose RStudio Server port
EXPOSE 8787

# Default command (Rocker uses /init to start RStudio)
CMD ["/init"]
