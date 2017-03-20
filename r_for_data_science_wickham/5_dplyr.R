# data transformation from R for data science by Hadley Wickham
# install.packages("nycflights13") 
library(nycflights13)
library(tidyverse) 

# filter - pick observations by their values ####
  # select all flights on January 1st
jan1 <- filter(flights, month == 1, day == 1)

(dec25 <- filter(flights, month == 12, day == 25))

# there is a problem sometimes with ==, but you can use near
sqrt(2) ^ 2 == 2 # returns false
near(sqrt(2) ^ 2, 2)

filter(flights, near(month, 12))

# y & !x - y and not x
# x | y - x or y
# x & y - both x and y
# xor(x,y) - everything that is x or y but not both x and y
# !(x | y) - not x or not y
# !(x & y) - not x and not y

filter(flights, month == 11 | month == 12) # this doesn't work properly because of the numeric nature of the data

# fix with %in%
nov_dec <- filter(flights, month %in% c(11,12))

# find flights that weren't delayed by more than 2 hours (120 minutes)
filter(flights, !(arr_delay > 120 | dep_delay > 120))

filter(flights, arr_delay <= 120, dep_delay <= 120)

# dealing with NAs
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# Exercises ####
# Find all flights that

# Had an arrival delay of two or more hours
filter(flights, arr_delay >= 120)

# Flew to Houston (IAH or HOU)
filter(flights, dest == "IAH" |  dest == "HOU")

# Were operated by United, American, or Delta
filter(flights, carrier %in% c("AA", "DL", "UA"))

# Departed in summer (July, August, and September)
filter(flights, month %in% c(7,8,9))

# Arrived more than two hours late, but didn’t leave late
filter(flights, arr_delay >= 120 & dep_delay == 0)

# Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay >= 60 & arr_delay > 30)

# Departed between midnight and 6am (inclusive)
filter(flights, dep_time <= 600)

# Another useful dplyr filtering helper is between(). What does it do? Can you use it to simplify the code needed to answer the previous challenges?
filter(flights, between(month, 7, 9))

# How many flights have a missing dep_time? What other variables are missing? What might these rows represent?
filter(flights, is.na(dep_time)) # flights that were cancelled

# Why is NA ^ 0 not missing? Why is NA | TRUE not missing? Why is FALSE & NA not missing? Can you figure out the general rule? (NA * 0 is a tricky counterexample!)
# because anything that is raised to the zero power is 1, and the other statements are truth


# arrange Reorder the rows (arrange()) ####
arrange(flights, year,  month, day)
arrange(flights, desc(arr_delay)) # sort in descending order

# missing values are sorted at the end, always
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

# How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).
arrange(df, desc(is.na(x)))

# Sort flights to find the most delayed flights. Find the flights that left earliest.
arrange(flights, desc(dep_delay)) # most delayed
arrange(flights, dep_delay) # flights that left ahead of schedule

# Sort flights to find the fastest flights.
arrange(flights, air_time)

# Which flights travelled the longest? Which travelled the shortest?
arrange(flights, desc(distance))
arrange(flights, distance)

# select - Pick variables by their names (select()) #####
select(flights, year, month, day)

# choose a range of columns
select(flights, year:day)

# select all columns except a range
select(flights, -(year:day))

# choose flight tail numbers that start with...
select(flights, starts_with("N2", vars = tailnum))

# choose flight tail numbers that end with...
select(flights, ends_with("JB", vars = tailnum))

# choose flight tail numbers that contain...
select(flights, contains("19", vars = tailnum))

# match a regular expression - this one looks for repeated characters
select(flights, matches("(.)\\1", vars = carrier))

####### USEFUL #########
# find variables that are attached to range of numbers
select(flights, num_range("N", 1:3, vars = tailnum)) #- matches x1, x2, x3

##### USEFUL ########
# can be used to rename variables
rename(flights, tail_num = tailnum) # the new name = the old name

##### USEFUL ########
# move columns to the beginning of the data frame, everything will put everything else after
select(flights, time_hour, air_time, everything())

# Exercises ####
# Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.

# What happens if you include the name of a variable multiple times in a select() call? nothing
select(flights, hour, minute, hour, hour)

# What does the one_of() function do? Why might it be helpful in conjunction with this vector?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, one_of(vars)) # allows you to select from a list of defined columns

# Does the result of running the following code surprise you? How do the select helpers deal with case by default? How can you change that default?

select(flights, contains("TIME")) # chooses any name that has time in it and doesn't care about case.  Not sure how to change it or how helpers help.

# mutate - Create new variables with functions of existing variables (mutate()). #####
# make a smaller dataset so you can see the newly added columns
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

