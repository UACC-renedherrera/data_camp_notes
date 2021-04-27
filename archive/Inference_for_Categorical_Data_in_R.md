# Inference for Categorical Data in R


## Bootstrap


- using `library(infer)`
- `specify()` then `generate()` then `calculate()`


```
# Print gss data
print(gss)

# Load dplyr
library(dplyr)

gss2016 <- gss %>%
  # Filter for rows in 2016
  filter(year == 2016)

# Print gss2016 data
gss2016

# Load ggplot2
library(ggplot2)

# Plot distribution of consci
ggplot(gss2016, aes(x = consci)) +
  # Add a bar layer
  geom_bar()

# Compute proportion of high conf
p_hat <- gss2016 %>%
  summarize(prop_high = mean(consci == "High")) %>%
  pull()
```


## Generate via bootstrap


```
# Load the infer package
library(infer)

# Create single bootstrap data set
boot1 <- gss2016 %>%
  # Specify the response
  specify(response = consci, success = "High") %>%
  # Generate one bootstrap replicate
  generate(reps = 1, type = "bootstrap")

# See the result
boot1

# Using boot1, plot consci
ggplot(data = boot1, aes(x = consci)) +
  # Add bar layer
  geom_bar()

# Compute proportion with high conf
boot1 %>%
  summarize(prop_high = mean(consci == "High")) %>%
  pull()
```

## Construct a confidence interval


```
# Create bootstrap distribution for proportion with High conf
boot_dist <- gss2016 %>%
  # Specify the response and success
  specify(response = consci, success = "High") %>%
  # Generate 500 bootstrap reps
  generate(reps = 500, type = "bootstrap") %>%
  # Calculate proportions
  calculate(stat = "prop")

# See the result
boot_dist
```


```
# From previous step
boot_dist <- gss2016 %>%
  specify(response = consci, success = "High") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")

# Plot bootstrap distribution of stat
ggplot(data = boot_dist, aes(x = stat)) +
  # Add density layer
  geom_density()
```


```
# From previous steps
boot_dist <- gss2016 %>%
  specify(response = consci, success = "High") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")
ggplot(boot_dist, aes(x = stat)) +
  geom_density()

# Compute estimate of SE
SE <- boot_dist %>%
  summarize(se = sd(stat)) %>%
  pull()
```


```
# From previous steps
boot_dist <- gss2016 %>%
  specify(response = consci, success = "High") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")
ggplot(boot_dist, aes(x = stat)) +
  geom_density()
SE <- boot_dist %>%
  summarize(se = sd(stat)) %>%
  pull()

# Create CI
c((p_hat-2*SE), (p_hat+2*SE))
```


## Interpret a Confidence Interval


Interpretation of a 95% confidence interval:


> "We're 95% confident that the true proportion of Americans that are happy is between 0.705 and 0.841."


```
# Create bootstrap distribution for proportion
boot_dist_small <- gss2016_small %>%
  # Specify the variable and success
  specify(response = consci, success = "High") %>%
  # Generate 500 bootstrap reps
  generate(reps = 500, type = "bootstrap") %>%
  # Calculate the statistic
  calculate(stat = "prop")

# See the result
glimpse(boot_dist_small)
```


```
# From previous step
boot_dist_small <- gss2016_small %>%
  specify(response = consci, success = "High") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")

# Compute and save estimate of SE
SE_small_n <- boot_dist_small %>%
  summarize(se = sd(stat)) %>%
  pull()

# See the result
SE_small_n
```


```
# From previous steps
boot_dist_small <- gss2016_small %>%
  specify(response = consci, success = "High") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")
SE_small_n <- boot_dist_small %>%
  summarize(se = sd(stat)) %>%
  pull()

# Generate bootstrap distribution for smaller data
boot_dist_smaller <-gss2016_smaller %>%
  specify(response = consci, success = "High") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")

# See the result
glimpse(boot_dist_smaller)
```


```
# From previous steps
boot_dist_small <- gss2016_small %>%
  specify(response = consci, success = "High") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")
SE_small_n <- boot_dist_small %>%
  summarize(se = sd(stat)) %>%
  pull()
boot_dist_smaller <- gss2016_smaller %>%
  specify(response = consci, success = "High") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")

# Compute and save estimate of second SE
SE_smaller_n <- boot_dist_smaller %>%
  summarize(se = sd(stat)) %>%
  pull()

# Compare the results for each dataset size
message("gss2016_small has ", nrow(gss2016_small), " rows and standard error ", SE_small_n)
message("gss2016_smaller has ", nrow(gss2016_smaller), " rows and standard error ", SE_smaller_n)
```


## Standard Error with different p


