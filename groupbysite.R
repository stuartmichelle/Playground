# a script to play with the idea of grouping data by site

# connect to the local db
local <- dbConnect(SQLite(), "../../local_leyte.sqlite3")
dive <- leyte %>% tbl("diveinfo") %>% select(id, date, name) %>% collect() 



# ## after the field season has ended, from amphiprion mysql ##
# source("../../Philippines/code/conleyte.R")
# leyte <- conleyte()
# dive <- leyte %>% tbl("diveinfo") %>% select(id, date, name) %>% collect()
# anem <- leyte %>% tbl("anemones") %>% select(dive_table_id, anem_table_id, ObsTime, anem_id) %>% collect()
# anem <- left_join(anem, dive, by = c("dive_table_id" = "id")) 
# fish <- leyte %>% tbl("clownfish") %>% select(anem_table_id, Spp, size, col, sample_id) %>% collect
# fish <- left_join(fish, anem, by = "anem_table_id")
# 
# sitetot <- fish %>% group_by(name) %>% summarize(sum = sum(n()))
# 
# year <- "2016"
# yeartot <- fish %>% filter(date > "2016-01-01" & date < "2017-01-01") %>% group_by(name) %>% summarize(sum = sum(n()))
# 
