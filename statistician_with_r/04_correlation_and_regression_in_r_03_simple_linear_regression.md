---
title: Correlation and Regression in R
subtitle: Simple linear regression
---

# The "best fit" line

```
# Scatterplot with regression line
ggplot(data = bdims, aes(x = hgt, y = wgt)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```

# Uniqueness of least squares regression line

```
# Estimate optimal value of my_slope
add_line(my_slope = 1)
```

# Fitting a linear model "by hand"

```
# Print bdims_summary
bdims_summary

# Add slope and intercept
bdims_summary %>%
  mutate(slope = r * sd_wgt / sd_hgt,
         intercept = mean_wgt - slope * mean_hgt)
```

# Regression to the mean

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
