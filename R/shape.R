library(conflicted)
library(tidyverse)

df_shape = dplyr::tibble(n = seq(1, 25), x = letters[n], y = 1)
ggplot(df_shape) + 
  aes(x, y) + 
  geom_point(aes(shape = x), fill = "blue", size = 5) +
  geom_text(aes(y = .5, label = n)) +
  scale_shape_manual(values = df_shape$n) +
  scale_y_continuous(limits = c(0, 1.5)) +
  theme_void() +
  theme(legend.position = "none")
