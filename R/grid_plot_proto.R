library(conflicted)
library(tidyverse)
library(tidyplots)


plot = diamonds |>
  dplyr::mutate(clarity = stringr::str_remove(clarity, "[1-9]")) |>
  tidyplot(x = carat, y = price, color = color) |>
  add_data_points(shape = 16, alpha = .5) |>
  adjust_colors(colors_continuous_viridis)

plot |>
  adjust_size(width = 100, height = 100) + 
  ggplot2::facet_grid(rows = vars(cut), cols = vars(clarity))
  # これでいいじゃん...

df <-
  plot$data %>%
  dplyr::group_by(cut, clarity) %>%
  tidyr::nest()

dfp =
  df |>
  dplyr::mutate(plot = purrr::map(
    data, ~ ggplot(.x) + aes(x = carat, y = price) + geom_point()
  ))

plots_per_page <- length(unique(df$cut)) * length(unique(df$clarity))




diamonds |> dplyr::group_by(cut, clarity) |> tidyr::nest()

grid_plot = function(plot, rows = NULL, cols = NULL,
                     widths = 30, heights = 25, guides = "collect",
                     tag_level = NULL, design = NULL, unit = "mm") {
  plot <- check_tidyplot(plot)
  if(missing(by))
    cli::cli_abort("Argument {.arg by} missing without default.")
  
  # free plot dimensions
  plot <-
    plot %>%
    adjust_size(width = NA, height = NA)
  )

  df <-
    plot$data %>%
    dplyr::group_by({{rows}}, {{cols}}) %>%
    tidyr::nest()
  
  plots = 
    purrr::
}