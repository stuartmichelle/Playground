

# 1. Read the Brazilian mahogany tree data into R
# 2. Rename the data columns to your liking and subset to just the MR trees
# 3. Use the reshape2 package to transform the (a) growth data and (b) fruit data from wide-to-long
# 4. Use the dplyr package to calculate the min, mean, median, max, and number of observations
#    for each tree with growth and fruit data.
# 5. Use the merge function to join the two datasets by the tree id (a unique identifier)
# 6. Plot mean mean growth rate versus mean fruit production. Is there a tradeoff between investing in 
#    growth versus reproductions (negatively correlated)? Or are they positively correlated (both good
#    in favorable years and both bad in unfavorable years)?