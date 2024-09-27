Sys.getenv()
.libPaths()
.libPaths()[[1L]]

install.packages("pak")

pkgs = c(
  "BiocManager",
  "conflicted",
  "devtools",
  "ggrepel",
  "patchwork",
  "Rcpp",
  "tidyverse"
)
pak::pkg_install(pkgs)

biopkgs = c(
  "clusterProfiler",
  "ggtree",
  "phytools"
)
pak::pkg_install(biopkgs)