```
ggplot(gss2016, aes(x = meta_region)) +
  geom_bar()

# Specify the response for the bootstrap distribution
boot_dist <- gss2016 %>%
  specify(response = meta_region, success = "pacific") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")
```


```
# From previous steps
ggplot(gss2016, aes(x = meta_region)) +
  geom_bar()
boot_dist <- gss2016 %>%
  specify(response = meta_region, success = "pacific") %>%
  generate(reps = 500, type = "bootstrap") %>%
  calculate(stat = "prop")

# Calculate std error
SE_low_p <- boot_dist %>%
  summarize(se = sd(stat)) %>%
  pull()

# Compare SEs
c(SE_low_p, SE)
```


## Approximation


```
# Calculate n as the number of rows
n <- nrow(gss2016)

# Calculate p_hat as the proportion in pacific meta region
p_hat <- gss2016 %>%
  summarize(prop_pacific = mean(meta_region == "pacific")) %>%
  pull()

# See the result
p_hat

# Check conditions
n * p_hat >= 10
n * (1 - p_hat) >= 10

# Calculate SE
SE_approx <- sqrt((p_hat*(1-p_hat))/(n))

# Form 95% CI
c(n * p_hat, n * (1 - p_hat))
```


##


```
# Using `gss2016`, plot postlife
ggplot(data = gss2016, aes(x = postlife)) +
  # Add bar layer
  geom_bar()

# Calculate and save proportion that believe
p_hat <- gss2016 %>%
  summarize(prop_yes = mean(postlife == "YES") %>%
  pull()

# See the result
p_hat
```


## Generate from H0


```
# Generate one data set under H0
sim1 <- gss2016 %>%
  # Specify the response and success
  specify(response = postlife, success = "YES") %>%
  # Hypothesize the null value of p
  hypothesize(null = "point", p = 0.75) %>%
  # Generate a single simulated dataset
  generate(reps = 1, type = "simulate")

# See the result
sim1

# Using sim1, plot postlife
ggplot(data = sim1, aes(x = postlife)) +
  # Add bar layer
  geom_bar()

# Compute proportion that believe
sim1 %>%
  summarize(prop_yes = mean(postlife == "YES")) %>%
  pull()
```


## Testing


```
# Generate null distribution
null <- gss2016 %>%
  specify(response = postlife, success = "YES") %>%
  hypothesize(null = "point", p = 0.75) %>%
  generate(reps = 500, type = "simulate") %>%
  # Calculate proportions
  summarize(stat = mean(postlife == "YES"))

# Visualize null distribution
ggplot(data = null, aes(x = stat)) +
  # Add density layer
  geom_density() +
  # Add line at observed
  geom_vline(xintercept = p_hat, color = "red")
```


```
# From previous step
null <- gss2016 %>%
  specify(response = postlife, success = "YES") %>%
  hypothesize(null = "point", p = 0.75) %>%
  generate(reps = 500, type = "simulate") %>%
  calculate(stat = "prop")

null %>%
  summarize(
    # Compute the one-tailed p-value
    one_tailed_pval = mean(stat >= p_hat),
    # Compute the two-tailed p-value
    two_tailed_pval = one_tailed_pval * 2
  ) %>%
  pull(two_tailed_pval)
```


## Intervals


```
# Plot distribution of sex filled by cappun
ggplot(data = gss2016, aes(x = sex, fill = cappun)) +
  # Add bar layer
  geom_bar(position = "fill")
```


```
# Compute two proportions
p_hats <- gss2016 %>%
  # Group by sex
  group_by(sex) %>%
  # Calculate proportion that FAVOR
  summarize(prop_favor = mean(cappun == "FAVOR")) %>%
  pull()

# See the result
p_hats

# Compute difference in proportions
d_hat <- diff(p_hats)

# See the result
d_hat
```


```
# Create null distribution
null <- gss2016 %>%
  # Specify the response and explanatory as well as the success
  specify(cappun ~ sex, success = "FAVOR") %>%
  # Set up null hypothesis
  hypothesize(null = "independence") %>%
  # Generate 500 reps by permutation
  generate(reps = 500, type = "permute") %>%
  # Calculate the statistics
  calculate(stat = "diff in props", order = c("FEMALE", "MALE"))

# Visualize null
ggplot(data = null, aes(x = stat)) +
  # Add density layer
  geom_density() +
  # Add red vertical line at obs stat
  geom_vline(xintercept = d_hat, color = "red")

# Compute two-tailed p-value
null %>%
  summarize(
    one_tailed_pval = mean(stat <= d_hat),
    two_tailed_pval = one_tailed_pval * 2
  ) %>%
  pull(two_tailed_pval)
```


## Hypothesis tests and confidence intervals


