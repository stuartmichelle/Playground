# strings
# install.packages("htmlwidgets")
library(tidyverse)
library(stringr)

# writeLines shows you the raw content of a string
x <- c("\"", "\\")
x
#> [1] "\"" "\\"
writeLines(x)
#> "
#> \

# number of characters in a string ####
str_length(c("a", "R for data science", NA))

# combine 2 or more strings ####
str_c("x", "y")
#> [1] "xy"
str_c("x", "y", "z")
#> [1] "xyz"

str_c("x", "y", sep = ", ")
#> [1] "x, y"

# missing values - to print them as "NA" ####
x <- c("abc", NA)
str_c("|-", x, "-|")
#> [1] "|-abc-|" NA
str_c("|-", str_replace_na(x), "-|")
#> [1] "|-abc-|" "|-NA-|"

str_c("prefix-", c("a", "b", "c"), "-suffix")

# objects of length 0 are siliently dropped ####
name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE

str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
)
#> [1] "Good morning Hadley."

# collapse vectors into a single string (paste?) ####
str_c(c("x", "y", "z"), collapse = ", ")

# subset strings ####
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
#> [1] "App" "Ban" "Pea"
# negative numbers count backwards from end - like right() in excel
str_sub(x, -3, -1)
#> [1] "ple" "ana" "ear"

# it won't fail if the string is too
str_sub("a", 1, 5)
# "a"

# make lowercase ####
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x
#> [1] "apple"  "banana" "pear"

# make uppercase ####
# Turkish has two i's: with and without a dot, and it
# has a different rule for capitalising them:
str_to_upper(c("i", "ı"))
#> [1] "I" "I"
str_to_upper(c("i", "ı"), locale = "tr")
#> [1] "İ" "I"

# make title case ####
str_to_title("this is the title of my graph")
# [1] "This Is The Title Of My Graph"

# sorting based on different location rules ####
x <- c("apple", "eggplant", "banana")

str_sort(x, locale = "en")  # English
#> [1] "apple"    "banana"   "eggplant"

str_sort(x, locale = "haw") # Hawaiian
#> [1] "apple"    "eggplant" "banana"

# regex ####

# match exact string ####
x <- c("apple", "banana", "pear")
str_view(x, "an")

# match any character ####
str_view(x, ".a.") # find a and return the characters on either side of it

# look for periods instead of using them as a wild card ####
# To create the regular expression, we need \\
dot <- "\\." # escaped period

# But the expression itself only contains one:
writeLines(dot)
#> \.

# And this tells R to look for an explicit .
str_view(c("abc", "a.c", "bef"), "a\\.c") # find "a.c"

# same for \ 
x <- "a\\b"
writeLines(x)
#> a\b

str_view(x, "\\\\")

# anchors ####
x <- c("apple", "banana", "pear")
str_view(x, "^a") # find the a at the start of a string

str_view(x, "a$") # find the a at the end of a string

# if you begin with power (^), you end up with money ($).

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")

# to find only a complete string
str_view(x, "^apple$")

# search for \bsum\b to avoid matching summarise, summary, rowsum and so on.

# # Character classes ####
# \d: matches any digit.
# \s: matches any whitespace (e.g. space, tab, newline).
# [abc]: matches a, b, or c.
# [^abc]: matches anything except a, b, or c.

# using or
str_view(c("grey", "gray"), "gr(e|a)y")

# # how many times does a patter match ####
# ?: 0 or 1
# +: 1 or more
# *: 0 or more

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")

str_view(x, "CC+")

str_view(x, 'C[LX]+')

# You can also specify the number of matches precisely:
#   
# {n}: exactly n
# {n,}: n or more
# {,m}: at most m
# {n,m}: between n and m

str_view(x, "C{2}")

str_view(x, "C{2,}")

str_view(x, "C{2,3}")

str_view(x, 'C{2,3}?') # match the shortest possible string by adding a ?

str_view(x, 'C[LX]+?')

