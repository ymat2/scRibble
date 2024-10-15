library(conflicted)
library(tidyverse)


p8 = dplyr::tibble(x = seq(1, 8), y = 1, fill = letters[1:8]) |>
  ggplot() + aes(x, y, fill = fill) + geom_tile() + theme_void() + 
  theme(legend.position = "none")
p9 = dplyr::tibble(x = seq(1, 9), y = 1, fill = letters[1:9]) |>
  ggplot() + aes(x, y, fill = fill) + geom_tile() + theme_void() + 
  theme(legend.position = "none")
p10 = dplyr::tibble(x = seq(1, 10), y = 1, fill = letters[1:10]) |>
  ggplot() + aes(x, y, fill = fill) + geom_tile() + theme_void() + 
  theme(legend.position = "none")
p11 = dplyr::tibble(x = seq(1, 11), y = 1, fill = letters[1:11]) |>
  ggplot() + aes(x, y, fill = fill) + geom_tile() + theme_void() + 
  theme(legend.position = "none")
p12 = dplyr::tibble(x = seq(1, 12), y = 1, fill = letters[1:12]) |>
  ggplot() + aes(x, y, fill = fill) + geom_tile() + theme_void() + 
  theme(legend.position = "none")


## default descrete color scales

p12 + scale_fill_brewer(palette = "Set3")
p8 + scale_fill_brewer(palette = "Set2")
p9 + scale_fill_brewer(palette = "Set1")
p8 + scale_fill_brewer(palette = "Pastel2")
p9 + scale_fill_brewer(palette = "Pastel1")
p12 + scale_fill_brewer(palette = "Paired")
p8 + scale_fill_brewer(palette = "Dark2")
p8 + scale_fill_brewer(palette = "Accent")

p11 + scale_fill_brewer(palette = "Spectral")
p11 + scale_fill_brewer(palette = "RdBu")
p11 + scale_fill_brewer(palette = "PRGn")
p11 + scale_fill_brewer(palette = "PiYG")
p11 + scale_fill_brewer(palette = "BrBG")

p8 + scale_fill_discrete(type = palette.colors(n = 8, "R3"))
p8 + scale_fill_discrete(type = palette.colors(n = 8, "R4"))
p8 + scale_fill_discrete(type = palette.colors(n = 8, "ggplot2"))
p9 + scale_fill_discrete(type = palette.colors(n = 9, "Okabe-Ito"))
p10 + scale_fill_discrete(type = palette.colors(n = 10, "Tableau 10"))
p10 + scale_fill_discrete(type = palette.colors(n = 10, "Classic Tableau"))
p12 + scale_fill_discrete(type = palette.colors(n = 36, "Polychrome 36"))
p12 + scale_fill_discrete(type = palette.colors(n = 26, "Alphabet"))

p9 + scale_fill_viridis_d(option = "A")
p9 + scale_fill_viridis_d(option = "B")
p9 + scale_fill_viridis_d(option = "C")
p9 + scale_fill_viridis_d(option = "D")
p9 + scale_fill_viridis_d(option = "E")
p9 + scale_fill_viridis_d(option = "F")
p9 + scale_fill_viridis_d(option = "G")
p9 + scale_fill_viridis_d(option = "H")


## Color codes

RColorBrewer::brewer.pal(n = 12, name = "Set3")
RColorBrewer::brewer.pal(n = 8, name = "Set2")
RColorBrewer::brewer.pal(n = 9, name = "Set1")
RColorBrewer::brewer.pal(n = 8, name = "Pastel2")
RColorBrewer::brewer.pal(n = 9, name = "Pastel1")
RColorBrewer::brewer.pal(n = 12, name = "Paired")
RColorBrewer::brewer.pal(n = 8, name = "Dark2")
RColorBrewer::brewer.pal(n = 8, name = "Accent")

RColorBrewer::brewer.pal(n = 11, name = "Spectral")
RColorBrewer::brewer.pal(n = 11, name = "RdBu")
RColorBrewer::brewer.pal(n = 11, name = "PRGn")
RColorBrewer::brewer.pal(n = 11, name = "PiYG")
RColorBrewer::brewer.pal(n = 11, name = "BrBG")

palette.colors(palette = "R3")
palette.colors(palette = "R4")
palette.colors(palette = "ggplot2")
palette.colors(palette = "Okabe-Ito")
palette.colors(palette = "Tableau 10")
palette.colors(palette = "Classic Tableau")
palette.colors(palette = "Polychrome 36")
palette.colors(palette = "Alphabet")


## As table

prefix="<span style='font-size:1.2rem; color:"
suffix=";'>&#9632;</span>"
dplyr::tibble(code = viridis::viridis(n = 9, option = "E")) |>
  dplyr::mutate(color = stringr::str_c(prefix, code, suffix)) |>
  knitr::kable()

palette.colors(palette = "Okabe-Ito")
viridis::viridis(n = 9, option = "D")
viridis::viridis(n = 9, option = "E")
