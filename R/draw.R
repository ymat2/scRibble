library(conflicted)
library(tidyverse)
library(phytools)
library(ggtree)


## KS enrichment analysis -----

sigmoid = function(x, gain = 1) {1 / (1 + exp(-gain * x))}
set.seed(1930)
ks = data.frame(xmin_1 = seq(1,50), ymin = c(1), ymax = c(2),
                ymin_2 = c(3), ymax_2 = c(4)) |>
  dplyr::mutate(
    xmax_1 = xmin_1 + 0.9,
    is_fg = (rbinom(50, 1L, sigmoid(25-xmin_1, 0.1))) |> as.character(),
    is_bg = rbinom(n = 50, size = 1, prob = 0.3) |> as.character(),
    is_bg = dplyr::if_else(is_bg == "1", "2", "0")
  )
ggplot(ks) +
  geom_rect(aes(xmin = xmin_1, xmax = xmax_1, ymin = ymin, ymax = ymax, fill = is_bg)) +
  geom_rect(aes(xmin = xmin_1, xmax = xmax_1, ymin = ymin_2, ymax = ymax_2, fill = is_fg)) +
  geom_text(x = 25, y = 0, label = "p-value, etc.", size = 5, color = "#444444") +
  geom_text(x = 1, y = 0, label = "High", size = 5, color = "#444444") +
  geom_text(x = 50, y = 0, label = "Low", size = 5, color = "#444444") +
  geom_segment(aes(x = 32, y = 0, xend = 45, yend = 0), arrow = arrow(type = "closed", length = unit(0.1, "inches")), color = "#444444") +
  geom_segment(aes(x = 18, y = 0, xend = 5, yend = 0), arrow = arrow(type = "closed", length = unit(0.1, "inches")), color = "#444444") +
  ylim(0, 4) +
  scale_fill_manual(values = c("#cccccc", "#4575B4", "#91BFDB"),
                    labels = c("Gene", "GO/Pathway X → Enrich", "GO/Pathway Y → Not enrich")) +
  theme_minimal() +
  theme(
    legend.title = element_blank(),
    legend.justification = c(0, 1),
    axis.title = element_blank(),
    axis.text = element_blank(),
    panel.grid = element_blank()
  )


## Fisher enrichment analysis -----

fs = data.frame(
  xmin = c(seq(1,20), seq(30,70)),
  ymin = c(1), ymax = c(2),
  ymin2 = c(3), ymax2 = c(4)
  ) |>
  dplyr::mutate(
    xmax = xmin + 0.9,
    is_x = dplyr::if_else(xmin<18 | (xmin>=30 & xmin < 34), "x", "n"),
    is_y = dplyr::if_else(xmin<5 | (xmin>=30 & xmin < 39), "y", "n") 
  )

ggplot(fs) +
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = is_y)) +
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin2, ymax = ymax2, fill = is_x)) +
  geom_vline(xintercept = 26, linetype = "dashed", color = "#cccccc") +
  annotate("text", x = 10, y = 5, label = "Genes with CAAS", color = "#444444") +
  annotate("text", x = 50, y = 5, label = "Genes without CAAS", color = "#444444") +
  scale_fill_manual(
    values = c("#cccccc", "#4575B4", "#91BFDB"),
    labels = c("Gene", "GO/Pathway X → Enrich", "GO/Pathway Y → Not enrich")
  ) +
  theme_minimal() +
  theme(
    legend.title = element_blank(),
    legend.justification = c(0, 1),
    axis.title = element_blank(),
    axis.text = element_blank(),
    panel.grid = element_blank()
  )


## draw Venn Diagram using ggplot ----
df_venn = data.frame(
  circle = c("A", "B"),
  x = c(-5, 5),
  y = c(0, 0)
)
rer_only = "False positives due to different tree topology"
paml_only = "Overestimation due to dS saturation"
ggplot(df_venn, aes(x, y)) +
  geom_point(aes(color = circle), alpha = 0.3, size = 100) +
  scale_color_manual(values = c("#009E73", "#0072B2")) +
  annotate("text", x = -15, y = 20, label = "RERconverge", size = 5) +
  annotate("text", x = 15, y = 20, label = "PAML", size = 5) +
  geom_segment(aes(x = 15, y = 0, xend = 25, yend = -10)) +
  geom_segment(aes(x = -15, y = 0, xend = -25, yend = -10)) +
  annotate("text", x = -30, y = -12, label = rer_only, size = 4) + 
  annotate("text", x = 30, y = -12, label = paml_only, size = 4) + 
  xlim(-40, 40) +
  ylim(-20, 20) +
  # theme_void() +
  theme_minimal() +
  theme(
    legend.position = "none",
    text = element_text(family = "sunserif", face = "bold", color = "#444444")
  )


## Schedule -----

df = data.frame(
  date = lubridate::ymd(c("2023-12-22", "2023-12-25", 
                          "2023-12-27", "2023-12-27", "2024-01-09")),
  y = c(1, 1, 1, 2, 1),
  event = c("セミナー", "2P要旨仕上げる", "2P要旨提出",
            "修論修正仕上げる", "修論提出")
)

ggplot(df) +
  aes(date, y) +
  geom_text(aes(label = event)) +
  scale_x_date(date_breaks = "3 day",
               date_labels = "%m/%d",
               minor_breaks = "1 day") +
  ylim(0,3) +
  theme_classic() +
  theme(
    axis.title = element_blank(),
    axis.text.y = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank()
  )


## Evolution of aging -----

rp_success = function(age, mat) {
  return(
    dplyr::if_else(age < mat, 0, age)
  )
}

df = data.frame(age = seq(1,100)) |> 
  dplyr::mutate(rp_success = rp_success(age, 20))

ggplot(df) +
  aes(x = age) +
  geom_bar(y = rp_success)


## Oxygen level -----

tr = "(((((Birds:150,Dinosaurs:84):94.8,Alligators:244.8):35,Lizards:279.8):39.1,((Bats:81,Ferungulata:81):13,Human:94):224.9):0);"
tr = ape::read.tree(text = tr) |>
  ggtree() +
  xlim(-20,378) +
  geom_tiplab() +
  theme_tree2()

ox = data.frame(
  Mya = c(318, 299, 252, 201, 190, 145, 66, 26, 0),
  o2 = c(16, 28, 30, 14, 11, 15, 19, 20, 21)
  ) |> 
  ggplot() + 
  aes(x = Mya, y = o2) +
  geom_area(fill = "#0072B288") +
  scale_x_reverse(limits = c(318, -60)) +
  labs(y = expression(paste({O[2]}, " Level (%)"))) +
  theme_classic()

cowplot::plot_grid(tr, ox, nrow = 2)
