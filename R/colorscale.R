library(conflicted)
library(tidyverse)


df = dplyr::tibble(xx = seq(1, 8), yy = 1, zz = letters[1:8])
p = ggplot(df) + aes(xx, yy, fill = zz) + geom_tile() + theme_void()

## default descrete color scales
p
p + scale_fill_brewer(palette = "Set3")
p + scale_fill_brewer(palette = "Set2")
p + scale_fill_brewer(palette = "Set1")
p + scale_fill_brewer(palette = "Pastel2")
p + scale_fill_brewer(palette = "Pastel1")
p + scale_fill_brewer(palette = "Paired")
p + scale_fill_brewer(palette = "Dark2")
p + scale_fill_brewer(palette = "Accent")

p + scale_fill_discrete(type = palette.colors(n = 8, "R3"))
p + scale_fill_discrete(type = palette.colors(n = 8, "R4"))
p + scale_fill_discrete(type = palette.colors(n = 8, "ggplot2"))
p + scale_fill_discrete(type = palette.colors(n = 8, "Okabe-Ito"))
p + scale_fill_discrete(type = palette.colors(n = 8, "Tableau 10"))
p + scale_fill_discrete(type = palette.colors(n = 8, "Classic Tableau"))
p + scale_fill_discrete(type = palette.colors(n = 8, "Polychrome 36"))
p + scale_fill_discrete(type = palette.colors(n = 8, "Alphabet"))

p + scale_fill_viridis_d(option = "A")
p + scale_fill_viridis_d(option = "B")
p + scale_fill_viridis_d(option = "C")
p + scale_fill_viridis_d(option = "D")
p + scale_fill_viridis_d(option = "E")
p + scale_fill_viridis_d(option = "F")
p + scale_fill_viridis_d(option = "G")
p + scale_fill_viridis_d(option = "H")


## User defined color scale

