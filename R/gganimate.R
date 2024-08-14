library(conflicted)
library(tidyverse)
library(gganimate)


simTrait = function(i, g, sigma) {
  
  # i: initial trait value
  # g: number of generations
  # sigma: sigma
  
  trait = numeric(g)
  trait[1] = i
  tmp = i
  
  for (n in 2:g) {
    upd = rnorm(n = 1, mean = tmp, sd = sqrt(sigma))
    tmp = upd
    trait[n] = upd
  }
  
  return(trait)
}


sample_data = dplyr::tibble(
  g = seq(1, 1000),
  v1 = simTrait(i = 25, g = 1000, sigma = 0.01),
  v2 = simTrait(i = 25, g = 1000, sigma = 0.05),
  ) |>
  tidyr::pivot_longer(2:3, names_to = "pop", values_to = "v")



p = ggplot(sample_data) +
  aes(x = g, y = v, color = pop) +
  geom_line(linewidth = 1, alpha = .5) +
  scale_color_brewer(palette = "Set1") +
  scale_y_continuous(limits = c(0, 50)) +
  labs(x = "Generation", y = "Trait value") +
  theme_bw(base_size = 20) +
  theme(legend.position = "none")
p

p_anime = p + gganimate::transition_reveal(along = g)

gganimate::anim_save("images/gganim-sample.gif", p_anime)
