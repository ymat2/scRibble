library(conflicted)
library(tidyverse)

## Volcano plot

sample_rna_seq = data.frame(
  logfc = rnorm(n=5000, mean = 0, sd = 5),
  var = runif(n = 5000, min=0, max=1)
  ) |>
  dplyr::mutate(
    pvalue = logfc * logfc * var,
    color = dplyr::case_when(
      logfc > 0 & pvalue > 50 ~ "A",
      logfc < 0 & pvalue > 50 ~ "B",
      .default = "C"
    ))

ggplot(sample_rna_seq) +
  aes(x = logfc, y = pvalue, color = color) +
  geom_point(size = 2) +
  scale_color_manual(values = c("#D73027", "#4575B4", "#999999")) +
  theme_classic() +
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.title = element_blank()
  )


## Heatmap

sample_rna_seq = data.frame(
  gene = seq(1, 60),
  fty1 = c(
    runif(n = 30, min = 0, max = 3),
    runif(n = 30, min = 3, max = 5)
  ),
  fty2 = c(
    runif(n = 30, min = 0, max = 3),
    runif(n = 30, min = 3, max = 5)
  ),
  fty3 =c(
    runif(n = 30, min = 0, max = 3),
    runif(n = 30, min = 3, max = 5)
  ),
  rir1 = c(
    runif(n = 30, min = 3, max = 5),
    runif(n = 30, min = 0, max = 3)
  ),
  rir2 = c(
    runif(n = 30, min = 3, max = 5),
    runif(n = 30, min = 0, max = 3)
  ),
  rir3 = c(
    runif(n = 30, min = 3, max = 5),
    runif(n = 30, min = 0, max = 3)
  )
  ) |>
  tidyr::pivot_longer(2:7, names_to = "sample", values_to = "FPKM")

p = ggplot(sample_rna_seq) +
  aes(x = gene, y = sample, fill = FPKM) +
  geom_tile() +
  #scale_fill_viridis_c(option = "E") +
  scale_fill_gradient2(high = "#D73027", mid = "#ffffff", low = "#4575B4", midpoint = 2.5) +
  labs(fill = "発現量") +
  theme_void(base_size = 20) +
  theme(
    legend.position = "top",
    legend.text = element_blank()
  )
ggsave(file = "images/sample_heatmap.png", p, w = 3, h = 3)


## Fst

set.seed(12321)
sample_fst = data.frame(
  pos = seq(1, 20000),
  base = rgamma(20000, shape = 1, rate = 100)
  ) |>
  dplyr::mutate(
    fst = dplyr::case_when(
      pos > 2000 & pos < 2100 ~ rgamma(20000, shape = 1, rate = 20),
      pos > 10100 & pos < 10200 ~ rgamma(20000, shape = 1, rate = 20),
      pos > 18300 & pos < 18400 ~ rgamma(20000, shape = 1, rate = 20),
      .default = base
    ),
    chr = dplyr::case_when(
      pos >= 1 & pos < 8000 ~ 1,
      pos >= 8000  & pos < 14000 ~ 2,
      pos >= 14000 & pos < 17000 ~ 3,
      pos >= 17000 & pos < 19000 ~ 4,
      pos >= 19000 & pos <= 20000 ~ 5
    )
  )

ggplot(sample_fst) +
  aes(x = pos, y = fst, color = chr) +
  geom_point(size = 2)


