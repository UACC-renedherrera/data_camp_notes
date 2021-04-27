---
title: Correlation and Regression in R
subtitle: Correlation
---

# Computing correlation

```
# Compute correlation
ncbirths %>%
  summarize(N = n(), r = cor(mage, weight))

# Compute correlation for all non-missing pairs
ncbirths %>%
  summarize(N = n(), r = cor(mage, weight, use = "pairwise.complete.obs"))
```

# Exploring Anscombe

```
# Compute properties of Anscombe
Anscombe %>%
  group_by(set) %>%
  summarize(
    N = n(),
    mean_of_x = mean(x),
    std_dev_of_x = sd(x),
    mean_of_y = mean(y),
    std_dev_of_y = sd(y),
    correlation_between_x_and_y = cor(x, y)
  )
```

# Perception of correlation

```
# Run this and look at the plot
ggplot(data = mlbBat10, aes(x = OBP, y = SLG)) +
  geom_point()

# Correlation for all baseball players
mlbBat10 %>%
  summarize(N = n(), r = cor(OBP, SLG))
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
```

```
# Run this and look at the plot
ggplot(data = bdims, aes(x = hgt, y = wgt, color = factor(sex))) +
  geom_point()

# Correlation of body dimensions
bdims %>%
  group_by(sex) %>%
  summarize(N = n(), r = cor(hgt, wgt))
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
```

# Spurious correlation in random data

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
