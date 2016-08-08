# a script to figure out how to query lat longs for fish

# # Original script to attach lat longs to anemones:
# for(i in 1:len){
#   #Get date and time information for the anemone
#   survey = data$DiveNum[i]
#   survindex = which(surv$DiveNum == survey)
#   date = as.character(surv$Date[survindex])
#   datesplit = strsplit(date,"-", fixed=T)[[1]]
#   month = as.numeric(datesplit[2])
#   day = as.numeric(datesplit[3])
#   time = as.character(data$ObsTime[i])
#   timesplit = strsplit(time, ":", fixed=T)[[1]]
#   hour = as.numeric(timesplit[1])
#   min = as.numeric(timesplit[2])
#   sec = as.numeric(timesplit[3])
#   
#   # Convert time to GMT
#   hour = hour - 8
#   if(hour <0){
#     day = day-1
#     hour = hour + 24
#   }
#   
#   # Find the location records that match the date/time stamp (to nearest second)
#   latlongindex = which(latlong$month == month & latlong$day == day & latlong$hour == hour & latlong$min == min)
#   i2 = which.min(abs(latlong$sec[latlongindex] - sec))
#   
#   # Calculate the lat/long for this time
#   if(length(i2)>0){
#     data$lat[i] = latlong$lat[latlongindex][i2]
#     data$lon[i] = latlong$long[latlongindex][i2]
#   }
# # Connect to database using dplyr
# suppressMessages(library(dplyr)) 
# leyte <- src_mysql(dbname = "Leyte", host = "amphiprion.deenr.rutgers.edu", user = "michelles", password = "larvae168", port = 3306)

# Convert anemone time to GMT
# select date_add(ObsTime, INTERVAL 8 hour) from anemones; # this runs but returns NULL for all

# Have to paste the date and time together and then run the above query on the timestamp

# # find date  - dplyr not working: Error in tbl(letye, sql("SELECT diveinfo.Date as date, anemones.ObsTime as time from anemones join diveinfo on anemones.dive_table_id = diveinfo.id;")) : 
# object 'letye' not found
# date <- tbl(letye, sql("SELECT diveinfo.Date as date, anemones.ObsTime as time from anemones join diveinfo on anemones.dive_table_id = diveinfo.id;"))

library(RMySQL)
leyte <- dbConnect(MySQL(), host="amphiprion.deenr.rutgers.edu", user="michelles", password="larvae168", dbname="Leyte", port=3306)
# add date of capture
timestamp <- dbSendQuery(leyte, "select diveinfo.Date as Date, anemones.ObsTime as time, anem_table_id
  from anemones 
  join diveinfo on anemones.dive_table_id = diveinfo.id;;")
timestamp <- fetch(timestamp, n=-1)

timestamp$pasted <- paste(timestamp$Date, timestamp$time, sep = " ")

hrs <- function(u) {
  x <- u * 3600
  return(x)
}

timestamp$GMT <- as.POSIXct(timestamp$pasted) + hrs(8)

# make a table of lat longs
latlong <- dbSendQuery(leyte, "select * from GPX;")
latlong <- fetch(latlong, n = -1)

for (i in 1:nrow(timestamp)){
  GMT <- timestamp$GMT[i]
  latlongindex = which(latlong$time == GMT)
}

