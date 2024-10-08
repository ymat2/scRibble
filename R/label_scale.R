library(conflicted)
library(tidyverse)

default = tibble(y = seq(1000000, 10000000, 1000000), x = seq(1, 10, 1)) |>
  ggplot() +
  aes(x, y) +
  geom_point() +
  theme_classic(base_size = 18) +
  theme(legend.position = "none", axis.title = element_blank())
default

default + scale_y_continuous(labels = scales::label_number())
default + scale_y_continuous(labels = scales::label_comma())
default + scale_y_continuous(labels = scales::label_number(scale = 1/1000, suffix = "k"))
default + scale_y_continuous(labels = scales::label_number(scale_cut = scales::cut_long_scale()))

default + scale_y_continuous(labels = scales::trans_format('log10', scales::math_format(10^.x)))


scientific_notation <- function(x) {
  x = format(x, scientific = TRUE)
  x = gsub("^(.*)e", "'\\1'e", x)
  x = gsub("e", "%*%10^", x)
  x = gsub('\\+', '', x)
  parse(text = x)
}

label_sci = function() scientific_notation

default + scale_y_continuous(labels = label_sci())
