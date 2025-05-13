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
  "OptM",
  "org.Gg.eg.db",
  "org.Hs.eg.db",
  "patchwork",
  "phytools",
  "Rcpp",
  "TCC",
  "tidyverse",
  "VennDiagram",
  "ymat2/myrrr"
)

pak::pkg_install(pkgs, upgrade = FALSE)
