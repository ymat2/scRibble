library(conflicted)
library(tidyverse)

## Wright-Fisher model (take more minites) -----

pop_size = 1000
init_pop = c(
  rep(list(c(0, 0)), pop_size*.25),
  rep(list(c(0, 1)), pop_size*.5),
  rep(list(c(1, 1)), pop_size*.25)
)

generate_next_pop = function(pop) {
  N = length(pop)
  parent1_idx = sample.int(N, N, replace = TRUE)
  parent2_idx = sample.int(N, N, replace = TRUE)
  next_pop = vector("list", N)
  for (i in 1:N) {
    p1 = pop[[parent1_idx[i]]]
    p2 = pop[[parent2_idx[i]]]
    gamete_allele_1 = p1[sample.int(2, 1)]
    gamete_allele_2 = p2[sample.int(2, 1)]
    next_pop[[i]] = c(gamete_allele_1, gamete_allele_2)
  }
  return(next_pop)
}

calc_allele_freq = function(pop) {
  N = length(pop)
  af = sum(purrr::list_c(pop)) / (2*N)
  return(af)
}

number_of_generation = 1000
v_af = numeric(number_of_generation)
for (i in 1:number_of_generation) {
  init_pop = generate_next_pop(init_pop)
  .af = calc_allele_freq(init_pop)
  v_af[i] = .af
}

d_af = dplyr::tibble(
  g = 1:number_of_generation,
  af = v_af
)

ggplot(d_af) +
  aes(g, af) +
  geom_line(color = "darkorange", linewidth = 1, alpha = .5) +
  scale_y_continuous(limits = c(0, 1)) +
  labs(x = "Genarations", y = "Allele frequency") +
  theme_test(base_size = 14)


# Simple Wright-Fisher model -----

generate_next_pop = function(pop) {
  N = length(pop)
  next_pop = sample(rep(pop, 2), size = N)
  return(next_pop)
}

calc_allele_freq = function(pop) {
  N = length(pop)
  return(sum(pop) / N)
}

simulate_drift = function(pop_size = 1000, init_af = .5, g = 1000, iter = 1) {
  number_of_generation = g
  v_iter = numeric(number_of_generation * iter)
  v_gen = numeric(number_of_generation * iter)
  v_af = numeric(number_of_generation * iter)
  for (i in 1:iter) {
    .pop_size = pop_size
    .pop = c(rep(1, .pop_size * init_af), rep(0, .pop_size * init_af))
    for (j in 1:number_of_generation) {
      .pop = generate_next_pop(.pop)
      .af = calc_allele_freq(.pop)
      v_iter[i*j] = i
      v_gen[i*j] = j
      v_af[i*j] = .af
    }
  }
  df = dplyr::tibble(iter = v_iter, g = v_gen, af = v_af)
  return(df)
}

d_af = simulate_drift(pop_size = 5000, iter = 10)

ggplot(d_af) +
  aes(g, af) +
  geom_line(aes(group = iter), color = "darkorange", linewidth = 1, alpha = .5) +
  scale_y_continuous(limits = c(0, 1)) +
  labs(x = "Genarations", y = "Allele frequency") +
  theme_test(base_size = 14)