# create the columns gain and speed
mutate(flights_sml, 
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
       )

# you can refer to the newly made columns
mutate(flights_sml, 
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain/hours
)

# if you only want to keep the newly made columns use transmute
transmute(flights_sml, 
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain/hours
)

##### MAYBE USEFUL ########
# calculate hour and minute from dep_time (their dep_time is entered as 527 for 05:27)
transmute(flights, 
          dep_time, 
          hour = dep_time %/% 100 # %/% integer division
          minute = dep_time %% 100) # %% the remainder of that division

# find when a number is skipped, this doesn't appear to work
x <- c(1:10, 12:15)
(x != lag(x))

# rolling sum or mean
x <- 1:10
cumsum(x)
cummean(x)

###### USEFUL ######
# rank values
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)

#> [1]  1  2  2 NA  4  5 # meaning that the first value is ranked 1st, the next two are in a tie for second, and then the 3 is ranked 4th and 4 is ranked 5th

min_rank(desc(y)) # rank with the largest value as first
#> [1]  5  3  3 NA  2  1

# If min_rank() doesn’t do what you need, look at the variants row_number(), dense_rank(), percent_rank(), cume_dist(), ntile(). See their help pages for more details.

# Exercises
# Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with because they’re not really continuous numbers. Convert them to a more convenient representation of number of minutes since midnight.
transmute(flights,
          dep_time,
          hour = (dep_time %/% 100) * 60,
          minute = (dep_time %% 100),
          dep_minutes = hour + minute
)

transmute(flights,
          sched_dep_time,
          hour = (sched_dep_time %/% 100) * 60,
          minute = (sched_dep_time %% 100),
          sched_dep_minutes = hour + minute
)


# Compare air_time with arr_time - dep_time. What do you expect to see? What do you see? What do you need to do to fix it?
select(flights, air_time)
transmute(flights, arr_time - dep_time)
# would need to convert arr_time and dep_time into minutes since midnight before doing the math


# Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
select(flights, dep_time, sched_dep_time, dep_delay)

# Find the 10 most delayed flights using a ranking function. How do you want to handle ties? Carefully read the documentation for min_rank().
min_rank(desc(flights$dep_delay))
# not sure about the ties thing

# What does 1:3 + 1:10 return? Why?
# [1]  2  4  6  5  7  9  8 10 12 11
# Warning message:
#   In 1:3 + 1:10 :
#   longer object length is not a multiple of shorter object length

# What trigonometric functions does R provide? sin, cos, tan, etc.


# summarise - Collapse many values down to a single row (summarise()). #####
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# create a daily grouping
by_day <- group_by(flights, year, month, day) 
# show the mean dep delay for each day
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE)) 

# The pipe #####

# explore the relationship between the distance and average delay for each location
# the old way ...
# group flights by destination
by_dest <- group_by(flights, dest)

delay <- summarise(by_dest, # creates a table with one columns of all destinations
                   count = n(), # adds a column to count the number of rows in fligths for each dest
                   dist = mean(distance, na.rm = TRUE), # adds a column with the mean distance for each dest, skips NAs
                   delay = mean(arr_delay, na.rm = TRUE) # adds a column with the mean delay for each dest, skips NAs
                   )
                   
# now we want to reduce the dataset to destinations that have more than 20 flights and are not Honolulu
delay <- filter(delay, count > 20, dest != "HNL")

# plot it
ggplot(data = delay, mapping = aes(x = dist, y = delay)) + # for the data compare delays as they depend on distance
  geom_point(aes(size = count), alpha = 1/3) + # make a scatter plot with the dots increase in size as the number of flights increases and make them sort of transparent
  geom_smooth(se = FALSE) # add a line but remove the standard error

# instead use a pipe
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = T),
    delay = mean(arr_delay, na.rm = T)
                 ) %>% 
      filter(count > 20, dest != "HNL")

# missing values ####
# get rid of NAs so that the dataset is easier to work with
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# Counts ####
# which plane tail numbers have the highest average delays
delays <- not_cancelled %>% # from the flights that don't have NAs
  group_by(tailnum) %>% # make a column of tail numbers
  summarise(
    delay = mean(arr_delay, na.rm = TRUE) # add a column of mean delays
    n = n()
  )

# plot it
ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

# check out a scatter plot instead
delays <- not_cancelled %>% # from the flights that don't have NAs
  group_by(tailnum) %>% # make a column of tail numbers
  summarise(
    delay = mean(arr_delay, na.rm = TRUE), # add a column of mean delays
    n = n() # count the number of flights for each tailnum
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/3)

