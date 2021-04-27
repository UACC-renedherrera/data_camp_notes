---
title: Multiple and Logistic Regression in R
subtitle: Parallel Slopes
---

# Fitting a parallel slopes model

```
# Explore the data
glimpse(mario_kart)

# fit parallel slopes
lm(totalPr ~ wheels + cond, data = mario_kart)
```

# Using geom_line() and augment()

```
# Augment the model
augmented_mod <- augment(mod)
glimpse(augmented_mod)

# scatterplot, with color
data_space <- ggplot(data = augmented_mod, aes(x = wheels, y = totalPr, color = cond)) +
  geom_point()

# single call to geom_line()
data_space +
  geom_line(aes(y = .fitted))
```

# Syntax from math

```
# build model
lm(bwt ~ age + parity, data = babies)
```

# Syntax from plot

```
# build model
lm(bwt ~ gestation + smoke, data = babies)
```
