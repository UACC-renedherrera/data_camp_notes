---
title: Multiple and Logistic Regression in R
subtitle: Evaluating and extending parallel slopes model
---

# R-squared vs. adjusted R-squared

```
# R^2 and adjusted R^2
summary(mod)

# add random noise
mario_kart_noisy <- mario_kart %>%
  mutate(noise = rnorm(n = 141))

# compute new model
mod2 <- lm(totalPr ~ wheels + cond + noise, data = mario_kart_noisy)

# new R^2 and adjusted R^2
summary(mod2)
```

# Prediction

```
# return a vector
predict(mod)

# return a data frame
augment(mod)
```

# Fitting a model with interaction

```
# include interaction
lm(totalPr ~ cond + duration + cond:duration, data = mario_kart)
```

# Visualizing interaction models

```
# interaction plot
ggplot(mario_kart, aes(y = totalPr, x = duration, color = cond)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```

# Simpson's paradox in action

```
slr <- ggplot(mario_kart, aes(y = totalPr, x = duration)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# model with one slope
lm(totalPr ~ duration, data = mario_kart)

# plot with two slopes
slr + aes(color = cond)
```
