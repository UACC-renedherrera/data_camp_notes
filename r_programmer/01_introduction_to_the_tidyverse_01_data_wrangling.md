---
title: Introduction to the Tidyverse
subtitle: Data wrangling
---

# Loading the gapminder and dplyr packages

```
# Load the gapminder package
library(gapminder)

# Load the dplyr package
library(dplyr)

# Look at the gapminder dataset
gapminder
```

# Filtering for one year

```
library(gapminder)
library(dplyr)

# Filter the gapminder dataset for the year 1957
gapminder %>%
filter(year == 1957)
```

# Filtering for one country and one year

```
library(gapminder)
library(dplyr)

# Filter for China in 2002
gapminder %>%
(year == 2002,
  country == "China")
```

# Arranging observations by life expectancy

```
library(gapminder)
library(dplyr)

# Sort in ascending order of lifeExp
gapminder %>%
arrange(lifeExp)

# Sort in descending order of lifeExp
gapminder %>%
arrange(desc(lifeExp))
```

# Filtering and arranging

```
library(gapminder)
library(dplyr)

# Filter for the year 1957, then arrange in descending order of population
gapminder %>%
filter(year == 1957) %>%
arrange(desc(pop))
```

# Using mutate to change or create a column

```
library(gapminder)
library(dplyr)

# Use mutate to change lifeExp to be in months
gapminder %>%
mutate(lifeExp = 12 * lifeExp)

# Use mutate to create a new column called lifeExpMonths
gapminder %>%
mutate(lifeExpMonths = 12 * lifeExp)
```

# Combining filter, mutate, and arrange

```
library(gapminder)
library(dplyr)

# Filter, mutate, and arrange the gapminder dataset
gapminder %>%
filter(year == 2007) %>%
mutate(lifeExpMonths = 12 * lifeExp) %>%
arrange(desc(lifeExpMonths))
```
