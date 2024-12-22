install.packages("pak")

pkgs = c(
  "devtools", 
  "tidyverse", 
  "Rcpp",
  "BiocManager", 
  "patchwork", 
  "ggpubr", 
  "ggtree", 
  "phytools", 
  "clusterProfiler",
  "ymat2/myrrr"
)

pak::pkg_install(pkgs, upgrade = FALSE)
