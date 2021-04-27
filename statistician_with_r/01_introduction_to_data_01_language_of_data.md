---
title: Introduction to Data in R
subtitle: Language of data
---

# Loading data in R

- Load the dataset with `data()`
- Preview with `str()`

```
# Load data
data(email50)

# View the structure of the data
str(email50)
```

# Identify variable types

- preview with `glimpse()`
- view table with `table()`


Inspect, and view, a data frame with any of the following:


- `str()`
- `glimpse()`
- `head()`
- `unique()`

```
# Glimpse email50
glimpse(email50)
```

# Filtering based on a factor

- filter a dataset with `filter()`
- remove unused factor levels with `droplevels()`
- wrap assignment with paranthesis to also print for example: `(data -> data %>% filter(number == "big"))`

```
# Subset of emails with big numbers: email50_big
email50_big <- email50 %>%
  filter(number == "big")

# Glimpse the subset
glimpse(email50_big)
```

# Complete filtering based on a factor


```
# Subset of emails with big numbers: email50_big
email50_big <- email50 %>%
  filter(number == "big")

# Table of the number variable
table(email50_big$number)

# Drop levels
email50_big$number_dropped <- droplevels(email50_big$number)

# Table of the number_dropped variable
table(email50_big$number_dropped)
```

# Discretize a different variable

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

```
# Calculate median number of characters: med_num_char
med_num_char <- median(email50$num_char)

# Create num_char_cat variable in email50
email50_fortified <- email50 %>%
  mutate(num_char_cat = ifelse(num_char < med_num_char, "below median", "at or above median"))

# Count emails in each category
email50_fortified %>%
  count(num_char_cat)
```

# Combining levels of a different factor

```
# Create number_yn column in email50
email50_fortified <- email50 %>%
  mutate(
    number_yn = case_when(
      # if number is "none", make number_yn "no"
      number == "none" ~ "no",
      # if number is not "none", make number_yn "yes"
      number != "none" ~ "yes"  
    )
  )


# Visualize the distribution of number_yn
ggplot(email50_fortified, aes(x = number_yn)) +
  geom_bar()
```

# Visualizing numerical and categorical data

- use ggplot2 package to create modern plots
- call ggplot2 with `ggplot()`; for example:


```
ggplot(email50, aes(x = num_char, y = exclaim_mess, color = factor(spam))) +
  geom_point()
```

```
# Load ggplot2
library(ggplot2)

# Scatterplot of exclaim_mess vs. num_char
ggplot(email50, aes(x = num_char, y = exclaim_mess, color = factor(spam))) +
  geom_point()
```
