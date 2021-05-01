---
title: Data Manipulation with dplyr
subtitle: Aggregating Data
---

#  Counting by region

```
# Use count to find the number of counties in each region
counties_selected %>%
  count(region, sort = TRUE)
```

```
# Use count to find the number of counties in each region
counties_selected %>%
  count(region) %>%
  arrange(desc(n))
```

# Counting citizens by state

```
# Find number of counties per state, weighted by citizens, sorted in descending order
counties_selected %>%
  count(state, wt = citizens, sort = TRUE)
```

# Mutating and counting

```
counties_selected %>%
  # Add population_walk containing the total number of people who walk to work
  mutate(population_walk = population * walk / 100) %>%
  # Count weighted by the new column, sort in descending order
  count(state, wt = population_walk, sort = TRUE)
```

# Summarizing

```
counties_selected %>%
  # Summarize to find minimum population, maximum unemployment, and average income
  summarize(min_population = min(population), max_unemployment = max(unemployment), average_income = mean(income))
```

# Summarizing by state

```
counties_selected %>%
  # Group by state
  group_by(state) %>%
  # Find the total area and population
  summarize(total_area = sum(land_area), total_population = sum(population)) %>%
  # Add a density column
  mutate(density = total_population / total_area) %>%
  # Sort by density in descending order
  arrange(desc(density))
```

# Summarizing by state and region

```
counties_selected %>%
  # Group and summarize to find the total population
  group_by(region, state) %>%
  summarize(total_pop = sum(population)) %>%
  # Calculate the average_pop and median_pop columns
  summarize(average_pop = mean(total_pop), median_pop = median(total_pop))
```

# Selecting a county from each region

```
counties_selected %>%
  # Group by region
  group_by(region) %>%
  # Find the greatest number of citizens who walk to work
  top_n(1, walk)
```

# Finding the highest-income state in each region

```
counties_selected %>%
  group_by(region, state) %>%
  # Calculate average income
  summarize(average_income = mean(income)) %>%
  # Find the highest income state in each region
  top_n(1, average_income)
```

# Using summarize, top_n, and count together

```
counties_selected %>%
  # Find the total population for each combination of state and metro
  group_by(state, metro) %>%
  summarize(total_pop = sum(population)) %>%
  # Extract the most populated row for each state
  top_n(1, total_pop) %>%
  # Count the states with more people in Metro or Nonmetro areas
  ungroup() %>%
  count(metro)
```
