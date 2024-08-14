library(conflicted)
library(tidyverse)

file_path = "240712_azabu2020_mid_cage_GOBPALL.txt"

raw_data = readr::read_lines(file_path)
split_indices = grep("^Annotation", raw_data)
tables = split(raw_data, cumsum(seq_along(raw_data) %in% split_indices))

full_go_table = lapply(tables, function(table) {
    table_data = read.table(text = paste(table, collapse = "\n"), sep = "\t", skip = 1, header = TRUE)
    return(table_data |> dplyr::as_tibble())
  }) |>
  dplyr::bind_rows() |>
  tidyr::separate(Term, into = c("go_id", "description"), sep = "~") |>
  dplyr::distinct(go_id, .keep_all = TRUE) |>
  dplyr::mutate(gene_ratio = `X.`/100)

go_for_plot = full_go_table |>
  dplyr::filter(PValue < 0.02) |>    # P-value でフィルタリング
  dplyr::filter(Pop.Hits < 1000) |>  # 遺伝子数の多すぎるGOを除外
  dplyr::mutate(description = forcats::fct_reorder(description, gene_ratio))

ggplot(go_for_plot) +
  aes(x = gene_ratio, y = description, color = PValue, size = Count) +
  geom_point() +
  scale_color_viridis_c(option = "D") +
  labs(x = "Gene Ratio", y = "", color = "P-value", size = "Count") +
  theme_bw(base_size = 18)
