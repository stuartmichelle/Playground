# write to a table using dplyr

library(RSQLite)
library(dplyr)
library(nycflights13)
my_db <- src_sqlite("./my_db.sqlite3", create = T) # create a test database, this is empty

# add the flights table to the database # add a new table to database
flights_sqlite <- copy_to(my_db, flights, temporary = FALSE, indexes = list(
  c("year", "month", "day"), "carrier", "tailnum"))

# BUILD A QUERY
QUERY = filter(flights_sqlite, year == 2013, month == 1, day == 1) %>% # find all of the flights that are on 1/1/2013
  select( year, month, day, carrier, dep_delay, air_time, distance) %>% # select columns
  mutate( speed = distance / air_time * 60) %>% # calculate speed
  arrange( year, month, day, carrier) # change order of columns

# ADD THE "TO TABLE" CLAUSE AND EXECUTE THE QUERY 
# add the speed column to the db
do(paste(unclass(QUERY$query$sql), "TO TABLE",  "flights")) # this doesn't work

dbWriteTable(con, value = dfgg, name = "mytable", append = T)
