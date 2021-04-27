---
title: Multiple and Logistic Regression in R
subtitle: Multiple Regression
---

# Fitting a MLR model

```
# Fit the model using duration and startPr
lm(totalPr ~ duration + startPr, data = mario_kart)
```

# Tiling the plane

```
# add predictions to grid
price_hats <- augment(mod, newdata = grid)

# tile the plane
data_space +
  geom_tile(data = price_hats, aes(fill = .fitted), alpha = 0.5)
```

# Models in 3D

```
# draw the 3D scatterplot
p <- plot_ly(data = mario_kart, z = ~totalPr, x = ~duration, y = ~startPr, opacity = 0.6) %>%
  add_markers()

# draw the plane
p %>%
  add_surface(x = ~x, y = ~y, z = ~plane, showscale = FALSE)
```

# Visualizing parallel planes

```
# draw the 3D scatterplot
p <- plot_ly(data = mario_kart, z = ~totalPr, x = ~duration, y = ~startPr, opacity = 0.6) %>%
  add_markers(color = ~cond)

# draw two planes
p %>%
  add_surface(x = ~x, y = ~y, z = ~plane0, showscale = FALSE) %>%
  add_surface(x = ~x, y = ~y, z = ~plane1, showscale = FALSE)
```
