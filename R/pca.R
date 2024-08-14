library(conflicted)
library(tidyverse)
        

pca = prcomp(df)
pca = prcomp(df, scale. = TRUE)

pca = princomp(df)
pca = princomp(df, cor = TRUE)

biplot(pca)


# install.packages("ggbiplot")
library(ggbiplot)

ggbiplot(pca, groups = iris$Species, scale = F)


###########

set.seed(1234)

df_leghron = tibble::tibble(
  id = paste0("Leghorn", 1:5),
  subspecies = "Leghorn",
  body_mass_g = rnorm(n = 5, mean = 3000, sd = 500),
  n_crowing = rpois(n = 5, 5),
  bmi = rnorm(n = 5, mean = 1/200, sd = 5/10000),
  body_height_cm = body_mass_g * bmi,
  egg_mass_g = rnorm(n = 5, mean = 65, sd = 3)
)

df_shamo = tibble::tibble(
  id = paste0("Shamo", 1:5),
  subspecies = "Shamo",
  body_mass_g = rnorm(n = 5, mean = 4500, sd = 100),
  n_crowing = rpois(n = 5, 1),
  bmi = rnorm(n = 5, mean = 1/150, sd = 5/10000),
  body_height_cm = body_mass_g * bmi * 1.1,
  egg_mass_g = rnorm(n = 5, mean = 70, sd = 4)
)

df_chabo = tibble::tibble(
  id = paste0("Chabo", 1:5),
  subspecies = "Chabo",
  body_mass_g = rnorm(n = 5, mean = 700, sd = 50),
  n_crowing = rpois(n = 5, 2),
  bmi = rnorm(n = 5, mean = 1/35, sd = 5/1000),
  body_height_cm = body_mass_g * bmi * 0.75,
  egg_mass_g = rnorm(n = 5, mean = 60, sd = 2)
)

df_chicken = dplyr::bind_rows(df_leghron, df_shamo, df_chabo) |>
  dplyr::select(!bmi)

df4pca = df_chicken |> dplyr::select(where(is.numeric))

pca = prcomp(df4pca, scale. = FALSE)
pca = prcomp(df4pca, scale. = TRUE)

biplot(pca)
ggbiplot(pca, groups = df_chicken$subspecies, scale = F)


#####

mid_tmm = readr::read_csv("./mid_TMM_logcpm.csv")
mid_tmm2 = mid_tmm |>
  tidyr::pivot_longer(-id) |>
  tidyr::pivot_wider(names_from=id, values_from=value) |>
  dplyr::mutate(dplyr::across(dplyr::starts_with("ENSGAL"), as.numeric))
mid_tmm4box = mid_tmm2 |>
  dplyr::select(name, systems, ENSGALG00000000081_IL4I1)

ggplot(mid_tmm4box) +
  aes(x = systems, y = ENSGALG00000000081_IL4I1) +
  geom_boxplot() +
  geom_jitter()

is_constant <- function(x) {
  all(x == x[1])
}

# すべての行が同じ値である列を除く
df <- mid_tmm2 |> dplyr::select(where(~ !is_constant(.)))
pca_result = prcomp(mid_tmm2 |> dplyr::select(dplyr::starts_with("ENSGAL")))
ggbiplot::ggbiplot(pca_result, var.axes = FALSE, groups = mid_tmm2$systems, labels = mid_tmm2$name, scale = 1)
