# take the list of known issues and make a plan

suppressMessages(library(dplyr))
leyte <- src_mysql(dbname = "Leyte", host = "amphiprion.deenr.rutgers.edu", user = "michelles", password = "larvae168", port = 3306, create = F)

labor <- src_mysql(dbname = "Laboratory", host = "amphiprion.deenr.rutgers.edu", user = "michelles", password = "larvae168", port = 3306, create = F)

issue <- data.frame(leyte %>% tbl("known_issues"))

# attach metadata
c1 <- labor %>% tbl("extraction") %>% select(extraction_ID, sample_ID)
c2 <- labor %>% tbl("digest") %>% select(digest_ID, extraction_ID)
c3 <- left_join(c2, c1, by = "extraction_ID")
c4 <- labor %>% tbl("ligation") %>% select(ligation_ID, digest_ID)
c5 <- data.frame(left_join(c4, c3, by = "digest_ID"))

issue <- left_join(issue, c5, by = c("Ligation_ID" = "ligation_ID"))
