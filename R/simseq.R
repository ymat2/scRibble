library(conflicted)
library(tidyverse)
library(phytools)
library(phangorn)
library(ggtree)

set.seed(1234)
tr = ape::rtree(n = 4, rooted = TRUE)

seq = phangorn::simSeq(tr, l = 100, type = "DNA", rate = .05, ancestral = TRUE)
df_genotype = as_tibble(seq) |>
  dplyr::select(dplyr::starts_with("t")) |>
  tibble::rownames_to_column(var = "pos") |>
  dplyr::mutate(pos = as.numeric(pos)) |>
  tidyr::pivot_longer(dplyr::starts_with("t"), names_to = "tip", values_to = "gt")

nucl_color = c(
  "a" = "#D55E00", 
  "t" = "#0072B2", 
  "g" = "#009E73", 
  "c" = "#F0E442"
)

ggplot(df_genotype) +
  aes(x = pos, y = tip) +
  geom_tile(aes(fill = gt)) +
  geom_text(aes(label = gt), color = "#444444") +
  scale_fill_manual(values = nucl_color) +
  theme_bw() +
  theme(
    legend.position = "none",
    axis.title = element_blank(),
    panel.grid = element_blank(),
    panel.border = element_blank()
  )


p = ggtree(tr) + geom_tiplab(size=3)
gheatmap(p, genotype, offset=5, width=0.5, font.size=3, colnames_angle=-45, hjust=0)
