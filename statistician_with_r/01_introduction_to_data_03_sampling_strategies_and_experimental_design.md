---
title: Introduction to Data in R
subtitle: Sampling strategies and experimental design
---

# Simple random sample in R

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


# Stratified sample in R

```
# Stratified sample
states_str <- us_regions %>%
  group_by(region) %>%
  sample_n(2)

# Count states by region
states_str %>%
  count(region)
```
