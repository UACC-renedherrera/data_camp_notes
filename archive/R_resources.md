# Introduction




## Loading Data into R


- Load the dataset with `data()`
- Preview with `str()`


## Identify variable types


- preview with `glimpse()`
- view table with `table()`


Inspect, and view, a data frame with any of the following:


```
str()
glimpse()
head()
unique()
```


## Filter based on a factor


- filter a dataset with `filter()`
- remove unused factor levels with `droplevels()`
- wrap assignment with paranthesis to also print for example: `(data -> data %>% filter(number == "big"))`


## Discretize a variable


- calculate average with `mean()`
- use `mutate()` to create new variables;
- conditionally apply mutate with `ifelse()` ; syntax is logical statement, if true, if false
- conditionally apply mutate with `case_when()`
- use `count()` to count


Count variabes


```
ucb_admission_counts <- ucb_admit %>%
    # Counts by department, then gender, then admission status
    count(Dept, Gender, Admit)
```

Group by variables, create new variable to show proportion, and filter to show relevant

```
ucb_admission_counts  %>%
  # Group by department, then gender
  group_by(Dept, Gender) %>%
  # Create new variable
  mutate(prop = n/sum(n)) %>%
  # Filter for male and admitted
  filter(Gender == "Male", Admit == "Admitted")
```


```
# Recode cls_students as cls_type
evals_fortified <- evals %>%
  mutate(
    cls_type = case_when(
      cls_students <= 18 ~ "small",
      cls_students %in% c(19:59) ~ "midsize",
      cls_students >= 60 ~ "large"
    )
  )
```


## Calculate proportions


```
ucb_admission_counts %>%
    # Group by gender
    group_by(Gender) %>%
    # Create new variable
    mutate(prop = n / sum(n)) %>%
    # Filter for admitted
    filter(Admit == "Admitted")
```


## Visualize data


- use ggplot2 package to create modern plots
- call ggplot2 with `ggplot()`; for example:


```
ggplot(email50, aes(x = num_char, y = exclaim_mess, color = factor(spam))) +
  geom_point()
```


## Sampling

- use `sample_n()` to generate a simple random sample from the observation with size n
- to generate a stratified sample first `group_by()` strata and then generate the random sample with `sample_n()`


```
# Simple random sample: states_srs
states_srs <- us_regions %>%
  sample_n(8)

# Count states by region
states_srs %>%
  count(region)
```


```
# Stratified sample
states_str <- us_regions %>%
  group_by(region) %>%
  sample_n(2)

# Count states by region
states_str %>%
  count(region)
```


## Contingency Tables



`table(dataframe$var1, dataframe$var2)`


```
# Load dplyr
library(dplyr)

# Print tab
tab

# Remove align level
comics_filtered <- comics %>%
  filter(align != "Reformed Criminals") %>%
  droplevels()

# See the result
comics_filtered
```

```
# Load ggplot2
library(ggplot2)

# Create side-by-side barchart of gender by alignment
ggplot(data = comics, aes(x = align, fill = gender)) +
  geom_bar(position = "dodge")

# Create side-by-side barchart of alignment by gender
ggplot(data = comics, aes(x = gender, fill = align)) +
  geom_bar(position = "dodge") +
  theme(axis.text.x = element_text(angle = 90))
```


## Conditional Proportions


```
# Plot of gender by align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar()

# Plot proportion of gender, conditional on align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar(position = "fill") +
  ylab("proportion")
```


## Distribution of one variable


faceting versus stacking;


```
# Change the order of the levels in align
comics$align <- factor(comics$align,
                       levels = c("Bad", "Neutral", "Good"))

# Create plot of align
ggplot(data = comics, aes(x = align)) +
  geom_bar()
```

```
# Plot of alignment broken down by gender
ggplot(comics, aes(x = align)) +
  geom_bar() +
  facet_wrap(~ gender)
```

