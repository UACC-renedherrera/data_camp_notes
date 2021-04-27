---
title: Modeling with Data in the Tidyverse
subtitle: Modeling with Basic Regression
---

# Plotting a "best-fitting" regression line 

```
# Load packages
library(ggplot2)
library(dplyr)
library(moderndive)

# Plot
ggplot(evals, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "beauty score", y = "score") +
  geom_smooth(method = "lm", se = FALSE)
```

# Fitting a regression with a numerical x

```
# Load package
library(moderndive)

# Fit model
model_score_2 <- lm(score ~ bty_avg, data = evals)

# Output content
model_score_2
```

```
# Load package
library(moderndive)

# Fit model
model_score_2 <- lm(score ~ bty_avg, data = evals)

# Output regression table
get_regression_table(model_score_2)
```

# Making predictions use "beauty score"

```
# Use fitted intercept and slope to get a prediction
y_hat <- 3.88 + 5 * 0.0670
y_hat

# Compute residual y - y_hat
4.7 - y_hat
```

# Computing fitted / predicted values & residuals

```
# Fit regression model
model_score_2 <- lm(score ~ bty_avg, data = evals)

# Get regression table
get_regression_table(model_score_2)

# Get all fitted/predicted values and residuals
get_regression_points(model_score_2) %>%
  mutate(score_hat_2 = 3.88 + 0.067 * bty_avg)
```

```
# Fit regression model
model_score_2 <- lm(score ~ bty_avg, data = evals)

# Get regression table
get_regression_table(model_score_2)

# Get all fitted/predicted values and residuals
get_regression_points(model_score_2) %>%
  mutate(residual_2 = score - score_hat)
```

# EDA of relationship of score and rank

```
ggplot(data = evals, aes(x = rank, y = score)) +
  geom_boxplot() +
  labs(x = "rank", y = "score")
```

```
evals %>%
  group_by(rank) %>%
  summarize(n = n(), mean_score = mean(score), sd_score = sd(score))
```

# Fitting a regression with a categorical x

```
# Fit regression model
model_score_4 <- lm(score ~ rank, data = evals)

# Get regression table
get_regression_table(model_score_4)

# teaching mean
teaching_mean <- 4.28

# tenure track mean
tenure_track_mean <- teaching_mean - 0.13

# tenured mean
tenured_mean <- teaching_mean - 0.145
```

# Visualizing the distribution of residuals

```
# Calculate predictions and residuals
model_score_4_points <- get_regression_points(model_score_4)
model_score_4_points

# Plot residuals
ggplot(model_score_4_points, aes(x = residual)) +
  geom_histogram() +
  labs(x = "residuals", title = "Residuals from score ~ rank model")
```
