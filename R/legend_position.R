library(conflicted)
library(tidyverse)


g = ggplot(data.frame(x=1), aes(x, x, color = 'a')) +
  geom_point(alpha = 0) +
  theme_gray(base_size = 12) +
  theme(
    legend.background = element_rect(fill = 'red'),
    legend.key = element_blank(),
    legend.text = element_blank(),
    legend.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    plot.margin = margin(12, 12, 12, 12)
  ) +
  scale_x_continuous(position = 'top', sec.axis = sec_axis(~., name = '\n')) +
  scale_y_continuous(sec.axis = sec_axis(~., name = '\n'))

g + theme(
  legend.position = "inside",
  legend.position.inside = c(.2, .2)
)