```
# Put levels of flavor in descending order
lev <- c("apple", "key lime", "boston creme", "blueberry", "cherry", "pumpkin", "strawberry")
pies$flavor <- factor(pies$flavor, levels = lev)

# Create barchart of flavor
ggplot(data = pies, aes(x = flavor)) +
  geom_bar(fill = "chartreuse") +
  theme(axis.text.x = element_text(angle = 90))
```


## Exploring Numerical Data


- integer is discrete
- numerical is continuous



## Visualize with


- dotplot
- histogram
- density
- boxplot
- faceted histogram


```
ggplot(cars, aes(x = city_mpg)) +
    geom_histogram() +
    facet_wrap(~ suv)
```


```
# Filter cars with 4, 6, 8 cylinders
common_cyl <- filter(cars, ncyl %in% c(4, 6, 8))

# Create box plots of city mpg by ncyl
ggplot(data = common_cyl, aes(x = as.factor(ncyl), y = city_mpg)) +
  geom_boxplot()

# Create overlaid density plots for same data
ggplot(common_cyl, aes(x = city_mpg, fill = as.factor(ncyl))) +
  geom_density(alpha = .3)
```

## Histogram


```
# Create hist of horsepwr
cars %>%
  ggplot(aes(x = horsepwr)) +
  geom_histogram() +
  ggtitle("Horsepower")

# Create hist of horsepwr for affordable cars
cars %>%
  filter(msrp < 25000) %>%
  ggplot(aes(x = horsepwr)) +
  geom_histogram() +
  xlim(c(90, 550)) +
  ggtitle("Horsepower, where msrp < 2500")
```

```
# Create hist of horsepwr with binwidth of 3
cars %>%
  ggplot(aes(x = horsepwr)) +
  geom_histogram(binwidth = 3) +
  ggtitle("Horsepower w/ binwidth of 3")

# Create hist of horsepwr with binwidth of 30
cars %>%
  ggplot(aes(x = horsepwr)) +
  geom_histogram(binwidth = 30) +
  ggtitle("Horsepower w/ binwidth of 30")

# Create hist of horsepwr with binwidth of 60
cars %>%
  ggplot(aes(x = horsepwr)) +
  geom_histogram(binwidth = 60) +
  ggtitle("Horsepower w/ binwidth of 60")
```

```
# Facet hists using hwy mileage and ncyl
common_cyl %>%
  ggplot(aes(x = hwy_mpg)) +
  geom_histogram() +
  facet_grid(ncyl ~ suv) +
  ggtitle("Histogram of MPG by NCYL and SUV")
```



## Boxplot


- Visualizes median, mean, and IQR with outliers,
-


```
# Construct box plot of msrp
cars %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()

# Exclude outliers from data
cars_no_out <- cars %>%
  filter(msrp < 100000)

# Construct box plot of msrp using the reduced dataset
cars_no_out %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()
```

```
# Create plot of city_mpg
cars %>%
  ggplot(aes(x = 1, y = city_mpg)) +
  geom_boxplot()

cars %>%
  ggplot(aes(x = city_mpg)) +
  geom_density()

# Create plot of width
cars %>%
  ggplot(aes(y = width)) +
  geom_boxplot()

cars %>%
  ggplot(aes(x = width)) +
  geom_density()
```


## Measures of Center


- `sort()`
- `mean()`
- `median()`
- `table()`


```
# Create dataset of 2007 data
gap2007 <- filter(gapminder, year == 2007)

# Compute groupwise mean and median lifeExp
gap2007 %>%
  group_by(continent) %>%
  summarize(mean(lifeExp),
            median(lifeExp))

# Generate box plots of lifeExp for each continent
gap2007 %>%
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot()
```


## Measures of variability


- variance `var(x)`
- standard deviation `sd(x)`
- interquartile range is difference of 3rd and 1st quartile `summary(x)` or `IQR(x)`


```
# Compute groupwise measures of spread
gap2007 %>%
  group_by(continent) %>%
  summarize(sd(lifeExp),
            IQR(lifeExp),
            n())

# Generate overlaid density plots
gap2007 %>%
  ggplot(aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.3)
```


