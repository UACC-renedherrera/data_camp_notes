# correlation and regression in R


a scatterplot as a generalization of side by side box plots with `cut()`


## scatterplots


```
# Scatterplot of weight vs. weeks
ggplot(data = ncbirths, aes(x = weeks, y = weight)) +
  geom_point()
```

```
# Mammals scatterplot
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
geom_point()
```

```
# Baseball player scatterplot
ggplot(data = mlbBat10, aes(x = OBP, y = SLG)) +
geom_point()
```


```
# Body dimensions scatterplot
ggplot(data = bdims, aes(x = hgt, y = wgt, color = sex)) +
geom_point()
```


```
# Smoking scatterplot
ggplot(data = smoking, aes(x = age, y = amtWeekdays)) +
geom_point()
```

### Transformation


```
# Scatterplot with coord_trans()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10")
```


```
# Scatterplot with scale_x_log10() and scale_y_log10()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()
```

## boxplots as discretized conditioned scatterplots


```
# Boxplot of weight vs. weeks
ggplot(data = ncbirths,
       aes(x = cut(weeks, breaks = 5), y = weight)) +
  geom_boxplot()
```


## Outliers


```
# Filter for AB greater than or equal to 200
ab_gt_200 <- mlbBat10 %>%
  filter(AB >= 200)

# Scatterplot of SLG vs. OBP
ggplot(ab_gt_200, aes(x = OBP, y = SLG)) +
  geom_point()

# Identify the outlying player
ab_gt_200 %>%
  filter(OBP < 0.200)
```


## Quantifying the strength of bivariate relationships


with the correlation coefficient; Pearson product moment correlation


```
# Compute correlation
ncbirths %>%
  summarize(N = n(), r = cor(mage, weight))

# Compute correlation for all non-missing pairs
ncbirths %>%
  summarize(N = n(), r = cor(mage, weight, use = "pairwise.complete.obs"))
```


```
# Run this and look at the plot
ggplot(data = mlbBat10, aes(x = OBP, y = SLG)) +
  geom_point()

# Correlation for all baseball players
mlbBat10 %>%
  summarize(N = n(), r = cor(OBP, SLG))

# r = 0.8145628
```


```
# Run this and look at the plot
mlbBat10 %>%
    filter(AB > 200) %>%
    ggplot(aes(x = OBP, y = SLG)) +
    geom_point()

# Correlation for all players with at least 200 ABs
mlbBat10 %>%
  filter(AB >= 200) %>%
  summarize(N = n(), r = cor(OBP, SLG))

# r = 0.6863392
```


```
# Run this and look at the plot
ggplot(data = bdims, aes(x = hgt, y = wgt, color = factor(sex))) +
  geom_point()

# Correlation of body dimensions
bdims %>%
  group_by(sex) %>%
  summarize(N = n(), r = cor(hgt, wgt))

# r0 = 0.431
# r1 = 0.535
```


```
# Run this and look at the plot
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() + scale_x_log10() + scale_y_log10()

# Correlation among mammals, with and without log
mammals %>%
  summarize(N = n(),
            r = cor(BodyWt, BrainWt),
            r_log = cor(log(BodyWt), log(BrainWt)))

# r = 0.9341638
# r_log = 0.9595748
```

## Anscombe dataset


```
ggplot(data = Anscombe, aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~ set)

  # Compute properties of Anscombe
  Anscombe %>%
    group_by(set) %>%
      N = n(),
      summarize(
      mean_of_x = mean(x),
      std_dev_of_x = sd(x),
      mean_of_y = mean(y),
      std_dev_of_y = sd(y),
      correlation_between_x_and_y = cor(x, y)
    )
```


## Correlations


```
# Create faceted scatterplot
ggplot(data = noise, aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~ z)



# Compute correlations for each dataset
noise_summary <- noise %>%
  group_by(z) %>%
  summarize(N = n(), spurious_cor = cor(x, y))

# Isolate sets with correlations above 0.2 in absolute strength
noise_summary %>%
  filter(abs(spurious_cor) > 0.2)
```


## Visualization of Linear Model with line of best fit


```
# Scatterplot with regression line
ggplot(data = bdims, aes(x = hgt, y = wgt)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```


## Understanding Linear Models


```
# Print bdims_summary
bdims_summary

# Add slope and intercept
bdims_summary %>%
  mutate(slope = r * sd_wgt / sd_hgt,
         intercept = mean_wgt - slope * mean_hgt)
```


## Regression vs regression to the mean


```
# Height of children vs. height of father
ggplot(data = Galton_men, aes(x = father, y = height)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0) +
  geom_smooth(method = "lm", se = FALSE)

# Height of children vs. height of mother
ggplot(data = Galton_women, aes(x = mother, y = height)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0) +
  geom_smooth(method = "lm", se = FALSE)
```


## Interpretation of Regression: fitting simple linear models


```
# Linear model for weight as a function of height
lm(wgt ~ hgt, data = bdims)

# Linear model for SLG as a function of OBP
lm(SLG ~ OBP, data = mlbBat10)

# Log-linear model for body weight as a function of brain weight
lm(log(BodyWt) ~ log(BrainWt), data = mammals)
```


## Linear Model Object


- assign the model to object with `mod -> lm(x ~ y, data = "")`
- print the coefficients with `coef(mod)`
- summarize the model `summary(mod)`
- print the fitted values `fitted.values(mod)`
- retrieve residuals with `residuals(mod)`
- `library(broom)` then `augment(mod)` clean up the dataframe


```
# Show the coefficients
coef(mod)

# Show the full output
summary(mod)
```


```
# Mean of weights equal to mean of fitted values?
mean(bdims$wgt) == mean(fitted.values(mod))

# Mean of the residuals
mean(residuals(mod))
```


```
# Load broom
library(broom)

# Create bdims_tidy
bdims_tidy <- augment(mod)

# Glimpse the resulting data frame
glimpse(bdims_tidy)
```


## Use Linear Model to Make Predictions


```
# Print ben
ben

# Predict the weight of ben
predict(mod, newdata = ben)
```

Add regression line to plot manually

```
# Add the line to the scatterplot

ggplot(data = bdims, aes(x = hgt, y = wgt)) +
  geom_point() +
  geom_abline(data = coefs,
              aes(intercept = `(Intercept)`, slope = hgt, color = "dodgerblue"))
```


## Assessing Model Fit


```
# View summary of model
summary(mod)

# Compute the mean of the residuals
mean(residuals(mod))

# Compute RMSE
sqrt(sum(residuals(mod)^2) / df.residual(mod))
```


## Comparing model fits


```
# View model summary
summary(mod)

# Compute R-squared
bdims_tidy %>%
  summarize(var_y = var(wgt), var_e = var(.resid)) %>%
  mutate(R_squared = 1-(var_e / var_y))
```


## Linear versus average


```
# Compute SSE for null model
mod_null %>%
  summarize(SSE = sum(.resid^2))

# Compute SSE for regression model
mod_hgt %>%
  summarize(SSE = sum(.resid^2))
```


## Leverage


```
# Rank points of high leverage
mod %>%
  augment() %>%
  arrange(desc(.hat)) %>%
  head()
```

```
# Rank influential points
mod %>%
  augment() %>%
  arrange(desc(.cooksd)) %>%
  head()
```


## Removing Outliers


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


```
# Rank high leverage points
mod %>%
  augment() %>%
  arrange(desc(.hat), .cooksd) %>%
  head()
```
