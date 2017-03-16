# a tutorial to help with SQLite

library(RSQLite)

# create an empty database
conn <- dbConnect(SQLite(), 'mycars.db')

# load data
mtcars <- mtcars

# create a table to write data where conn = connection, "cars" = table name, mtcars = data frame
dbWriteTable(conn, "cars", mtcars)

# if you want to use SQL language instead, use
dbGetQuery(conn, 'CREATE TABLE test_table(id int, name text)')

# list fields for a given table
dbListFields(conn, "cars")

dbGetQuery(conn, "SELECT * FROM cars WHERE mpg > 20")
dbGetQuery(conn, "SELECT * FROM cars WHERE row_names LIKE 'Merc%'")

# change the data frame and then overwrite the table previously created
# this populates each row’s make value by taking the row name, finding the substring that starts with the first space and ends at the end of the string, and removing that substring.
mtcars$make <- gsub(' .*$', '', rownames(mtcars))
dbWriteTable(conn, "cars", mtcars, overwrite = T)

dbGetQuery(conn, "SELECT make, count(*) FROM cars GROUP BY make HAVING count(*) > 1 ORDER BY 2 DESC, 1")

