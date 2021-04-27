---
title: Correlation and Regression in R
subtitle: Visualizing two variables
---

# Scatterplots

```
# Scatterplot of weight vs. weeks
ggplot(data = ncbirths, aes(x = weeks, y = weight)) +
  geom_point()
```

# Boxplots as discretized / conditioned scatterplots

```
# Boxplot of weight vs. weeks
ggplot(data = ncbirths,
       aes(x = cut(weeks, breaks = 5), y = weight)) +
  geom_boxplot()
```

# Creating scatterplots

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
ggplot(data = bdims, aes(x = hgt, y = wgt, color = factor(sex))) +
geom_point()
```
```
# Smoking scatterplot
ggplot(data = smoking, aes(x = age, y = amtWeekdays)) +
geom_point()
```

# Transformations

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

# Identifying outliers

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
