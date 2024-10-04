library(conflicted)
library(tidyverse)
library(Rcpp)

## Get Flags
Rcpp:::CxxFlags() |> print()

## General usage
r_for = function(n) {
  s = 0
  for (i in seq(1,n)) {
    s = s + i
  }
  s
}

r_vec = function(n) {
  s = sum(seq(1,n))
  s
}

Rcpp::cppFunction(
  "
  double r_cpp(int n) {
    double s = 0;
    for (int i=1; i<=n; i++) {
      s += i;
    }
    return s;
  }
  "
)

n = 1000000L
rbenchmark::benchmark(r_for(n), r_vec(n), r_cpp(n))[,1:4]