```
# Compute stats for lifeExp in Americas
gap2007 %>%
  filter(continent == "Americas") %>%
  summarize(mean(lifeExp),
            sd(lifeExp))

# Compute stats for population
gap2007 %>%
  summarize(median(pop),
            IQR(pop))
```


## Transformation


```
# Create density plot of old variable
gap2007 %>%
  ggplot(aes(x = pop)) +
  geom_density()

# Transform the skewed pop variable
gap2007 <- gap2007 %>%
  mutate(log_pop = log(pop))

# Create density plot of new variable
gap2007 %>%
  ggplot(aes(x = log_pop)) +
  geom_density()
```


## Outliers


```
# Filter for Asia, add column indicating outliers
gap_asia <- gap2007 %>%
  filter(continent == "Asia") %>%
  mutate(is_outlier = lifeExp < 50)

# Remove outliers, create box plot of lifeExp
gap_asia %>%
  filter(!is_outlier) %>%
  ggplot(aes(x = 1, y = lifeExp)) +
  geom_boxplot()
```


```
# Load packages
library(ggplot2)
library(dplyr)
library(openintro)


# Compute summary statistics
email %>%
  group_by(spam)%>%
  summarize(median(num_char), IQR(num_char))

# Create plot
email %>%
  mutate(log_num_char = log(num_char)) %>%
  ggplot(aes(x = spam, y = log_num_char)) +
  geom_boxplot()
```


```
# Compute center and spread for exclaim_mess by spam
email %>%
  group_by(spam) %>%
  summarize(mean(exclaim_mess), IQR(exclaim_mess))



# Create plot for spam and exclaim_mess
email %>%
  mutate(em_log = log(exclaim_mess)) %>%
  ggplot(aes(x = spam, y = (em_log+.01))) +
  geom_boxplot()


email %>%
  mutate(em_log = log(exclaim_mess)) %>%
  ggplot(aes(x = (em_log))) +
  geom_histogram() +
  facet_wrap(~ spam)


email %>%
  mutate(em_log = log(exclaim_mess)) %>%
  ggplot(aes(x = (em_log+0.01), fill = spam)) +
  geom_density(alpha = 0.5)
```


```
# Create plot of proportion of spam by image
email %>%
  mutate(has_image = image > 0) %>%
  ggplot(aes(x = has_image, fill = spam)) +
  geom_bar(position = "fill")
```


```
# Test if images count as attachments
sum(email$image > email$attach)
```


```
# Question 1
email %>%
  filter(dollar > 0) %>%
  group_by(spam) %>%
  summarize(mean(dollar), median(dollar))

# Question 2
email %>%
  filter(dollar > 10) %>%
  ggplot(aes(x = spam)) +
  geom_bar()
```


```
# Reorder levels
email$number_reordered <- factor(email$number, levels = (c("none", "small", "big")))

# Construct plot of number_reordered
ggplot(email, aes(x = number_reordered)) +
  geom_bar() +
  facet_wrap(~ spam)
```


## Exploratory Visualization


```
# Load packages
library(moderndive)
library(ggplot2)

# Plot the histogram
ggplot(evals, aes(x = age)) +
  geom_histogram(binwidth = 5) +
  labs(x = "age", y = "count")
```


```
# Load packages
library(moderndive)
library(dplyr)

# Compute summary stats
evals %>%
  summarize(mean_age = mean(age),
            median_age = median(age),
            sd_age = sd(age))
```


```
# Load packages
library(moderndive)
library(ggplot2)

# Plot the histogram
ggplot(house_prices, aes(x = sqft_living)) +
  geom_histogram() +
  labs(x = "Size (sq.feet)", y = "count")
```


log 10 transformation


```
# Load packages
library(moderndive)
library(dplyr)
library(ggplot2)

# Add log10_size
house_prices_2 <- house_prices %>%
  mutate(log10_size = log10(sqft_living))
```


```
# Load packages
library(moderndive)
library(dplyr)
library(ggplot2)

# Add log10_size
house_prices_2 <- house_prices %>%
  mutate(log10_size = log10(sqft_living))

# Plot the histogram  
ggplot(house_prices_2, aes(x = log10_size)) +
  geom_histogram() +
  labs(x = "log10 size", y = "count")
```