```
# Create the bootstrap distribution
boot <- gss2016 %>%
  # Specify the variables and success
  specify(cappun ~ sex, success = "FAVOR") %>%
  # Generate 500 bootstrap reps
  generate(reps = 500, type = "bootstrap") %>%
  # Calculate statistics
  calculate(stat = "diff in props", order = c("FEMALE", "MALE"))

# Compute the standard error
SE <- boot %>%
  summarize(se = sd(stat)) %>%
  pull()

# Form the CI (lower, upper)
c(d_hat - 2*SE, d_hat + 2*SE)
```


## Statistical Error


```
# Inspect coinflip
gssmod %>%
  select(coinflip)

# Compute two proportions
p_hats <- gssmod %>%
  group_by(coinflip) %>%
  summarize(prop_favor = mean(cappun == "FAVOR")) %>%
  pull()

# See the result
p_hats

# Compute difference in proportions
d_hat <- diff(p_hats)

# Form null distribution
null <- gssmod %>%
  # Specify the response and explanatory var and success
  specify(cappun ~ coinflip, success = "FAVOR") %>%
  # Set up the null hypothesis
  hypothesize(null = "independence") %>%
  # Generate 500 permuted data sets
  generate(reps = 500, type = "permute") %>%
  # Calculate statistics
  calculate(stat = "diff in props", order = c("heads", "tails"))

# Visualize null
ggplot(data = null, aes(x = stat)) +
  # Add density layer
  geom_density() +
  # Add vertical red line at observed stat
  geom_vline(xintercept = d_hat, color = "red")
```


```
# Set alpha
alpha <- 0.05

# Find cutoffs
lower <- null %>%
  summarize(l = quantile(stat, probs = alpha/2)) %>%
  pull()
upper <- null %>%
  summarize(u = quantile(stat, probs = 1-alpha/2)) %>%
  pull()

# Is d_hat inside cutoffs?
d_hat %>%
  between(lower, upper)

# Visualize cutoffs
ggplot(null, aes(x = stat)) +
  geom_density() +
  geom_vline(xintercept = d_hat, color = "red") +
  # Add vertical blue line for lower cutoff
  geom_vline(xintercept = lower, color = "blue") +
  # Add vertical blue line for upper cutoff
  geom_vline(xintercept = upper, color = "blue")
```


## Contingency Tables


```
# Subset data
gss_party <- gss2016 %>%
  # Filter out the "Oth"
  filter( party != "Oth")

# Visualize distribution take 1
ggplot(data = gss_party, aes(x = party, fill = natspac)) +
  # Add bar layer of proportions
  geom_bar(position = "fill")

# Visualize distribution take 2
ggplot(data = gss_party, aes(x = party, fill = natspac)) +
  # Add bar layer of counts
  geom_bar()
```


```
# Create table of natspac and party
Obs <- gss_party %>%
  # Select columns of interest
  select(natspac, party) %>%
  # Create table
  table()

# Convert table back to tidy df
Obs %>%
  # Tidy the table
  tidy() %>%
  # Expand out the counts
  uncount(n)
```


## Chi-squared test statistic


```
# Create one permuted data set
perm_1 <- gss_party %>%
  # Specify the variables of interest
  specify(natarms ~ party) %>%
  # Set up the null
  hypothesize(null = "independence") %>%
  # Generate a single permuted data set
  generate(reps = 1, type = "permute")

# Visualize permuted data
ggplot(data = perm_1, aes (x = party, fill = natarms)) +
  # Add bar layer
  geom_bar()

# Compute chi-squared stat
gss_party %>%
  chisq_stat(natarms ~ party)
```


```
# Create null
null_spac <- gss_party %>%
  specify(natspac ~ party) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 500, type = "permute") %>%
  calculate(stat = "Chisq")

# Visualize null
ggplot(data = null_spac, aes(x = stat)) +
  # Add density layer
  geom_density() +
  # Add vertical line at obs stat
  geom_vline(xintercept = chi_obs_spac, color = "red")

# Create null that natarms and party are indep
null_arms <- gss_party %>%
  specify(natarms ~ party) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 500, type = "permute") %>%
  calculate(stat = "Chisq")

# Visualize null
ggplot(null_arms, aes(x = stat)) +
  # Add density layer
  geom_density() +
  # Add vertical red line at obs stat
  geom_vline(xintercept = chi_obs_arms, color = "red")
```


## Hypothesis Test via Approximation distribution


```
# Visualize distribution of region and happy
ggplot(data = gss2016, aes(x = region, fill = happy)) +
  # Add bar layer of proportions
  geom_bar(position = "fill")

# Calculate and save observed statistic
chi_obs <- gss2016 %>%
  chisq_stat(region ~ happy)

# See the result
chi_obs
```


