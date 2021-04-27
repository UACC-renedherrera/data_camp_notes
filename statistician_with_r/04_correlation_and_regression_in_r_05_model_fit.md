---
title: Correlation and Regression in R
subtitle: Model Fit
---

# Standard error of residuals

```
# View summary of model
summary(mod)

# Compute the mean of the residuals
mean(residuals(mod))

# Compute RMSE
sqrt(sum(residuals(mod)^2) / df.residual(mod))
```

# Assessing simple linear fit

```
# View model summary
summary(mod)

# Compute R-squared
bdims_tidy %>%
  summarize(var_y = var(wgt), var_e = var(.resid)) %>%
  mutate(R_squared = 1-(var_e / var_y))
```

# Linear vs. average

```
# Compute SSE for null model
mod_null %>%
  summarize(SSE = sum(.resid^2))

# Compute SSE for regression model
mod_hgt %>%
  summarize(SSE = sum(.resid^2))
```

# Leverage

```
# Rank points of high leverage
mod %>%
  augment() %>%
  arrange(desc(.hat)) %>%
  head()
```

# Influence

```
# Rank influential points
mod %>%
  augment() %>%
  arrange(desc(.cooksd)) %>%
  head()
```

# Removing outliers

```
# Create nontrivial_players
nontrivial_players <- mlbBat10 %>%
  filter(OBP < 0.500, AB >= 10)

# Fit model to new data
mod_cleaner <- lm(SLG ~ OBP, data = nontrivial_players)

# View model summary
summary(mod_cleaner)

# Visualize new model
ggplot(data = nontrivial_players, aes(x = OBP, y = SLG)) +
  geom_point() +
  geom_smooth(method = "lm")
```

# High leverage points

```
# Rank high leverage points
mod %>%
  augment() %>%
  arrange(desc(.hat), .cooksd) %>%
  head()
```
