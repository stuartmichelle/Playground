# dplyr tutorial 

# load dplyr without the red tape
suppressMessages(library(dplyr)) 

# load the data (houston flights)
library(hflights)

# explore data
data(hflights)
head(hflights)

# convert to local data frame by using tbl_df 
# still needs to be converted to a dataframe with data.frame(flights)
flights <- tbl_df(hflights)

# printing only shows 10 rows and as many columns as can fit on your screen
flights

# you can specify that you want to see more rows (example doesn't show more)
print(flights, n=20)

# convert to a normal data frame to see all of the columns
data.frame(head(flights))

# filter: Keep rows matching criteria

# - Base R approach to filtering forces you to repeat the data frame's name
# - dplyr approach is simpler to write and read
# - Command structure (for all dplyr verbs):
# - first argument is a data frame
# - return value is a data frame
# - nothing is modified in place
# - Note: dplyr generally does not preserve row names

# base R approach to view all flights on January 1
flights[flights$Month==1 & flights$DayofMonth==1, ]

# dplyr approach
# note: you can use comma or ampersand to represent AND condition
# "Show flights that start on the first day of the first month"
filter(flights, Month==1, DayofMonth==1)

# use pipe for OR condition
# Show flights from AA or UA
filter(flights, UniqueCarrier=="AA" | UniqueCarrier=="UA")

# you can also use %in% operator
# show flights in this list
filter(flights, UniqueCarrier %in% c("AA", "UA"))

# select: Pick columns by name
# 
# - Base R approach is awkward to type and to read
# - dplyr approach uses similar syntax to filter
# - Like a SELECT in SQL

# base R approach to select DepTime, ArrTime, and FlightNum columns
flights[, c("DepTime", "ArrTime", "FlightNum")]

# dplyr approach
select(flights, DepTime, ArrTime, FlightNum)

# use colon to select multiple contiguous columns, and use `contains` to match columns by name
# note: `starts_with`, `ends_with`, and `matches` (for regular expressions) can also be used to match columns by name
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))

# "Chaining" or "Pipelining"
# - Usual way to perform multiple operations in one line is by nesting
# - Can write commands in a natural order by using the %>% infix operator (which can be pronounced as "then")

# nesting method to select UniqueCarrier and DepDelay columns and filter for delays over 60 minutes
filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 60)

# chaining method
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  filter(DepDelay > 60)

# - Chaining increases readability significantly when there are many commands
# - Operator is automatically imported from the magrittr package
# - Can be used to replace nesting in R commands outside of dplyr

# create two vectors and calculate Euclidian distance between them
x1 <- 1:5; x2 <- 2:6
sqrt(sum((x1-x2)^2))

# chaining method
(x1-x2)^2 %>% sum() %>% sqrt()

# arrange: Reorder rows

# base R approach to select UniqueCarrier and DepDelay columns and sort by DepDelay
flights[order(flights$DepDelay), c("UniqueCarrier", "DepDelay")]

# dplyr approach
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)

# use `desc` for descending
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))

# mutate: Add new variables
# 
# - Create new variables that are functions of existing variables

# base R approach to create a new variable Speed (in mph)
flights$Speed <- flights$Distance / flights$AirTime*60
flights[, c("Distance", "AirTime", "Speed")]

# dplyr approach (prints the new variable but does not store it)
flights %>%
  select(Distance, AirTime) %>%
  mutate(Speed = Distance/AirTime*60)

# store the new variable
flights <- flights %>% mutate(Speed = Distance/AirTime*60)

# summarise: Reduce variables to values
# 
# - Primarily useful with data that has been grouped by one or more variables
# - group_by creates the groups that will be operated on
# - summarise uses the provided aggregation function to summarise each group

# base R approaches to calculate the average arrival delay to each destination
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm=TRUE)))
head(aggregate(ArrDelay ~ Dest, flights, mean))

# dplyr approach: create a table grouped by Dest, and then summarise each group by taking the mean of ArrDelay
flights %>%
  group_by(Dest) %>%
  summarise(avg_delay = mean(ArrDelay, na.rm=TRUE))

# - summarise_each allows you to apply the same summary function to multiple columns at once
# - Note: mutate_each is also available

# for each carrier, calculate the percentage of flights cancelled or diverted
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(mean), Cancelled, Diverted)

