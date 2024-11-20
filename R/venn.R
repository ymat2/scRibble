library(conflicted)
library(tidyverse)


setA = stringr::str_c("gene", as.character(sample(100, 45)), sep = "_")
setB = stringr::str_c("gene", as.character(sample(100, 55)), sep = "_")


##### 1 ##### VennDiagram

library(VennDiagram)

data = list(setA = setA, setB = setB)
vd1 = VennDiagram::venn.diagram(
  data, 
  filename = NULL, 
  disable.logging = TRUE, 
  height =3000, 
  width = 3000, 
  resolution = 500, 
  # imagetype = "tiff", 
  units = "px", 
  na = "stop", 
  main = "Here is the title", 
  sub = "Here is subtitle", 
  main.pos = c(0.5, 1.05), 
  main.fontface = "plain",
  main.fontfamily = "serif", 
  main.col = "black",
  main.cex = 1, 
  main.just = c(0.5, 1), 
  sub.pos = c(0.5, 1.05), 
  sub.fontface = "plain", 
  sub.fontfamily = "serif", 
  sub.col = "black", 
  sub.cex = 1, 
  sub.just = c(0.5, 1), 
  category.names = c("Gene set A", "Gene set B"), 
)

grid.draw(vd1)


##### 2 ##### ggvenn

library(ggvenn)

data = list(setA = setA, setB = setB)
vd2 = ggvenn::ggvenn(
  data,
  columns = c("setA", "setB"),
  show_elements = FALSE,
  show_percentage = FALSE,
  digits = 1,
  fill_color = c("blue", "yellow", "green", "red"),
  fill_alpha = 0.5,
  stroke_color = "black",
  stroke_alpha = 1,
  stroke_size = 1,
  stroke_linetype = "solid",
  set_name_color = "black",
  set_name_size = 6,
  text_color = "black",
  text_size = 4,
  label_sep = ",",
  count_column = NULL,
  show_outside = "none",
  auto_scale = TRUE
)

vd2


##### 3 ##### ggVennDiagram

library("ggVennDiagram")

data = list(setA = setA, setB = setB)
vd3 = ggVennDiagram::ggVennDiagram(
  data,
  category.names = c("Gene set A", "Gene set B"),
  show_intersect = FALSE,
  set_color = "black",
  set_size = NA,
  label = "count",
  label_alpha = 0.5,
  label_geom = "label",
  label_color = "black",
  label_size = NA,
  label_percent_digit = 0,
  label_txtWidth = 40,
  edge_lty = "solid",
  edge_size = 1,
  force_upset = FALSE,
  nintersects = 20,
  order.intersect.by = "size",
  order.set.by = "size",
  relative_height = 3,
  relative_width = 0.3
) + scale_fill_viridis_c()

vd3
