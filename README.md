# Github Action for building container image for R Notebook repositories

Builds container image for notebook repository (built for Bioconductor R notebooks) using
a Dockerfile in the notebook repository if existing, or default Dockerfile from this
action repository otherwise

## How to use

Make a file at `.github/workflows/container_build.yml` with the following:

```
name: Build Container Image
# Change this for desired build frequency
on: push
jobs:
  build:
    name: Build container image
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - uses: almahmoud/r-notebook-container-build-action@main
        with:
          image-name: almahmoud/my-r-notebook
          image-tag: latest
          base-image: "bioconductor/bioconductor_docker"
          base-tag: "latest"
          build-command: |
              Rscript -e "BiocManager::install(remotes::local_package_deps(dependencies=TRUE))" && cd inst/book && Rscript -e 'bookdown::render_book("index.Rmd")'
```
