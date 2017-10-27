# matrix tutorial from data camp - https://campus.datacamp.com/courses/free-introduction-to-r/chapter-3-matrices-3?ex=1

# matrix(data, filled in by row instead of column, number of rows (or columns))
matrix(1:9, byrow = TRUE, nrow = 3)

# Below, three vectors are defined. Each one represents the box office
# numbers from the first three Star Wars movies. The first element of each
# vector indicates the US box office revenue, the second element refers to the
# Non-US box office (source: Wikipedia).

# In this exercise, you'll combine all these figures into a single vector. Next,
# you'll build a matrix from this vector.

# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Create box_office
box_office <- c(new_hope, empire_strikes, return_jedi)
  
# Construct star_wars_matrix
star_wars_matrix <- matrix(box_office, byrow = T, nrow = 3)


# Similar to vectors, you can add names for the rows and the columns of a matrix

# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Construct matrix
star_wars_matrix <- matrix(c(new_hope, empire_strikes, return_jedi), nrow = 3, byrow = TRUE)

# Vectors region and titles, used for naming
region <- c("US", "non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")

# Name the columns with region # there is another way to name them below...
colnames(star_wars_matrix) <- region

# Name the rows with titles
rownames(star_wars_matrix) <- titles

# Print out star_wars_matrix
star_wars_matrix

# Calculate the worldwide box office figures for the three movies and put these
# in the vector named worldwide_vector.
# Construct star_wars_matrix
box_office <- c(460.998, 314.4, 290.475, 247.900, 309.306, 165.8)
star_wars_matrix <- matrix(box_office, nrow = 3, byrow = TRUE,
                           dimnames = list(c("A New Hope", "The Empire Strikes Back", "Return of the Jedi"), 
                                           c("US", "non-US")))

# Calculate worldwide box office figures
worldwide_vector <- rowSums(star_wars_matrix)

# Add worldwide_vector as a new column to the star_wars_matrix and assign the
# result to all_wars_matrix. Use the cbind() function.
all_wars_matrix <- cbind(star_wars_matrix, worldwide_vector)

# Use rbind() to paste together star_wars_matrix and star_wars_matrix2, in this
# order. Assign the resulting matrix to all_wars_matrix.

box_office2 <- c(474.5, 552.5, 310.7, 338.7, 380.3, 468.5)

star_wars_matrix2 <- matrix(box_office2, nrow= 3, byrow = TRUE, 
                            dimnames = list(c("The Phantom Menace", "Attack of the Clones", "Revent of the Sith"), c("US", "non-US")))

all_wars_matrix <- rbind(star_wars_matrix, star_wars_matrix2)

# all_wars_matrix is available in your workspace
all_wars_matrix

# Calculate the total revenue for the US and the non-US region and assign
# total_revenue_vector. You can use the colSums() function. Print out
# total_revenue_vector to have a look at the results.

# Total revenue for US and non-US
total_revenue_vector <- colSums(all_wars_matrix)

# Print out total_revenue_vector
total_revenue_vector

# Select the non-US revenue for all movies (the entire second column of
# all_wars_matrix), store the result as non_us_all. Use mean() on non_us_all to
# calculate the average non-US revenue for all movies. Simply print out the
# result. This time, select the non-US revenue for the first two movies in
# all_wars_matrix. Store the result as non_us_some. Use mean() again to print
# out the average of the values in non_us_some.

# Select the non-US revenue for all movies
non_us_all <- all_wars_matrix[ , 2]

# Average non-US revenue
mean(non_us_all)

# Select the non-US revenue for first two movies
non_us_some <- all_wars_matrix[1:2, 2]

# Average non-US revenue for first two movies
mean(non_us_some)

# Divide all_wars_matrix by 5, giving you the number of visitors in millions.
# Assign the resulting matrix to visitors. Print out visitors so you can have a
# look.

# Estimate the visitors
visitors <- all_wars_matrix/5

# Print the estimate to the console
visitors

# Divide all_wars_matrix by ticket_prices_matrix to get the estimated number of
# US and non-US visitors for the six movies. Assign the result to visitors. From
# the visitors matrix, select the entire first column, representing the number
# of visitors in the US. Store this selection as us_visitors. Calculate the
# average number of US visitors; print out the result.

ticket_prices <- c(5.0, 5.0, 6.0, 6.0, 7.0, 7.0, 4.0, 4.0, 4.5, 4.5, 4.9, 4.9)
titles2 <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi","The Phantom Menace", "Attack of the Clones", "Revent of the Sith")

ticket_prices_matrix <- matrix(ticket_prices, nrow = 6, byrow = T, 
                               dimnames = list(titles2, region))

# Estimated number of visitors
visitors <- all_wars_matrix/ticket_prices_matrix

# US visitors
us_visitors <- all_wars_matrix[ , 1]/ticket_prices_matrix[ , 1]

# Average number of US visitors
mean(us_visitors)

