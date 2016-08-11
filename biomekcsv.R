# A script to create a csv for the Biomek from a list of ligation numbers

# connect to database
suppressMessages(library(dplyr))
labor <- src_mysql(dbname = "Laboratory", host = "amphiprion.deenr.rutgers.edu", user = "michelles", password = "larvae168", port = 3306, create = F)

# connect to Leyte database to get known-issues numbers
leyte <- src_mysql(dbname = "Leyte", host = "amphiprion.deenr.rutgers.edu", user = "michelles", password = "larvae168", port = 3306, create = F)

issues <- data.frame(leyte %>% tbl("known_issues"))

# TODO - curate this list, not all of these need to be regenotyped!!!!!!!

# get extract numbers for all of these 
c1 <- labor %>% tbl("extraction") %>% select(extraction_ID, sample_ID)
c2 <- labor %>% tbl("digest") %>% select(digest_ID, extraction_ID)
c3 <- left_join(c2, c1, by = "extraction_ID")
c4 <- labor %>% tbl("ligation") %>% select(ligation_ID, digest_ID)
c5 <- data.frame(left_join(c4, c3, by = "digest_ID"))
c6 <- data.frame(leyte %>% tbl("known_issues") %>% select(Ligation_ID, Issue))
c7 <- data.frame(left_join(c6, c5, by = c("Ligation_ID" = "ligation_ID"), copy = T))
