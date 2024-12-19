library(conflicted)
library(tidyverse)
library(GenomicRanges)


gr = GRanges(
  seqnames = c("1", "2", "3"),             # 染色体の名前
  ranges = IRanges(101:103, width = 100),  # 座標
  strand = c("-", "+", "*"),
  gene = c("geneA", "geneB", "geneC"),     # 任意のelementMetadata列
  seqinfo = NULL,
  seqlengths = c("1" = 249250621, "2" = 243199373, "3" = 248327478)
)
gr


fst = dplyr::tibble(
  chr = c("1", "2", "3"),
  BIN_START = c(151, 202, 121),
  BIN_END = c(200, 300, 200),
  FST = c(0.75, 0.11, 0.26)
)

gr_fst = GenomicRanges::makeGRangesFromDataFrame(
  fst,
  keep.extra.columns = TRUE,
  ignore.strand = TRUE,
  seqnames.field = "chr",
  start.field = "BIN_START",
  end.field = "BIN_END"
)
gr_fst


gr_gff = rtracklayer::import("tmp/simple.gff", format = "gff")
gr_gff

findOverlaps(gr_fst, gr, maxgap = -1L, minoverlap = 0L, type = "any", select = "all")
df_merge = mergeByOverlaps(gr_fst, gr, maxgap = -1L, minoverlap = 0L, type = "any", select = "all")
df_merge

df_merge |>
  dplyr::as_tibble() |> 
  dplyr::select(gr_fst.seqnames, gr_fst.start, gr_fst.end, FST, gene)
