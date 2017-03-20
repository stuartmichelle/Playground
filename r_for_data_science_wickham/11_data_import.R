# data import wickham
library(tidyverse)
library(readr)
write_csv(modelr::heights, "data/heights.csv")

# read from a file (this output is different than the book)
(heights <- read_csv("data/heights.csv"))

# use inline data
read_csv("a,b,c
1,2,3
  4,5,6")

# Sometimes there are a few lines of metadata at the top of the file. You can use skip = n to skip the first n lines; or use comment = "#" to drop all lines that start with (e.g.) #.
read_csv("The first line of metadata
  The second line of metadata
  x,y,z
  1,2,3", skip = 2) # skip the first 2 lines

# skip comments
read_csv("# A comment I want to skip
  x,y,z
  1,2,3", comment = "#")

# there aren't column names
# use \n for adding a new line
read_csv("1,2,3\n4,5,6", col_names = FALSE)

# specify column names
read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))

# the NAs are a special character
read_csv("a,b,c\n1,2,.", na = ".")

# Exercises ####

# What function would you use to read a file where fields were separated with “|”? read_delim

# Apart from file, skip, and comment, what other arguments do read_csv() and read_tsv() have in common?

# What are the most important arguments to read_fwf()? widths

# Sometimes strings in a CSV file contain commas. To prevent them from causing problems they need to be surrounded by a quoting character, like " or '. By convention, read_csv() assumes that the quoting character will be ", and if you want to change it you’ll need to use read_delim() instead. What arguments do you need to specify to read the following text into a data frame? read_delim(delim = ,)

# "x,y\n1,'a,b'"


# Identify what is wrong with each of the following inline CSV files. What happens when you run the code?
read_csv("a,b\n1,2,3\n4,5,6") # the first row doesn't have a 3rd value
read_csv("a,b,c\n1,2\n1,2,3,4") # each row has a different number of values
read_csv("a,b\n\"1") # there is an extra quote
read_csv("a,b\n1,2\na,b") # is reading the first line as header
read_csv("a;b\n1;3") # is not comma separated, is semi-colon separated, should've used read_csv2

# parsing a vector ####
# convert string TRUE/FALSE/NA to logic
str(parse_logical(c("TRUE", "FALSE", "NA")))
#>  logi [1:3] TRUE FALSE NA

# convert whole number characters into numbers
str(parse_integer(c("1", "2", "3")))
#>  int [1:3] 1 2 3

# convert string dates into dates
str(parse_date(c("2010-01-01", "1979-10-14")))
#>  Date[1:2], format: "2010-01-01" "1979-10-14"

# tell how to handle missing data
parse_integer(c("1", "231", ".", "456"), na = ".")

# sends warning messages upon error
x <- parse_integer(c("123", "345", "abc", "123.45"))

# if there are many parsing failures 
problems(x)

# there is also parse_number(), parse_character, parse_factor (a category with a fixed number of options), parse_datetime, parse_date, parse_time.

# parse_factor() could receive a list of the possible species, colors from field data and generate warnings when they don't match

parse_date("01/02/15", "%m/%d/%y")
#> [1] "2015-01-02"
parse_date("01/02/15", "%d/%m/%y")
#> [1] "2015-02-01"
parse_date("01/02/15", "%y/%m/%d")
#> [1] "2001-02-15"

# Exercises
# 
# What are the most important arguments to locale()?
# 
# What happens if you try and set decimal_mark and grouping_mark to the same character? What happens to the default value of grouping_mark when you set decimal_mark to “,”? What happens to the default value of decimal_mark when you set the grouping_mark to “.”?
# 
# I didn’t discuss the date_format and time_format options to locale(). What do they do? Construct an example that shows when they might be useful.
# 
# If you live outside the US, create a new locale object that encapsulates the settings for the types of file you read most commonly.
# 
# What’s the difference between read_csv() and read_csv2()?
# 
# What are the most common encodings used in Europe? What are the most common encodings used in Asia? Do some googling to find out.
# 
# Generate the correct format string to parse each of the following dates and times:
#   
#   d1 <- "January 1, 2010"
# d2 <- "2015-Mar-07"
# d3 <- "06-Jun-2017"
# d4 <- c("August 19 (2015)", "July 1 (2015)")
# d5 <- "12/30/14" # Dec 30, 2014
# t1 <- "1705"
# t2 <- "11:15:10.12 PM"

# Parsing a file ####
# the problem file
library(readr)
challenge <- read_csv(readr_example("challenge.csv"))

To fix the call, start by copying and pasting the column specification into your original call:
  
  challenge <- read_csv(
    readr_example("challenge.csv"), 
    col_types = cols(
      x = col_integer(),
      y = col_character()
    )
  )

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_character()
  )
)
tail(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
tail(challenge)

challenge2 <- read_csv(readr_example("challenge.csv"), guess_max = 1001)

# set a default column type, read them all as characters just to get them in
challenge2 <- read_csv(readr_example("challenge.csv"), 
  col_types = cols(.default = col_character())
)

# This is particularly useful in conjunction with type_convert(), which applies the parsing heuristics to the character columns in a data frame.

df <- tribble(
  ~x,  ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)
df

type_convert(df)

# set n_max() to stop reading after a set number of lines until you deal with parsing problems
# read_lines or read_file() will read in each line as one string of characters or the entire file as one vector

# Writing ####

# use write_csv, unless you want to use it in excel, then write_excel_csv(), can append

# to save column type information, use write_rds and read_rds - store R's custom binary format

# feather is a fast binary file that can be read across languages
# install.packages("feather")
library(feather)
write_feather(challenge, "challenge.feather")
read_feather("challenge.feather")

# readxl::read_excel()
# DBI - read SQL

