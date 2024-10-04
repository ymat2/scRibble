library(conflicted)
library(tidyverse)


## Generate Gaussian distributions
set.seed(5)
n = 15

x = rnorm(n, mean = 50, sd = 15)
y = rnorm(n, mean = 55, sd = 15)  # same variance but different mean
z = rnorm(n, mean = 50, sd = 25)  # same mean but different mean
yz = rnorm(n, mean = 60, sd = 25)  # different variance and mean


## x vs y
df = data.frame(x, y) |>
  pivot_longer(1:2, names_to = "class", values_to = "value")
ggplot(df) +
  aes(class, value) +
  geom_boxplot(fill = "#cccccc") +
  geom_jitter(width = 0.2, height = 0)

### welch's t-test
t.test(x, y, var.equal = FALSE)

### x and y variances are equal
var.test(x, y)  # p<0.05 means two variables have different variances
t.test(x, y, var.equal = TRUE)


## x vs z
df = data.frame(x, z) |>
  pivot_longer(1:2, names_to = "class", values_to = "value")
ggplot(df) +
  aes(class, value) +
  geom_boxplot(fill = "#cccccc") +
  geom_jitter(width = 0.2, height = 0)

### welch's t-test
t.test(x, z, var.equal = FALSE)

### x and y variances are not equal
var.test(x, z)  # p<0.05 means two variables have different variances
t.test(x, z, var.equal = TRUE)  # Student t-test is not appropriate


## x vs yz
df = data.frame(x, yz) |>
  pivot_longer(1:2, names_to = "class", values_to = "value")
ggplot(df) +
  aes(class, value) +
  geom_boxplot(fill = "#cccccc") +
  geom_jitter(width = 0.2, height = 0)

### welch's t-test
t.test(x, yz, var.equal = FALSE)

### x and y variances are not equal
var.test(x, yz)  # p<0.05 means two variables have different variances
t.test(x, yz, var.equal = TRUE)  # Student t-test is not appropriate


## Generate non-Gaussian distributions
set.seed(5)
n = 15

v = rbinom(n, size = 5, prob = 0.2)  # no Gaussian distribution
w = rbinom(n, size = 5, prob = 0.25)  # no Gaussian distribution

## v vs w
df = data.frame(v, w) |>
  pivot_longer(1:2, names_to = "class", values_to = "value")
ggplot(df) +
  aes(class, value) +
  geom_violin(fill = "#cccccc") +
  geom_jitter(width = 0.2, height = 0) +
  theme_classic(base_size = 36)

### welch's t-test
t.test(x, yz, var.equal = FALSE)

### v and w are no Gaussian distribution
shapiro.test(v)
shapiro.test(w)
var.test(v, w)
wilcox.test(v, w)


## Chi-squared test vs Fisher's Exact Test
df = data.frame(
  gene.not.interest=c(2613, 15310),
  gene.in.interest=c(28, 29)
)
row.names(df) = c("In_category", "not_in_category")

chi_sq = chisq.test(df)
print(chi_sq)

fish = fisher.test(df)
print(fish)
