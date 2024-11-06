library(conflicted)
library(tidyverse)


pl1 = ggplot(mpg) +
  aes(displ, cty) +
  geom_point(aes(color = cyl)) +
  scale_color_viridis_c(option = "D") +
  theme_test(base_size = 16)

pl2 = ggplot(iris) +
  aes(Species, Sepal.Width) +
  geom_boxplot(aes(fill = Species)) +
  scale_fill_brewer(palette = "Set2") +
  theme_bw(base_size = 16)

pl3 = ggplot(diamonds) +
  aes(price) +
  geom_histogram(fill = "#555555") +
  theme_classic(base_size = 16)

image = cowplot::ggdraw() + 
  cowplot::draw_image("images/favicon.png", scale = 0.9)

cowplot::plot_grid(image, pl1, pl2, pl3, nrow = 2, labels = letters[1:4])
