library(conflicted)
library(tidyverse)


world_map = ggplot2::map_data("world") |> dplyr::as_tibble()

## Map of Japan

ja_map = world_map |> dplyr::filter(region == "Japan")
pja = ggplot(ja_map) +
  aes(long, lat) +
  geom_map(
    aes(map_id = region),
    fill = "#BBBBBB",
    map = ja_map,
    linewidth = 0
  ) +
  coord_fixed() +
  theme_void()
pja
ggsave("images/japan.png", pja, w = 7, h = 7)

View(ja_map)

## Map of Southeast Asia

psea = ggplot(world_map) +
  aes(long, lat) +
  geom_map(
    aes(map_id = region),
    fill = "#BBBBBB",
    map = world_map,
    linewidth = 0
  ) +
  scale_x_continuous(limits = c(90, 150)) +
  scale_y_continuous(limits = c(0, 50)) +
  coord_fixed() +
  theme_void()
psea
ggsave("images/asia.png", psea, w = 6, h = 5)
