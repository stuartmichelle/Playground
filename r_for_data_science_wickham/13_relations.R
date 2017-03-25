# relational data wickham

library(tidyverse)
library(nycflights13)


# test - want to keep all in x and all in y that is not in x

x <- planes[1:10, 1:3]
y <- planes[5:15, 1:3]

z <- anti_join(x, y)

# keys ####
# count to make sure your primary key is actually primary
planes %>% 
  count(tailnum) %>% 
  filter(n > 1)
 
# should return 0

weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n > 1)

# some tables don't have a primary key, they need a surrogate key (row number)
flights %>% 
  count(year, month, day, flight) %>% 
  filter(n > 1)

flights %>% mutate("key" = row_number())

# mutating joins ####
# combine data from two tables
# create a nearrower dataset for simplicity of viewing
flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)

# join flights to airlines by carrier
flights2 %>% # take the flights2 tables
  select(-origin, -dest) %>%  # include all columns except origin and dest
  left_join(airlines, by = "carrier") # join flights to airlines by carrier

# could've gotten the same result using 
flights2 %>%
  select(-origin, -dest) %>% 
  mutate(name = airlines$name[match(carrier, airlines$carrier)])

# explaining joins
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

# inner join ####
# only keep what is in common
x %>% 
  inner_join(y, by = "key")

# outer join ####
# left - keep everything in x
# right - keep everything in y
# full - keep everything in both x and y

# by = NULL ####
flights2 %>% 
  left_join(weather) # uses all variables that appear in both tables

# by = x ####
flights2 %>% 
  left_join(planes, by = "tailnum") # preserves the year differences in both tables

# by = c(x = y) ####

flights2 %>% 
  left_join(airports, c("dest" = "faa")) # dest in flights is the same as faa in airports

# filtering joins ####

# make a table of top 10 destinations - summarized and filtered down data
top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest

# find each flight that went to those destinations
flights %>% 
  filter(dest %in% top_dest$dest) # you could make a filter but that isn't always easiest

# semi_join(x,y) - keeps all rows in x that have a match in y ####
flights %>% 
  semi_join(top_dest) # instead do a semi join that keeps everything in flights that matches the top 10 dests

# anti_join(x,y) - drops all rows of x that have a match in y #### - what is in y that is not in x
flights %>%
  anti_join(planes, by = "tailnum") %>% # how many flights do not have a match in planes
  count(tailnum, sort = TRUE)
# Check that your foreign keys match primary keys in another table. The best way to do this is with an anti_join(). It’s common for keys not to match because of data entry errors. Fixing these is often a lot of work.

# set operations ####
# These expect the rows to contain the same columns without missing values
# intercept(x,y) - returns variables that are in both x and y
# union(x,y) - return what is in x and y but not in both
# setdiff(x,y) - return what is in x but not y

df1 <- tribble(
  ~x, ~y,
  1,  1,
  "a",  "b"
)
df2 <- tribble(
  ~x, ~y,
  1,  1,
  "b",  "a"
)

intersect(df1, df2) # returns the first row because all values match

union(df1, df2) # not sure how this works

setdiff(df1, df2) # row 1 is the same in both but row 2 is not so it is returned

setdiff(df2, df1) # row 2 is the same but row 1 is different so row 2 is returned


