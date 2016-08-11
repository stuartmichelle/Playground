# a script for platemaps

# make a list of columns and rows
plate <- data.frame( Row = rep(LETTERS[1:8], 12), Col = unlist(lapply(1:12, rep, 8)))

# import lab ids for the plate
suppressMessages(library(dplyr))
labor <- src_mysql(dbname = "Laboratory", host = "amphiprion.deenr.rutgers.edu", user = "michelles", password = "larvae168", port = 3306, create = F)

# pull out sample IDs by date of procedure
extract <- data.frame(labor %>% tbl("extraction") %>% filter(date == '2014-05-30'), stringsAsFactors = F)

plate1 <- cbind(plate, extract[1:96,1])
names(plate1) <- c("Row", "Col", "ID")
first <- min(plate1$ID)
last <- max(plate1$ID)
plate1$ID <- as.character(plate1$ID)
platemap <- as.matrix(reshape2::acast(plate1,plate1[,1] ~ plate1[,2]))
write.csv(platemap, file = paste(first, "-",last, ".csv"))


plate2 <- cbind(plate, extract[97:192, 1])
plate3 <- cbind(plate, extract[193:288, 1])
plate4 <- cbind(plate, extract[289:384, 1])

## Jess's script
#acast(y,y[,1] ~ y[,2])
platemap <- as.matrix(reshape2::acast(plate1,plate1[,1] ~ plate1[,2]))
write.csv(platemap, file = "plate1.csv")
