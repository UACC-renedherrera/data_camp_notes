---
title: Correlation and Regression in R
subtitle: Interpreting regression models
---

# Fitting simple linear models

```
# Linear model for weight as a function of height
lm(wgt ~ hgt, data = bdims)

# Linear model for SLG as a function of OBP
lm(SLG ~ OBP, data = mlbBat10)

# Log-linear model for body weight as a function of brain weight
lm(log(BodyWt) ~ log(BrainWt), data = mammals)
```

# The lm summary output

```
# Show the coefficients
coef(mod)

# Show the full output
summary(mod)
```

# Fitting values and residuals

```
# Mean of weights equal to mean of fitted values?
mean(bdims$wgt) == mean(fitted.values(mod))

# Mean of the residuals
mean(residuals(mod))
```

# Tidying your linear model

```
# Load broom
library(broom)

# Create bdims_tidy
bdims_tidy <- augment(mod)

# Glimpse the resulting data frame
glimpse(bdims_tidy)
```

# Making predictions

```
# Print ben
ben

# Predict the weight of ben
predict(mod, newdata = ben)
```

# Adding a regression line to a plot manually

```
# Add the line to the scatterplot
ggplot(data = bdims, aes(x = hgt, y = wgt)) +
  geom_point() +
  geom_abline(data = coefs,
              aes(intercept = `(Intercept)`, slope = hgt), color = "dodgerblue")
```
