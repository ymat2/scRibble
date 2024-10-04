install.packages(c("sf", "raster", "geodata", "mapview", "maptools"), dependencies = TRUE)

library(conflicted)
library(tidyverse)
library(sf)
library(raster)
library(geodata)
# library(mapview)
# library(maptools)


## ラスタデータのダウンロード
geodata::worldclim_global(path = "data/", var = "bio", res = 10, version = "2.1")  # worldclimデータのダウンロード
tif_files = list.files("data/wc2.1_10m", pattern = "tif$", full.names = TRUE)  # data/wc2.1_10内のファイルリストを取得

## データの読み込み
bio1 = raster::raster("data/wc2.1_10m/wc2.1_10m_bio_1.tif")  # ラスタデータの読み込み(年平均気温)
habitat = sf::st_read("data/gallus_gallus_habitats/data_0.shp")  # ベクタデータの読み込み

## ベクタデータの統計量
center = sf::st_centroid(habitat$geometry) |> print()  # 各領域の重心
area = sum(sf::st_area(habitat$geometry)) |> print()  # 総面積

## ラスタレイヤからベクタ領域を切り抜く
shp = as(habitat, "Spatial")
bio1_in_habitat = raster::mask(bio1, mask = shp)
plot(bio1_in_habitat)  # base::plotで可視化

bio1_val = bio1_in_habitat |>  # 数値をベクタとして抜き出す
  raster::getValues() |>
  na.omit() |>
  as.vector()
head(val1)
mean(val1)  # 年平均気温の生息地平均
max(val1) - min(val1)  # 年平均気温の範囲
