install.packages("pak")

pkgs = c(
  "devtools",
  "BiocManager",
  "clusterProfiler",
  "ggbiplot",
  "ggpubr",
  "ggtree",
  "ggvenn",
  "ggVennDiagram",
  "patchwork",
  "phytools",
  "Rcpp",
  "TCC",
  "tidyverse",
  "VennDiagram",
  "ymat2/myrrr"
)

pak::pkg_install(pkgs, upgrade = FALSE)
