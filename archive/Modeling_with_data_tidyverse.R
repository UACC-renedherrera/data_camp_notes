# R source code for all slides/videos in Albert Y. Kim's "Modeling with Data in
# the Tidyverse" DataCamp course:
# https://www.datacamp.com/courses/modeling-with-data-in-the-tidyverse
# This code is available at http://bit.ly/modeling_tidyverse

# Load all necessary packages -----
library(ggplot2)
library(dplyr)
library(moderndive)

# Chapter 1 - Video 1: Background on modeling for explanation -----
## Modeling for explanation example
glimpse(evals)

## Exploratory data analysis
ggplot(evals, aes(x = score)) +
  geom_histogram(binwidth = 0.25) +
  labs(x = "teaching score", y = "count")
# Compute mean, median, and standard deviation
evals %>%
  summarize(mean_score = mean(score),
            median_score = median(score),
            sd_score = sd(score))



# Chapter 1 - Video 2: Background on modeling for prediction -----
## Modeling for prediction example
glimpse(house_prices)

## Exploratory data analysis
ggplot(house_prices, aes(x = price)) +
  geom_histogram() +
  labs(x = "house price", y = "count")

## Log10 transformation
# log10() transform price and size
house_prices <- house_prices %>%
  mutate(log10_price = log10(price))
# View effects of transformation
house_prices %>%
  select(price, log10_price)

## Histogram of new outcome variable
# Histogram of original outcome variable
ggplot(house_prices, aes(x = price)) +
  geom_histogram() +
  labs(x = "house price", y = "count")
# Histogram of new, log10-transformed outcome variable
ggplot(house_prices, aes(x = log10_price)) +
  geom_histogram() +
  labs(x = "log10 house price", y = "count")



# Chapter 1 - Video 3: The modeling problem for explanation -----
## EDA of relationship
ggplot(evals, aes(x = age, y = score)) +
  geom_point() +
  labs(x = "age", y = "score", title = "Teaching score over age")

## Jittered scatterplot
# Instead of geom_point() ...
ggplot(evals, aes(x = age, y = score)) +
  geom_point() +
  labs(x = "age", y = "score", title = "Teaching score over age")
# Use geom_jitter()
ggplot(evals, aes(x = age, y = score)) +
  geom_jitter() +
  labs(x = "age", y = "score", title = "Teaching score over age (jittered)")

## Computing the correlation coefficient
evals %>%
  summarize(correlation = cor(score, age))



# Chapter 1 - Video 4: The modeling problem for prediction -----
## Condition of house
house_prices %>%
  select(log10_price, condition) %>%
  glimpse()

## Exploratory data visualization: boxplot
# Apply log10-transformation to outcome variable
house_prices <- house_prices %>%
  mutate(log10_price = log10(price))
# Boxplot
ggplot(house_prices, aes(x = condition, y = log10_price)) +
  geom_boxplot() +
  labs(x = "house condition", y = "log10 price",
       title = "log10 house price over condition")

## Exploratory data summaries
house_prices %>%
  group_by(condition) %>%
  summarize(mean = mean(log10_price), sd = sd(log10_price), n = n())
# Prediction for new house with condition 4 in dollars
10^(5.65)



# Chapter 2 - Video 1: Explaining teaching score with age -----
## Regression line
# Code to create scatterplot
ggplot(evals, aes(x = age, y = score)) +
  geom_point() +
  labs(x = "age", y = "score", title = "Teaching score over age")
# Add a "best-fitting" line
ggplot(evals, aes(x = age, y = score)) +
  geom_point() +
  labs(x = "age", y = "score", title = "Teaching score over age") +
  geom_smooth(method = "lm", se = FALSE)

## Computing slope and intercept of regression line
# Fit regression model using formula of form: y ~ x
model_score_1 <- lm(score ~ age, data = evals)
# Output contents
model_score_1
# Output regression table using wrapper function:
get_regression_table(model_score_1)



# Chapter 2 - Video 2: Predicting teaching score using age -----
## Refresher: Regression table
# Fit regression model using formula of form: y ~ x
model_score_1 <- lm(score ~ age, data = evals)
# Output regression table using wrapper function
get_regression_table(model_score_1)

