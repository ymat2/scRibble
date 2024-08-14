install.packages("pacman")
pacman::p_load(devtools, BiocManager, Rcpp, tidyverse, conflicted, phytools, install = TRUE)

biopkgs = c("ggtree", "clusterProfiler")
BiocManager::install(biopkgs)
