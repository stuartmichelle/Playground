# tidy data from wickham
library(tidyverse)

#### USEFUL ####
# gather ####
table4a

# Here the 1999 column and the 2000 column represent 2 observations, so they should be in different row
tidy4a <- table4a %>% gather(`1999`, `2000`, key = "year", value = "cases") # take columns 1999 and 2000 and place those column names in a new column called year where the value is the value from the origin column

table4b

tidy4b <- table4b %>% gather(`1999`, `2000`, key = "year", value = "population")

left_join(tidy4b, tidy4a, by = c("country", "year"))

### USEFUL ####
# spread ####
table2

# want to split the type column into 2 columns
spread(table2, key = type, value = count) # takes a column (key), and pulls the varialbes from that column into a new column (value)

# Exercises ####

# Why are gather() and spread() not perfectly symmetrical?
# Carefully consider the following example:
  
  stocks <- tibble(
    year   = c(2015, 2015, 2016, 2016),
    half  = c(   1,    2,     1,    2),
    return = c(1.88, 0.59, 0.92, 0.17)
  )
stocks %>% 
  spread(year, return) %>% # make a column for each year with the return as the value
  gather("year", "return", `2015`:`2016`) # puts them back the way they were originally
# (Hint: look at the variable types and think about column names.)

# Both spread() and gather() have a convert argument. What does it do? Converts column type to string

# Why does this code fail?

table4a %>% 
  gather(1999, 2000, key = "year", value = "cases")
#> Error in combine_vars(vars, ind_list): Position must be between 0 and n
# missing the `` around the date columns

# Why does spreading this tibble fail? How could you add a new column to fix the problem?  Because there are 2 ages listed for Phillip Woods.


people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)



# Tidy the simple tibble below. Do you need to spread or gather it? What are the variables? gather, count

preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

tidypreg <- preg %>% gather(male, female, key = "sex", value = "count") 

# separate ####
table3
table3 %>% 
  separate(rate, into = c("cases", "population")) # take the rate collumn and separate it into cases and population wherever a non-alphanumeric character is

### USEFUL ####
# can also specify the character used to split
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

# could use in the trim_gpx code
# read in survey times (start, end, pause start and pause end)
readxl::excel_sheets("~/Downloads/GPSSurveys2017.xlsx")
test <- readxl::read_excel(path = "~/Downloads/GPSSurveys2017.xlsx", sheet = "DiveInfo")
test <- test %>% separate(Date, into = c("year", "startmonth", "startday"))

# make sure the columns are separated into the correct type instead of characters
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/", convert = T)

### USEFUL #### - for pulling out the year as a two digit and turning it into a 2016
# use number of characters instead of a delimiter to separate - Positive values start at 1 on the far-left of the strings; negative value start at -1 on the far-right of the strings. When using integers to separate strings, the length of sep should be one less than the number of names in into
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

# Unite ####
table5

# get rid of the old columns and create a new column that is the two columns joined
table5 %>% 
  unite(new, century, year)

# don't include the default _
table5 %>% 
  unite(new, century, year, sep = "")

# Exercises ####
# 
# What do the extra and fill arguments do in separate()? Experiment with the various options for the following two toy datasets.
# 
# tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
#   separate(x, c("one", "two", "three"))
# 
# tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
#   separate(x, c("one", "two", "three"))
# Both unite() and separate() have a remove argument. What does it do? Why would you set it to FALSE?
# 
# Compare and contrast separate() and extract(). Why are there three variations of separation (by position, by separator, and with groups), but only one unite?

# Missing values ####
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

# add an explicit NA where there was no data before
stocks %>% 
  spread(year, return)

# make the NAs implicit by removing them from the data set using na.rm
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

# complete ####
# make all missing values explicit with complete - fills in the blanks
stocks %>% 
  complete(year, qtr)

# fill ####
# carry the data forward in empty rows
treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

treatment %>% 
  fill(person)

# Exercises ####
# 
# Compare and contrast the fill arguments to spread() and complete().
# 
# What does the direction argument to fill() do?

# Case Study ####
who

# the columns new_sp_m014 through newrel_f65 look like values so we are going to gather those into a column called key with the values from those columns going into a cases column, also remove all nas
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)

# trying to figure out what the key values are, count the different types

who1 %>% 
  count(key)

# there is a type-o we need to fix
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))

# separate out the key code based on the metadata
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")

# it looks like every value in the new column is "new", so it can be dropped, as well as a few others
who3 %>% 
  count(new)

### USEFUL ####
# drop columns using select
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

# separate the sexage column by splitting after the first character
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)

# now the whole thing as a pipe
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

# Exercises ####
# 
# In this case study I set na.rm = TRUE just to make it easier to check that we had the correct values. Is this reasonable? Think about how missing values are represented in this dataset. Are there implicit missing values? What’s the difference between an NA and zero?
# 
# What happens if you neglect the mutate() step? (mutate(key = stringr::str_replace(key, "newrel", "new_rel")))
# 
# I claimed that iso2 and iso3 were redundant with country. Confirm this claim.
# 
# For each country, year, and sex compute the total number of cases of TB. Make an informative visualisation of the data.