## Computing all predicted values
# Fit regression model using formula of form: y ~ x
model_score_1 <- lm(score ~ age, data = evals)
# Get information on each point
get_regression_points(model_score_1)



# Chapter 2 - Video 3: Explaining teaching score with gender -----
## Exploratory data visualization
ggplot(evals, aes(x = gender, y = score)) +
  geom_boxplot() +
  labs(x = "score", y = "count")

## Facetted histogram
ggplot(evals, aes(x = score)) +
  geom_histogram(binwidth = 0.25) +
  facet_wrap(~gender) +
  labs(x = "score", y = "count")

## Fitting a regression model
# Fit regression model
model_score_3 <- lm(score ~ gender, data = evals)
# Get regression table
get_regression_table(model_score_3)
# Compute group means based on gender
evals %>%
  group_by(gender) %>%
  summarize(avg_score = mean(score))

## A different categorical explanatory variable: rank
evals %>%
  group_by(rank) %>%
  summarize(n = n())



# Chapter 2 - Video 4: Predicting teaching score using gender -----
## Group means as predictions
evals %>%
  group_by(gender) %>%
  summarize(mean_score = mean(score), sd_score = sd(score))

## Computing all predicted values and residuals
# Fit regression model:
model_score_3 <- lm(score ~ gender, data = evals)
# Get information on each point
get_regression_points(model_score_3)

## Histogram of residuals
# Fit regression model
model_score_3 <- lm(score ~ gender, data = evals)
# Get regression points
model_score_3_points <- get_regression_points(model_score_3)
model_score_3_points
# Plot residuals
ggplot(model_score_3_points, aes(x = residual)) +
  geom_histogram() +
  labs(x = "residuals", title = "Residuals from score ~ gender model")



# Chapter 3 - Video 1: Explaining house price with year & size -----
## Refresher: Seattle house prices
# Preview only certain variables:
house_prices %>%
  select(price, sqft_living, condition, waterfront) %>%
  glimpse()

## Refresher: Data transformation
# log10() transform price and size
house_prices <- house_prices %>%
  mutate(
    log10_price = log10(price),
    log10_size = log10(sqft_living)
  )

## Interactive 3D scatterplot and regression plane. Check out:
# https://gist.github.com/rudeboybert/9905f44013c18d6add279cf13ab8e398

## Regression table
# Fit regression model using formula of form: y ~ x1 + x2
model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                    data = house_prices)
# Output regression table
get_regression_table(model_price_1)



# Chapter 3 - Video 2: Predicting house price using year & size -----
## Predicted value
# Fit regression model using formula of form: y ~ x1 + x2
model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                    data = house_prices)
# Output regression table
get_regression_table(model_price_1)
# Make prediction
5.38 + 0.913 * 3.07 - 0.00138 * 1980
# Convert back to original untransformed units: US dollars
10^(5.45051)

## Computing all predicted values and residuals
# Output point-by-point information
get_regression_points(model_price_1)

## Sum of squared residuals
# Output point-by-point information
get_regression_points(model_price_1)
# Square all residuals and sum them
get_regression_points(model_price_1) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(sum_sq_residuals = sum(sq_residuals))



# Chapter 3 - Video 3: Explaining house price with size & condition -----
## Refresher: Exploratory data analysis
# log transform variables
house_prices <- house_prices %>%
  mutate(
    log10_price = log10(price),
    log10_size = log10(sqft_living)
  )

# Group mean & sd of log10_price and counts
house_prices %>%
  group_by(condition) %>%
  summarize(mean = mean(log10_price), sd = sd(log10_price), n = n())

## Parallel slopes model
# Note: This is unfortunately tricky to do. Standby for an easier way:
# https://github.com/moderndive/moderndive/issues/26

## Quantifying relationship between house price, size & condition
# Fit regression model using formula of form: y ~ x1 + x2
model_price_3 <- lm(log10_price ~ log10_size + condition,
                    data = house_prices)

# Output regression table
get_regression_table(model_price_3)



# Chapter 3 - Video 4: Predicting house price using size & condition -----
## Numerical predictions
# Fit regression model and get regression table
model_price_3 <- lm(log10_price ~ log10_size + condition,
                    data = house_prices)
