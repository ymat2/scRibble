if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("topGO")
BiocManager::install("org.Hs.eg.db")

library(conflicted)
library(tidyverse)
library(topGO)
library(org.Hs.eg.db)


entrez_ids = mappedkeys(org.Hs.egGO)
scores = runif(length(entrez_ids), 0, 1)
# scores = rnorm(length(entrez_ids), 0, 0.4)
named_scores = setNames(scores, entrez_ids)

tg_data = new(
  "topGOdata",
  ontology="BP",
  allGenes=named_scores,
  geneSelectionFun=function(x) {x < 0.01},
  # geneSelectionFun=function(x) {abs(x) > 1},
  # geneSelectionFun=function(x) {logical(length(x))},
  nodeSize=10,
  annotationFun=annFUN.org,
  mapping="org.Hs.eg.db",
  ID="entrez")

whichAlgorithms()
whichTests()
so="increasing"
resClassicFisher = runTest(tg_data, algorithm="classic", statistic="fisher", sortOrder=so)
resElimFisher = runTest(tg_data, algorithm="elim", statistic="fisher", sortOrder=so)
resWeightFisher = runTest(tg_data, algorithm="weight", statistic="fisher", sortOrder=so)
resClassicKS = runTest(tg_data, algorithm="classic", statistic="ks", sortOrder=so)
resElimKS = runTest(tg_data, algorithm="elim", statistic="ks", sortOrder=so)
resWeightKS = runTest(tg_data, algorithm="weight01", statistic="ks", sortOrder=so)

annoStat = termStat(tg_data, sort(tg_data@graph@nodes)) |>
  tibble::rownames_to_column(var = "GO.ID") |>
  tibble::as_tibble() |>
  dplyr::mutate(Term=topGO:::.getTermsDefinition(GO.ID, ontology(tg_data), 65535L)) |>
  dplyr::relocate(Term, .after=GO.ID) |>
  print()

tg_table = annoStat |> dplyr::mutate(
    classicFisher=score(resClassicFisher, whichGO=GO.ID),
    elimFisher=score(resElimFisher, whichGO=GO.ID),
    weightFisher=score(resWeightFisher, whichGO=GO.ID),
    # classicKS=score(resClassicKS, whichGO=GO.ID),
    # elimKS=score(resElimKS, whichGO=GO.ID),
    # weightKS=score(resWeightKS, whichGO=GO.ID),
  ) |>
  print()