# grouping ####
# the following regular expression finds all fruits that have a repeated pair of letters.
str_view(fruit, "(..)\\1", match = TRUE) 


str_view(c("theee"), "(.)\\1\\1", match = TRUE) # matches 3 letters in a row aaa
str_view(fruit, "(.)(.)\\2\\1", match = TRUE) # matches a mirror of 2 letters (1st, 2nd, 2nd, 1st) abba
str_view(fruit, "(..)\\1", match = TRUE) # matches 1st, 2nd, 1st letter pattern aba
str_view(fruit, "(.).\\1.\\1", match = TRUE) # matches 1, any, 1, any 1 - abaca
str_view(c("abcdxxcba", "abccba"), "(.)(.)(.).*\\3\\2\\1", match = TRUE) # matches 1, 2, 3, any or not, 3, 2, 1 - abcdxxcda

# detect matches ####
x <- c("apple", "banana", "pear")
str_detect(x, "e")
#> [1]  TRUE FALSE  TRUE

# detecting numbers makes zeros and 1s
# How many common words start with t?
sum(str_detect(words, "^t"))
#> [1] 65
# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))
#> [1] 0.277

# here are two ways to find all words that don’t contain any vowels:
  
# Find all words containing at least one vowel, and negate
no_vowels_1 <- !str_detect(words, "[aeiou]") #(better)

# Find all words consisting only of consonants (non-vowels)
no_vowels_2 <- str_detect(words, "^[^aeiou]+$") #(worse)

identical(no_vowels_1, no_vowels_2)
#> [1] TRUE

words[str_detect(words, "x$")] # which words end in x (worse)
#> [1] "box" "sex" "six" "tax"
str_subset(words, "x$") # which words end in x (better)
#> [1] "box" "sex" "six" "tax"

# usually strings are only one column of a dataset, use filter
df <- data.frame(
  word = words, 
  i = seq_along(word)
)
df %>% 
  filter(str_detect(words, "x$"))

# how many matches there are in a string: ####
  
  x <- c("apple", "banana", "pear")
str_count(x, "a")
#> [1] 1 3 1

# On average, how many vowels per word?
mean(str_count(words, "[aeiou]"))
#> [1] 1.99

# It’s natural to use str_count() with mutate():
  
  df %>% 
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )

  # matches do not overlap
  # For example, in "abababa", how many times will the pattern "aba" match? Regular expressions say two, not three:
    
    str_count("abababa", "aba")
  #> [1] 2
  str_view_all("abababa", "aba")
  
# extract matches ####
length(sentences)
head(sentences)  

# create a vector of desired values, what are you searching for
colours <- c("red", "orange", "yellow", "green", "blue", "purple") 
# combine the list into one value separated by the "or" character
colour_match <- str_c(colours, collapse = "|")
colour_match

# find sentences that match our search
has_colour <- str_subset(sentences, colour_match)
# which colors matched?
matches <- str_extract(has_colour, colour_match) #44 matched red to barred
head(matches)

# str_extract only selects the first match and some sentences have more than one
# We can see that most easily by first selecting all the sentences that have more than 1 match:
  
more <- sentences[str_count(sentences, colour_match) > 1] # which sentences have more than 1 match
str_view_all(more, colour_match)

str_extract(more, colour_match) # search more for the regex colour_match, only return the first 
str_extract_all(more, colour_match) # return all matches

# return a matrix with short matches expanded to the same length as the longest
str_extract_all(more, colour_match, simplify = TRUE)

x <- c("a", "a b", "a b c")
str_extract_all(x, "[a-z]", simplify = TRUE)

# grouped matches ####
noun <- "(a|the) ([^ ]+)"

has_noun <- sentences %>%
  str_subset(noun) %>%
  head(10)

# str_extract returns the full match
has_noun %>% 
  str_extract(noun)

# str_match returns each component of the match
has_noun %>% 
  str_match(noun)


tibble(sentence = sentences) %>% 
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)", 
    remove = FALSE
  )