get_regression_table(model_price_3)
# Make prediction
5.38 + 0.913 * 3.07 - 0.00138 * 1980
# Convert back to original untransformed units: US dollars
10^(5.45051)

# Create data frame of "new" data
new_houses <- data_frame(
  log10_size = c(2.9, 3.6),
  condition = factor(c(3, 4))
)

## Making predictions using new data
# Make predictions on new data
get_regression_points(model_price_3, newdata = new_houses)
# Make predictions in original units by undoing log10()
get_regression_points(model_price_3, newdata = new_houses) %>%
  mutate(price_hat = 10^log10_price_hat)



# Chapter 4 - Video 1: Model selection and assessment -----
## Refresher: Multiple regression
# Model 1 - Two numerical:
model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                    data = house_prices)
# Model 3 - One numerical & one categorical:
model_price_3 <- lm(log10_price ~ log10_size + condition,
                    data = house_prices)

## Refresher: Sum of squared residuals
# Model 1
model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                    data = house_prices)
get_regression_points(model_price_1) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(sum_sq_residuals = sum(sq_residuals))
# Model 3
model_price_3 <- lm(log10_price ~ log10_size + condition,
                    data = house_prices)
get_regression_points(model_price_3) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(sum_sq_residuals = sum(sq_residuals))



# Chapter 4 - Video 2: Assessing model fit with R-squared -----
## Computing R-squared
# Model 1: price as a function of size and year built
model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                    data = house_prices)

get_regression_points(model_price_1) %>%
  summarize(r_squared = 1 - var(residual) / var(log10_price))
# Model 3: price as a function of size and condition
model_price_3 <- lm(log10_price ~ log10_size + condition,
                    data = house_prices)

get_regression_points(model_price_3) %>%
  summarize(r_squared = 1 - var(residual) / var(log10_price))



# Chapter 4 - Video 3: Assessing predictions with RMSE -----
## Mean squared error
# Model 1: price as a function of size and year built
model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                    data = house_prices)
# Sum of squared residuals:
get_regression_points(model_price_1) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(sum_sq_residuals = sum(sq_residuals))
# Mean squared error: use mean() instead of sum():
get_regression_points(model_price_1) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(mse = mean(sq_residuals))

## Root mean squared error
# Root mean squared error:
get_regression_points(model_price_1) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(mse = mean(sq_residuals)) %>%
  mutate(rmse = sqrt(mse))

## RMSE of predictions on new houses
# Create data frame of new houses
new_houses <- data_frame(
  log10_size = c(2.9, 3.6),
  condition = factor(c(3, 4))
)
# Get predictions
get_regression_points(model_price_3, newdata = new_houses)

## RMSE of predictions on new houses
# Get predictions
get_regression_points(model_price_3, newdata = new_houses)
# Compute RMSE: Error!
get_regression_points(model_price_3, newdata = new_houses) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(mse = mean(sq_residuals)) %>%
  mutate(rmse = sqrt(mse))



# Chapter 4 - Video 4: Validation set prediction framework -----
set.seed(76)
## Training/test set split in R
# Randomly shuffle order of rows:
house_prices_shuffled <- house_prices %>%
  sample_frac(size = 1, replace = FALSE)
# Split into train and test:
train <- house_prices_shuffled %>%
  slice(1:10000)
test <- house_prices_shuffled %>%
  slice(10001:21613)

## Training models on training data
train_model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                          data = train)
get_regression_table(train_model_price_1)

## Making predictions on test data
# Train model on train:
train_model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                          data = train)

# Get predictions on test:
get_regression_points(train_model_price_1, newdata = test)

## Assessing predictions with RMSE
# Train model:
train_model_price_1 <- lm(log10_price ~ log10_size + yr_built,
                          data = train)

# Get predictions and compute RMSE:
get_regression_points(train_model_price_1, newdata = test) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(rmse = sqrt(mean(sq_residuals)))

## Comparing RMSE
# Train model:
train_model_price_3 <- lm(log10_price ~ log10_size + condition,
                          data = train)

# Get predictions and compute RMSE:
get_regression_points(train_model_price_3, newdata = test) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(rmse = sqrt(mean(sq_residuals)))