## Exploratory Data Analysis of continuous variables


```
# Plot the histogram
ggplot(evals, aes(x = bty_avg)) +
  geom_histogram(binwidth = 0.5) +
  labs(x = "Beauty score", y = "count")
```


```
# Scatterplot
ggplot(evals, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "beauty score", y = "teaching score")
```


```
# Jitter plot
ggplot(evals, aes(x = bty_avg, y = score)) +
  geom_jitter() +
  labs(x = "beauty score", y = "teaching score")
```


```
# Compute correlation
evals %>%
  summarize(correlation = cor(score, bty_avg))
```


```
# View the structure of log10_price and waterfront
house_prices %>%
  select(log10_price, waterfront) %>%
  glimpse()

# Plot
ggplot(house_prices, aes(x = waterfront, y = log10_price)) +
  geom_boxplot() +
  labs(x = "waterfront", y = "log10 price")
```


```
# Calculate stats
house_prices %>%
  group_by(waterfront) %>%
  summarize(mean_log10_price = mean(log10_price), n = n())

# Prediction of price for houses with view
10^(6.12)

# Prediction of price for houses without view
10^(5.66)
```


## Plotting best fit regression line


```
# Load packages
library(ggplot2)
library(dplyr)
library(moderndive)

# Plot
ggplot(evals, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "beauty score", y = "score") +
  geom_smooth(method = "lm", se = FALSE)
```


```
# Load package
library(moderndive)

# Fit model
model_score_2 <- lm(score ~ bty_avg, data = evals)

# Output content
model_score_2

# Output regression table
get_regression_table(model_score_2)
```


## Residuals


```
# Use fitted intercept and slope to get a prediction
y_hat <- 3.88 + 0.067 * 5
y_hat

# Compute residual y - y_hat
4.7 - y_hat
```


```
# Fit regression model
model_score_2 <- lm(score ~ bty_avg, data = evals)

# Get regression table
get_regression_table(model_score_2)

# Get all fitted/predicted values and residuals
get_regression_points(model_score_2) %>%
  mutate(score_hat_2 = 3.88 + 0.067 * bty_avg)

# Get all fitted/predicted values and residuals
get_regression_points(model_score_2) %>%
  mutate(residual_2 = score - score_hat)
```


## Boxplot


```
ggplot(data = evals, aes(x = rank, y = score)) +
  geom_boxplot() +
  labs(x = "rank", y = "score")

evals %>%
  group_by(rank) %>%
  summarize(n = n(), mean_score = mean(score), sd_score = sd(score))
```


## Fitting regression to categorical


```
# Fit regression model
model_score_4 <- lm(score ~ rank, data = evals)

# Get regression table
get_regression_table(model_score_4)

# teaching mean
teaching_mean <- 4.2843

# tenure track mean
tenure_track_mean <- teaching_mean - 0.1297

# tenured mean
tenured_mean <- teaching_mean - 0.1452
```


```
# Calculate predictions and residuals
model_score_4_points <- get_regression_points(model_score_4)
model_score_4_points
```


## Modeling with basic linear regression


```
# Calculate predictions and residuals
model_score_4_points <- get_regression_points(model_score_4)
model_score_4_points

# Plot residuals
ggplot(model_score_4_points, aes(x = residual)) +
  geom_histogram() +
  labs(x = "residuals", title = "Residuals from score ~ rank model")
```


## Multiple regression modeling


```
# Remove outlier
house_prices_transform <- house_prices %>%
  filter(bedrooms < 20)

# Create scatterplot with regression line
ggplot(house_prices_transform, aes(x = bedrooms, y = log10_price)) +
  geom_point() +
  labs(x = "Number of bedrooms", y = "log10 price") +
  geom_smooth(method = "lm", se = FALSE)
```


## Fitting a regression


```
# Fit model
model_price_2 <- lm(log10_price ~ log10_size + bedrooms,
                    data = house_prices)

# Get regression table
get_regression_table(model_price_2)
```


## making predictions


