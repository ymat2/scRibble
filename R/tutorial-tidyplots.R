library(conflicted)
library(tidyverse)
library(tidyplots)
library(myrrr)


p1 = iris |>
  tidyplot(x = Species, y = Petal.Width, color = Species) |>
  add_boxplot(alpha = 1, color = "#333333", show_outliers = FALSE) |>
  add_data_points_jitter(jitter_width = 1, color = "#333333", alpha = .5, shape = 16) |>
  adjust_colors(colors_discrete_okabeito[1:3]) |>
  remove_legend() |>
  add_test_pvalue() |>
  remove_caption()

class(p1)
# [1] "patchwork" "tidyplot"  "gg"        "ggplot" 

p2 = iris |>
  tidyplot(x = Sepal.Length, y = Sepal.Width, color = Species) |>
  add_data_points(alpha = .5, shape = 16) |>
  adjust_colors(colors_discrete_okabeito[1:3]) |>
  remove_legend()

p3 = iris |>
  tidyplot(x =Petal.Length, color = Species) |>
  add_histogram(binwidth = .6) |>
  adjust_colors(colors_discrete_okabeito[1:3]) |>
  remove_legend()

cowplot::plot_grid(p1, p2, p3, nrow = 1, labels = letters[1:3]) |>
  save_plot("images/sample_tidyplots.png", width = 200, height = 200/3, bg = "#FFFFFF")


f1 = iris |>
  tidyplot(x = Sepal.Length, y = Sepal.Width, color = Species) |>
  add_data_points(shape = 16, alpha = .5) |>
  add_curve_fit(method = "lm", formula = "y~x", se = FALSE) |>
  adjust_colors(palette.colors(n = 8, palette = "R4")[-1][1:3]) |>
  theme_ggplot2() |>
  remove_x_axis_ticks() |>
  remove_y_axis_ticks() |>
  adjust_legend_position(position = "top")

f2 = diamonds |>
  tidyplot(x = price) |>
  add_histogram(fill = "orange", bins = 30) |>
  add_title(title = "Distribution of diamonds price") |>
  adjust_font(fontsize = 9) +
  ggplot2::theme_bw()

f3 = mpg |>
  tidyplot(x = class, y = cty, color = class) |>
  add_boxplot(alpha = .9, color = "#333333", show_outliers = FALSE) |>
  add_data_points_jitter(shape = 16, color = "#333333", alpha = .5) |>
  adjust_colors(colors_continuous_turbo) |>
  flip_plot() |>
  remove_legend()

cowplot::plot_grid(f1, f2, f3, ncol = 3)


# using custom color schemes

mpg |>
  tidyplot(x = class, y = cty, color = class) |>
  add_boxplot(alpha = .9, color = "#333333", show_outliers = FALSE) |>
  adjust_colors(myrrr::colors_discrete_set2) |>
  adjust_size(width = 100, height = 100) +
  ggplot2::theme_test()


# legend position: position is passed to ggplot2::theme(legend.position = position)

piris = iris |>
  tidyplot(x = Sepal.Length, Sepal.Width, color = Species) |>
  add_data_points() |>
  adjust_size(width = 100, height = 100)

piris |> adjust_legend_position("top")
piris |> adjust_legend_position("left")
piris |> adjust_legend_position("bottom")
piris |> adjust_legend_position("none")
piris |> adjust_legend_position("inside")  # piris + ggplot2::theme(legend.position = "inside")
piris |> adjust_legend_position("inside") + ggplot2::theme(legend.justification = c(0, 0))
piris |> adjust_legend_position("inside") + ggplot2::theme(legend.justification = c(1, 0))
piris |> adjust_legend_position("inside") + ggplot2::theme(legend.justification = c(0, 1))
piris |> adjust_legend_position("inside") + ggplot2::theme(legend.justification = c(1, 1))

