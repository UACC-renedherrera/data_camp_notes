---
title: Exploratory Data Analysis in R
subtitle: Exploring Categorical Data
---

# Contingency table review


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

```
# Print the first rows of the data
comics

# Check levels of align
levels(comics$align)

# Check the levels of gender
levels(comics$gender)

# Create a 2-way contingency table
table(comics$gender, comics$align)
```

# Dropping levels

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


# Side-by-side barcharts

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

# Counts vs. proportions

```
# Plot of gender by align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar()

# Plot proportion of gender, conditional on align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar(position = "fill") +
  ylab("proportion")
```

# Marginal barchart

```
# Change the order of the levels in align
comics$align <- factor(comics$align,
                       levels = c("Bad", "Neutral", "Good"))

# Create plot of align
ggplot(data = comics, aes(x = align)) +
  geom_bar()
```

# Conditional barchart

```
# Plot of alignment broken down by gender
ggplot(comics, aes(x = align)) +
  geom_bar() +
  facet_wrap(~ gender)
```

# Improve piechart

```
# Put levels of flavor in descending order
lev <- c("apple", "key lime", "boston creme", "blueberry", "cherry", "pumpkin", "strawberry")
pies$flavor <- factor(pies$flavor, levels = lev)

# Create barchart of flavor
ggplot(data = pies, aes(x = flavor)) +
  geom_bar(fill = "chartreuse") +
  theme(axis.text.x = element_text(angle = 90))
```
