library(VennDiagram)

# サンプルデータ
set.seed(20190708)
genes <- paste("gene",1:1000,sep="")
x <- list(
  A = sample(genes,300), 
  B = sample(genes,525), 
  C = sample(genes,440),
  D = sample(genes,350)
)

# ベン図を描画
venn.plot <- VennDiagram::venn.diagram(
  x,
  category.names = c("Group 1", "Group 2"),
  filename = NULL
)

# 描画
grid.draw(venn.plot)


library(ggvenn)

ggvenn::ggvenn(
  data = x,
  columns = c("A", "B"),
  show_elements = FALSE,
  show_percentage = FALSE,
  stroke_size = 0.5,
  stroke_linetype = "solid",
  # fill_color = c("darkorange", "blue"),
  set_name_color = "red",
  set_name_size = 5,
  text_color = "#444444",
  text_size = 8,
  auto_scale = FALSE
) + scale_fill_viridis_d()
