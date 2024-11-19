library(conflicted)
library(tidyverse)
library(tidyplots)


p1 = iris |>
  tidyplot(x = Species, y = Petal.Width, color = Species) |>
  add_boxplot() |>
  add_data_points_jitter(jitter_width = 1) |>
  adjust_colors(colors_discrete_okabeito[1:3]) |>
  remove_legend() |>
  add_test_pvalue() |>
  remove_caption()

class(p1)
# [1] "patchwork" "tidyplot"  "gg"        "ggplot" 

p2 = iris |>
  tidyplot(x = Sepal.Length, y = Sepal.Width, color = Species) |>
  add_data_points(alpha = .5) |>
  adjust_colors(colors_discrete_okabeito[1:3]) |>
  remove_legend()

p3 = iris |>
  tidyplot(x =Petal.Length, color = Species) |>
  add_count_bar(width = 1) |>
  adjust_colors(colors_discrete_okabeito[1:3]) |>
  remove_legend()

cowplot::plot_grid(p1, p2, p3, nrow = 1, labels = letters[1:3]) |>
  save_plot("images/sample_tidyplots.png", width = 200, height = 200/3, bg = "#FFFFFF")

