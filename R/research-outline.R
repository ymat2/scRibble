library(conflicted)
library(tidyverse)
library(phytools)
library(ggtree)


df_pop1 = dplyr::tibble(
  label = stringr::str_c("popA", seq(1, 50)),
  pca1 = rgamma(n = 50, shape = 4.9, rate = 1),
  pca2 = rgamma(n = 50, shape = 5.1, rate = 1),
  trait = rpois(n = 50, lambda = 5) + 5,
  pop = "pop A"
) 

df_pop2 = dplyr::tibble(
  label = stringr::str_c("popB", seq(1, 50)),
  pca1 = rgamma(n = 50, shape = 4.9, rate = 1) + 10,
  pca2 = rgamma(n = 50, shape = 5.1, rate = 1) + 10,
  trait = rpois(n = 50, lambda = 10) + 10,
  pop = "pop B"
)

df_pop = dplyr::bind_rows(df_pop1, df_pop2)

set.seed(12345)
tr1 = ape::rtree(n = 50, tip.label = df_pop1$label)
tr2 = ape::rtree(n = 50, tip.label = df_pop2$label)
tr = ape::bind.tree(tr1, tr2) |> dplyr::full_join(df_pop, by = "label")
ptree = ggtree(tr, layout = "ape") + 
  geom_tippoint(aes(color = pop), size = 2) +
  scale_color_manual(values = c("#e08214", "#8073ac"), labels = c("population A", "population B")) +
  theme(
    legend.position = "top",
    legend.title = element_blank()
  )

ppca = ggplot(df_pop) +
  aes(pca1, pca2) +
  geom_point(aes(color = pop), size = 2) +
  scale_color_manual(values = c("#e08214", "#8073ac")) +
  labs(x = "PC1", y = "PC2", title = "PCA") +
  theme_bw(base_size = 16) +
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

pphe = ggplot(df_pop) +
  aes(x = pop, y = trait, color = pop) +
  geom_boxplot(linewidth = 1) +
  geom_jitter(width = .2, height = 0, alpha = .4, shape = 16, size = 2) +
  scale_color_manual(values = c("#e08214", "#8073ac")) +
  labs(x = "", y = "Phenotype", title = "Trait value") +
  theme_bw(base_size = 16) +
  theme(
    legend.position = "none",
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  )
  
  
peaks = sample(seq(1, 20000), 4)

df4manhattan = dplyr::tibble(
  pos = seq(1, 20000),
  chr = rep(1:10, each = 2000) |> as.character(),
  p = rexp(n = 20000, rate = 5)
  ) |>
  dplyr::mutate(p = dplyr::if_else(
    pos %in% unlist(lapply(peaks, function(x) (x - 50):(x + 50))),
    p * 5, p
    )
  )

pman = ggplot(df4manhattan) +
  aes(pos, p) + 
  geom_point(aes(color = chr)) +
  geom_hline(yintercept = 3, linetype = "dashed", color = "darkred", linewidth = .75) +
  scale_color_manual(values = rep(c("#1f78b4", "#a6cee3"), 10)) +
  labs(x = "Genomic positions", y = "-log(P)", title = "Genomic analysis") +
  theme_bw(base_size = 16) +
  theme(
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )


df4ma = dplyr::tibble(
  exp_a = rexp(n = 5000, rate = 10),
  exp_b = rexp(n = 5000, rate = 10)
  ) |>
  dplyr::mutate(
    mean_exp = (exp_a + exp_b)/2,
    logfc = log(exp_a / exp_b),
    sig = dplyr::case_when(
      logfc > -log2(mean_exp) ~ "up",
      logfc < log2(mean_exp)  ~ "down",
      .default = "NA"
    )
  )

pma = ggplot(df4ma) +
  aes(mean_exp, logfc) +
  geom_point(aes(color = sig)) +
  scale_color_manual(values = c("#2166ac", "grey50", "#b2182b")) +
  labs(x = "Expression level", y = "logFC", title = "RNAseq") +
  theme_bw(base_size = 16) +
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )


p1 = cowplot::plot_grid(ptree, ppca, pphe, rel_widths = c(3, 3, 2), ncol = 3, 
                        labels = c("a", "b", "c"), label_size = 20,
                        align = "h", axis = "tb", scale = .99)
p2 = cowplot::plot_grid(pman, pma, rel_widths = c(2, 1), scale = .99,
                        labels = c("d", "e"), label_size = 20)
p = cowplot::plot_grid(p1, p2, nrow = 2)
ggsave("images/outline.png", p, h = 7, w = 9, bg = "#FFFFFF")
