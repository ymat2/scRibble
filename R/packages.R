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
  "languageserver",
  "magick",
  "OptM",
  "org.Gg.eg.db",
  "org.Hs.eg.db",
  "org.Mm.eg.db",
  "patchwork",
  "phytools",
  "Rcpp",
  "TCC",
  "tidyverse",
  "tuneR",
  "VennDiagram",
  "writexl",
  "ymat2/myrrr"
)

pak::pkg_install(pkgs, upgrade = FALSE)
