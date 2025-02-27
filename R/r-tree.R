library(conflicted)
library(tidyverse)
library(phytools)
library(ggtree)


## make some node as unrooted tree

set.seed(222)
phy = ape::rtree(n = 4, rooted = FALSE, br = runif(n = 4) |> round(digits = 3))
write.tree(phy, file = "")

ggtree::ggtree(phy) + 
  ggtree::geom_nodelab(aes(label = node), hjust = -.1) +
  geom_tiplab(hjust = -.1)

phy2 = ape::root(phy, node = 6, resolve.root = TRUE)
write.tree(phy2, file = "")

ggtree::ggtree(phy2) + 
  ggtree::geom_nodelab(aes(label = node), hjust = -.1) +
  geom_tiplab(hjust = -.1)

phy3 = reroot(phy, node.number = 6, position = .1)
write.tree(phy3, file = "")
ggtree::ggtree(phy3) + 
  ggtree::geom_nodelab(aes(label = node), hjust = -.1) +
  geom_tiplab(hjust = -.1)

