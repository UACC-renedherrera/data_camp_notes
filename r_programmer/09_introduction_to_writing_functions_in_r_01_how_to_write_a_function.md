---
title: Introduction to Writing Functions in R
subtitle: How to write a function
---

#  Calling functions

```
# Look at the gold medals data
gold_medals

# Note the arguments to median()
args(median)

# Rewrite this function call, following best practices
median(gold_medals, na.rm = TRUE)
```

```
# Note the arguments to rank()
args(rank)

# Rewrite this function call, following best practices
rank(-gold_medals, na.last = "keep", ties.method = "min")
```

# Your first function: tossing a coin

```
coin_sides <- c("head", "tail")

# Sample from coin_sides once
sample(coin_sides, 1)
```

```
# Write a template for your function, toss_coin()
toss_coin <- function() {
  # (Leave the contents of the body for later)
# Add punctuation to finish the body
}
```

```
# Your script, from a previous step
coin_sides <- c("head", "tail")
sample(coin_sides, 1)

# Paste your script into the function body
toss_coin <- function() {
  coin_sides <- c("head", "tail")
sample(coin_sides, 1)
}
```

```
# Your functions, from previous steps
toss_coin <- function() {
  coin_sides <- c("head", "tail")
  sample(coin_sides, 1)
}

# Call your function
toss_coin()
```

# Inputs to functions

```
coin_sides <- c("head", "tail")
n_flips <- 10

# Sample from coin_sides n_flips times with replacement
sample(coin_sides, n_flips, replace = TRUE)
```

```
# Update the function to return n coin tosses
toss_coin <- function(n_flips) {
  coin_sides <- c("head", "tail")
  sample(coin_sides, n_flips, replace = TRUE)
}

# Generate 10 coin tosses
toss_coin(10)
```

# Multiple inputs to functions

```
coin_sides <- c("head", "tail")
n_flips <- 10
p_head <- 0.8

# Define a vector of weights
weights <- p_head

# Update so that heads are sampled with prob p_head
sample(coin_sides, n_flips, replace = TRUE, prob = c(p_head, 1 -  p_head))
```

```
# Update the function so heads have probability p_head
toss_coin <- function(n_flips, p_head) {
  coin_sides <- c("head", "tail")
  # Define a vector of weights
  weights <- c(p_head, 1 - p_head)
  # Modify the sampling to be weighted
  sample(coin_sides, n_flips, replace = TRUE, prob = weights)
}

# Generate 10 coin tosses
toss_coin(10, p_head = 0.8)
```

# Renaming GLM

```
# Run a generalized linear regression
glm(
  # Model no. of visits vs. gender, income, travel
  n_visits ~ gender + income + travel,
  # Use the snake_river_visits dataset
  data = snake_river_visits,
  # Make it a Poisson regression
  family = poisson
)
```

```
# Write a function to run a Poisson regression
run_poisson_regression <- function(data, formula) {
  glm(formula, data, family = poisson)
}
```

```
# From previous step
run_poisson_regression <- function(data, formula) {
  glm(formula, data, family = poisson)
}

# Re-run the Poisson regression, using your function
model <- snake_river_visits %>%
  run_poisson_regression(n_visits ~ gender + income + travel)

# Run this to see the predictions
snake_river_explanatory %>%
  mutate(predicted_n_visits = predict(model, ., type = "response"))%>%
  arrange(desc(predicted_n_visits))
```