```
# Make prediction in log10 dollars
2.69 + 0.941 * log10(1000) - 0.033 * 3

# Make prediction dollars
10^(2.69 + 0.941 * log10(1000) - 0.033 * 3)
```


## Interpreting residuals


```
# Automate prediction and residual computation
get_regression_points(model_price_2) %>%
  mutate(sq_residuals = (residual)^2) %>%
  summarize(sum_sq_residuals = sum(sq_residuals))
```


## parallel slopes model


to quantify relationships between multiple explanatory variables


```
# Fit model
model_price_4 <- lm(log10_price ~ log10_size + waterfront,
                    data = house_prices)

# Get regression table
get_regression_table(model_price_4)
```


## making predictions with multiple explanatory variables


```
# Get regression table
get_regression_table(model_price_4)

# Prediction for House A
10^(2.96 + 0.825*2.9 + 0.322*1)

# Prediction for House B
10^(2.96 + 0.825*3.1 + 0.322*0)
```


and with new data


```
# View the "new" houses
new_houses_2

# Get predictions on "new" houses
get_regression_points(model_price_4, newdata = new_houses_2) %>%
  mutate(price_hat = 10^(log10_price_hat))
```


## Comparing models and sum of squared residuals


```
# Model 2
model_price_2 <- lm(log10_price ~ log10_size + bedrooms,
                    data = house_prices)

# Calculate squared residuals
get_regression_points(model_price_2) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(sum_sq_residuals = sum(sq_residuals))
```


model 2 returns 605


```
# Model 4
model_price_4 <- lm(log10_price ~ log10_size + waterfront,
                    data = house_prices)

# Calculate squared residuals
get_regression_points(model_price_4) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(sum_sq_residuals = sum(sq_residuals))
```


model 4 returns 599



## r - squared


```
# Fit model
model_price_2 <- lm(log10_price ~ log10_size + bedrooms,
                    data = house_prices)

# Get fitted/values & residuals, compute R^2 using residuals
get_regression_points(model_price_2) %>%
  summarize(r_squared = 1 - var(residual) / var(log10_price))
```


```
# Fit model
model_price_4 <- lm(log10_price ~ log10_size + waterfront,
                    data = house_prices)

# Get fitted/values & residuals, compute R^2 using residuals
get_regression_points(model_price_4) %>%
  summarize(r_squared = 1 - var(residual) / var(log10_price))
```


## Root Mean Squared Error RMSE


square root of the mean squared error, typical prediction error of the model used for model assessment and selection, a smaller value of the RMSE is better


```
# Get all residuals, square them, and take mean                    
get_regression_points(model_price_2) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(mse = mean(sq_residuals))
```

```
# Get all residuals, square them, take the mean and square root
get_regression_points(model_price_2) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(mse = mean(sq_residuals)) %>%
  mutate(rmse = sqrt(mse))
```

```
# MSE and RMSE for model_price_2
get_regression_points(model_price_2) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(mse = mean(sq_residuals), rmse = sqrt(mean(sq_residuals)))

# MSE and RMSE for model_price_4
get_regression_points(model_price_4) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(mse = mean(sq_residuals), rmse = sqrt(mean(sq_residuals)))
```


## training and testing models


```
# Set random number generator seed value for reproducibility
set.seed(76)

# Randomly reorder the rows
house_prices_shuffled <- house_prices %>%
  sample_frac(size = 1, replace = FALSE)

# Train/test split
train <- house_prices_shuffled %>%
  slice(1:10000)
test <- house_prices_shuffled %>%
  slice(10001:21613)

# Fit model to training set
train_model_2 <- lm(log10_price ~ log10_size + bedrooms, data = train)

# Make predictions on test set
get_regression_points(train_model_2, newdata = test)

# Compute RMSE
get_regression_points(train_model_2, newdata = test) %>%
  mutate(sq_residuals = residual^2) %>%
  summarize(rmse = sqrt(mean(sq_residuals)))
```




# Packages


## moderndive


## tidyverse


## openintro


## stats


- `lm()`


## broom


- `augment()`


## 