# for each carrier, calculate the minimum and maximum arrival and departure delays
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(., na.rm=TRUE), max(., na.rm=TRUE)), matches("Delay"))

# - Helper function n() counts the number of rows in a group
# - Helper function n_distinct(vector) counts the number of unique items in that vector

# for each day of the year, count the total number of flights and sort in descending order
flights %>%
  group_by(Month, DayofMonth) %>%
  summarise(flight_count = n()) %>%
  arrange(desc(flight_count))

# rewrite more simply with the `tally` function
flights %>%
  group_by(Month, DayofMonth) %>%
  tally(sort = TRUE)


# for each destination, count the total number of flights and the number of distinct planes that flew there
flights %>%
  group_by(Dest) %>%
  summarise(flight_count = n(), plane_count = n_distinct(TailNum))

# Grouping can sometimes be useful without summarising

# for each destination, show the number of cancelled and not cancelled flights
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table() %>%
  head()

# Window Functions
# 
# - Aggregation function (like mean) takes n inputs and returns 1 value
# - Window function takes n inputs and returns n values
# - Includes ranking and ordering functions (like min_rank), offset functions (lead and lag), and cumulative aggregates (like cummean).

# for each carrier, calculate which two days of the year they had their longest departure delays
# note: smallest (not largest) value is ranked as 1, so you have to use `desc` to rank by largest value
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 2) %>%
  arrange(UniqueCarrier, desc(DepDelay))

# rewrite more simply with the `top_n` function
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  top_n(2) %>%
  arrange(UniqueCarrier, desc(DepDelay))

# for each month, calculate the number of flights and the change from the previous month
flights %>%
  group_by(Month) %>%
  summarise(flight_count = n()) %>%
  mutate(change = flight_count - lag(flight_count))

# rewrite more simply with the `tally` function
flights %>%
  group_by(Month) %>%
  tally() %>%
  mutate(change = n - lag(n))

# Other Useful Convenience Functions

# randomly sample a fixed number of rows, without replacement
flights %>% sample_n(5)

# randomly sample a fraction of rows, with replacement 
# (what does replacement mean?)
flights %>% sample_frac(0.25, replace=TRUE)

# base R approach to view the structure of an object
str(flights)

# dplyr approach: better formatting, and adapts to your screen width
glimpse(flights)

# Connecting to Databases
# 
# - dplyr can connect to a database as if the data was loaded into a data frame
# - Use the same syntax for local data frames and databases
# - Only generates SELECT statements
# - Currently supports SQLite, PostgreSQL/Redshift, MySQL/MariaDB, BigQuery, MonetDB
# - Example below is based upon an SQLite database containing the hflights data
# - Instructions for creating this database are in the databases vignette

# connect to an SQLite database containing the hflights data
my_db <- src_sqlite("my_db.sqlite3")

# connect to the "hflights" table in that database
flights_tbl <- tbl(my_db, "hflights")

# example query with our data frame
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))

# identical query using the database
flights_tbl %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))

# - You can write the SQL commands yourself
# - dplyr can tell you the SQL it plans to run and the query execution plan

# send SQL commands to the database
tbl(my_db, sql("SELECT * FROM hflights LIMIT 100"))

# ask dplyr for the SQL commands
flights_tbl %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay)) %>%
  explain()

# Resources
# 
# - Official dplyr reference manual and vignettes on CRAN: vignettes are well-written and cover many aspects of dplyr
# - July 2014 webinar about dplyr (and ggvis) by Hadley Wickham and related slides/code: mostly conceptual, with a bit of code
# - dplyr tutorial by Hadley Wickham at the useR! 2014 conference: excellent, in-depth tutorial with lots of example code (Dropbox link includes slides, code files, and data files)
# - dplyr GitHub repo and list of releases

# from http://www.unomaha.edu/mahbubulmajumder/data-science/fall-2014/lectures/20-database-mysql/20-database-mysql.html#/11
library(dplyr)
conDplyr = src_mysql(dbname = "trainingDB", user = "training", 
  password = "training123", host = "localhost")

myData <- conDplyr %>%
  tbl("titanic") %>%
  select(pclass, sex, age, fare, survived, parch) %>%
  filter(survived==0) %>%
  collect() 

head(myData)
# 
# < END OF DOCUMENT >