# filter out groups with small numbers of observations
delays %>% 
  filter(n>25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/3)

# compute the batting average of baseball players
# install.packages("Lahman")
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% # create the dataset
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = T), # calculate the batting average
    ab = sum(AB, na.rm = T) # how many times at bat
  )

batters %>% 
  filter(ab > 100) %>% # reduce the data to many times at bat
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se = F)

# summary functions ####
# location of data - the mean and the median
not_cancelled %>% 
  group_by(year, month, day) %>% # daily groups
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )

# spread of the data - standard deviation sd(), interquartile range IQR(), median absolute deviation mad(), the second two being useful for outliers.
# Why is distance to some destinations more variable than to others?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

# rank of data - min(x), quantile(x, 0.25), max(x)
# When do the first and last flights leave each day?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

# the position of the data - first(x), nth(x, 2), last(x)
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )

# filter will show all columns
not_cancelled %>% 
  group_by(year, month, day) %>% # group daily
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))

# n() counts the size of the current group, to count the number of non-missing values, use sum(!is.na(x)), to count the number of unique values, use n_distinct(x)
# Which destinations have the most carriers?
not_cancelled %>% 
  group_by(dest) %>% # group by destination
  summarise(carriers = n_distinct(carrier)) %>% # how many carriers at each dest
  arrange(desc(carriers)) # put the dest with the most at the top

# simple count
not_cancelled %>% 
  count(dest)

# you could use this to “count” (sum) the total number of miles a plane flew:
not_cancelled %>% 
  count(tailnum, wt = distance)

# How many flights left before 5am? (these usually indicate delayed flights from the previous day)
not_cancelled %>% 
  group_by(year, month, day) %>% # daily group
  summarise(n_early = sum(dep_time < 500)) # because dep_time is numeric, true =1, sum the 1's to get the number of flights

# What proportion of flights are delayed by more than an hour?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_perc = mean(arr_delay > 60)) # true = 1, mean of the results

# group by multiple variables
# each summary peels off one level of the grouping. That makes it easy to progressively roll up a dataset:
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))
# the sum of groupwise sums is the overall sum, but the median of groupwise medians is not the overall median.

# ungrouping ####
daily %>% 
  ungroup() %>%             # no longer grouped by date
  summarise(flights = n())  # all flights

# NEED TO DO Exercises ####

# Brainstorm at least 5 different ways to assess the typical delay characteristics of a group of flights. Consider the following scenarios:
#   
#   A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.
# 
# A flight is always 10 minutes late.
# 
# A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
# 
# 99% of the time a flight is on time. 1% of the time it’s 2 hours late.
# 
# Which is more important: arrival delay or departure delay?
# 
# Come up with another approach that will give you the same output as not_cancelled %>% count(dest) and not_cancelled %>% count(tailnum, wt = distance) (without using count()).
# 
# Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay) ) is slightly suboptimal. Why? Which is the most important column?
# 
# Look at the number of cancelled flights per day. Is there a pattern? Is the proportion of cancelled flights related to the average delay?
# 
# Which carrier has the worst delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights %>% group_by(carrier, dest) %>% summarise(n()))
# 
# For each plane, count the number of flights before the first delay of greater than 1 hour.


# What does the sort argument to count() do. When might you use it? To sort output into descending order of n

# grouped mutates ####
# Find the worst members of each group:
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10) # the 10 most delayed flights

# Find all groups bigger than a threshold:
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365) # how many destinations have more than 365 flights
popular_dests

# Standardise to compute per group metrics:
popular_dests %>% 
  filter(arr_delay > 0) %>% # didn't arrive early
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% # add a column for the % delay which standardizes
  select(year:day, dest, arr_delay, prop_delay) # shorten the df
 
# check out vignette("window-functions")

# NEED TO DO Exercises ####

# Refer back to the table of useful mutate and filtering functions. Describe how each operation changes when you combine it with grouping.
# 
# Which plane (tailnum) has the worst on-time record?
# 
# What time of day should you fly if you want to avoid delays as much as possible?
# 
# For each destination, compute the total minutes of delay. For each, flight, compute the proportion of the total delay for its destination.
# 
# Delays are typically temporally correlated: even once the problem that caused the initial delay has been resolved, later flights are delayed to allow earlier flights to leave. Using lag() explore how the delay of a flight is related to the delay of the immediately preceding flight.
# 
# Look at each destination. Can you find flights that are suspiciously fast? (i.e. flights that represent a potential data entry error). Compute the air time a flight relative to the shortest flight to that destination. Which flights were most delayed in the air?
# 
# Find all destinations that are flown by at least two carriers. Use that information to rank the carriers.