```
# Generate null distribution
null <- gss2016 %>%
  # Specify variables
  specify(happy ~ region, success = "HAPPY") %>%
  # Set up null
  hypothesize(null = "independence") %>%
  # Generated 500 permuted data sets
  generate(reps = 500, type = "permute") %>%
  # Calculate statistics
  calculate(stat = "Chisq")

# Visualize null
ggplot(data = null, aes(x = stat)) +
  # Add density layer
  geom_density() +
  # Add red vertical line at obs stat
  geom_vline(xintercept = chi_obs, color = "red") +
  # Overlay chisq approximation
  stat_function(fun = dchisq, args = list(df = 3), color = "blue")

# Calculate computational pval
null %>%
  summarize(pval = mean(stat >= chi_obs))

# Calculate approximate pval
pchisq(chi_obs, df = 3, lower.tail = FALSE)
```


##


```
# Compute and save candidate totals
totals <- iran %>%
  summarize(ahmadinejad = sum(ahmadinejad),
            rezai = sum(rezai),
            karrubi = sum(karrubi),
            mousavi = sum(mousavi))

# Inspect totals
totals

# Gather data
gathered_totals <- totals %>%
  gather(key = candidate, value = votes)

# Inspect gathered totals
gathered_totals

# Plot total votes for each candidate
ggplot(gathered_totals, aes(x = candidate, y = votes)) +
  # Add col layer
  geom_col()

# Construct province-level dataset
province_totals <- iran %>%
  # Group by province
  group_by(province) %>%
  # Sum up votes for top two candidates
  summarize(ahmadinejad = sum(ahmadinejad), mousavi = sum(mousavi))

# Inspect data frame
province_totals

# Filter for won provinces won by #2
province_totals %>%
  filter(mousavi > ahmadinejad)
```


```
# Print get_first
get_first

# Create first_digit variable
iran <- iran %>%
  mutate(first_digit = get_first(total_votes_cast))

# Check if get_first worked
iran %>%
  select(total_votes_cast, first_digit)

# Construct bar plot
ggplot(iran, aes(x = first_digit)) +
  # Add bar layer
  geom_bar()
```


## Goodness of Fit Test


```
# Inspect p_benford
p_benford

# Compute observed stat
chi_obs_stat <- iran %>%
  chisq_stat(response = first_digit, p = p_benford)

# Form null distribution
null <- iran %>%
  # Specify the response
  specify(response = first_digit) %>%
  # Set up the null hypothesis
  hypothesize(null = "point", p = p_benford) %>%
  # Generate 500 reps
  generate(reps = 500, type = "simulate") %>%
  # Calculate statistics
  calculate(stat = "Chisq")
```


```
# Compute degrees of freedom
degrees_of_freedom <- iran %>%
  # Pull out first_digit vector
  pull("first_digit") %>%
  # Calculate n levels and subtract 1
  nlevels() -1

# Plot both null dists
ggplot(null, aes(x = stat)) +
  # Add density layer
  geom_density() +
  # Add vertical line at obs stat
  geom_vline(xintercept = chi_obs_stat, color = "red") +
  # Overlay chisq approx
  stat_function(fun = dchisq, args = list(df = degrees_of_freedom), color = "blue")

# Permutation p-value
null %>%
  summarize(pval = mean(stat >= chi_obs_stat))

# Approximation p-value
pchisq(chi_obs_stat, df = degrees_of_freedom, lower.tail = FALSE)
```


## extract first digit


```
# Get Iowa county vote totals
iowa_county <- iowa %>%
  # Filter for rep/dem
  filter(candidate %in% c("Hillary Clinton / Tim Kaine", "Donald Trump / Mike Pence")) %>%
  # Group by county
  group_by(county) %>%
  # Compute total votes in each county
  summarize(dem_rep_votes = sum(votes))

# See the result
iowa_county

# Add first_digit
iowa_county <- iowa_county %>%
  mutate(first_digit = get_first(dem_rep_votes))

# See the result
iowa_county

# Using iowa_county, plot first_digit
ggplot(data = iowa_county, aes(x = first_digit)) +
  # Add bar layer
  geom_bar()

# See the result
iowa_county

# Compute observed stat
chi_obs_stat <- iowa_county %>%
  chisq_stat(response = first_digit, p = p_benford)

# Form null distribution
null <- iowa_county %>%
  # Specify response
  specify(response = first_digit) %>%
  # Set up null
  hypothesize(null = "point", p = p_benford) %>%
  # Generate 500 reps
  generate(reps = 500, type = "simulate") %>%
  # Calculate statistics
  calculate(stat = "Chisq")

# Visualize null stat
ggplot(data = null, aes(x = stat)) +
  # Add density layer
  geom_density() +
  # Add vertical line at observed stat
  geom_vline(xintercept = chi_obs_stat, color = "red")
```
