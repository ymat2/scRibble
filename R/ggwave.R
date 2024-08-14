library(conflicted)
library(tidyverse)


## Generate dataframe from codon sequence

codon = "ATGTACCCCAGGGAGTGCATCUAGUGAAGC"
codon = strsplit(codon, split = "")[[1]]
n = length(codon)
x = seq(1, n)
y = rep(c(1), length.out = n)

df = data.frame(x = x, y = y, codon = codon) |>
  dplyr::mutate(
    peak_a = dplyr::if_else(codon == "A", 5, 1),
    peak_t = dplyr::if_else(codon %in% c("T", "U"), 5, 1),
    peak_g = dplyr::if_else(codon == "G", 5, 1),
    peak_c = dplyr::if_else(codon == "C", 5, 1),
    angle = 360-360*(x+2)/(n+4)
  )
df_add = data.frame(x = seq(0.5, n+0.5, by = 1), y = rep(c(1), length.out = n+1))
df_a = df |> dplyr::select(x, peak_a) |> dplyr::rename(y = peak_a) |> dplyr::bind_rows(df_add)
df_t = df |> dplyr::select(x, peak_t) |> dplyr::rename(y = peak_t) |> dplyr::bind_rows(df_add)
df_g = df |> dplyr::select(x, peak_g) |> dplyr::rename(y = peak_g) |> dplyr::bind_rows(df_add)
df_c = df |> dplyr::select(x, peak_c) |> dplyr::rename(y = peak_c) |> dplyr::bind_rows(df_add)


## Visualize using ggplot()

p = ggplot() +
  geom_line(data=data.frame(spline(df_a, n=n*20)), aes(x, y), color = "#E69F00") +
  geom_line(data=data.frame(spline(df_t, n=n*20)), aes(x, y), color = "#56B4E9") +
  geom_line(data=data.frame(spline(df_g, n=n*20)), aes(x, y), color = "#009E73") +
  geom_line(data=data.frame(spline(df_c, n=n*20)), aes(x, y), color = "#F0E442") +
  geom_text(data = df, aes(x = x, y = -1, label = codon, angle = angle, color = codon)) +
  scale_color_manual(values = c("white", "white", "white", "white", "#777777")) +
  coord_polar(start = 0) +
  xlim(-2, 32) +
  ylim(-10, 6) +
  theme_void() +
  theme(legend.position = "none")
  
ggsave(file = "images/myprecious.png", p, w = 5, h = 5, bg = "#000000")
