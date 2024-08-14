library(conflicted)
library(tidyverse)
library(phytools)
library(ggtree)
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


sample_data = dplyr::tibble()
for (i in 1:30) {
  sig1 = dplyr::tibble(
    g = seq(1, 1000),
    v = simTrait(i = 25, g = 1000, sigma = 0.05),
    sigma = 0.05,
    rep = i
  )
  sample_data = dplyr::bind_rows(sample_data, sig1)
}
for (i in 31:60) {
  sig5 = dplyr::tibble(
    g = seq(1, 1000),
    v = simTrait(i = 25, g = 1000, sigma = 0.01),
    sigma = 0.01,
    rep = i
  )
  sample_data = dplyr::bind_rows(sample_data, sig5)
}


p = ggplot(sample_data) +
  aes(x = g, y = v, color = as.factor(sigma)) +
  geom_line(aes(group = rep), linewidth = 1, alpha = .5) +
  scale_color_brewer(palette = "Set1") +
  scale_y_continuous(limits = c(0, 50)) +
  labs(x = "Generation", y = "Trait value", color = expression(sigma)) +
  theme_bw(base_size = 20)
p

p_anime = p + gganimate::transition_reveal(along = rep)


## along tree

set.seed(1234)
tr = ape::rtree(n = 4, rooted = TRUE)
tr$edge.length = as.integer(1000 * tr$edge.length)

p_tree = ggtree(tr, linewidth = 1) +
  aes(color = as.factor(branch.length)) +
  geom_nodelab(aes(label = node), size = 5, hjust = -.5, node = "all", color = "#444444") +
  scale_color_viridis_d(option = "D") +
  theme(legend.position = "none")

tr$edge
tr$edge = cbind(tr$edge, 0, 0)
tr$edge.length

df = dplyr::tibble()
for (i in 1:nrow(tr$edge)) {
  bl = tr$edge.length[i]
  start_node = tr$edge[i, 1]
  end_node = tr$edge[i, 2]
  parent_node = which(tr$edge[, 2] == start_node)
  if (length(parent_node) > 0) {
    tmp = dplyr::tibble(
      g = seq(1, bl) + tr$edge[parent_node, 3],
      v = simTrait(i = 0, g = bl, sigma = 0.05) + tr$edge[parent_node, 4],
      b = bl
    )
  } else {
    tmp = dplyr::tibble(
      g = seq(1, bl),
      v = simTrait(i = 0, g = bl, sigma = 0.05),
      b = bl
    )
  }
  tr$edge[i, 3] = tmp$b[bl]
  tr$edge[i, 4] = tmp$v[bl]
  df = dplyr::bind_rows(df, tmp)
}

p_bm = ggplot(df) +
  aes(x = g, y = v, color = as.factor(b)) +
  geom_line(aes(group = b), linewidth = 1, alpha = .5) +
  scale_color_viridis_d(option = "D") +
  #scale_y_continuous(limits = c(0, 50)) +
  labs(x = "Generation", y = "Trait value", color = expression(sigma)) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none")

cowplot::plot_grid(p_tree, p_bm, nrow = 1)
