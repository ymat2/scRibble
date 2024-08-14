library(conflicted)
library(tidyverse)

df = tibble::tibble(
  id = c("system", "ENSGAL1", "ENSGAL2", "ENSGAL3", "ENSGAL4", "ENSGAL5"),
  C1 = c("cage", 5, 5, 5, 5, 5),
  C2 = c("cage", 5, 5, 5, 5, 5),
  C3 = c("cage", 5, 5, 5, 5, 5),
  C4 = c("cage", 5, 5, 5, 5, 5),
  C5 = c("cage", 5, 5, 5, 5, 5)
)

df2 = df |>
  tidyr::pivot_longer(-id) |>
  tidyr::pivot_wider(names_from=id, values_from=value) |>
  dplyr::mutate(dplyr::across(dplyr::starts_with("ENSGAL"), as.numeric))
