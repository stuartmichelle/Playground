------------------------------------------------------------------------------
# Connect to database using dplyr
suppressMessages(library(dplyr))
leyte <- src_mysql(dbname = "Leyte", host = "amphiprion.deenr.rutgers.edu", user = "michelles", password = "larvae168", port = 3306, create = F)

# Bring in anemone info
anem <- leyte %>% tbl("anemones") %>% select(anem_table_id, dive_table_id, ObsTime)

# Bring in dive info
dive <- leyte %>% tbl("diveinfo") %>% select(id, Date)

# Join the date and time info
final <- data.frame(left_join(anem, dive, by = c("dive_table_id" = "id")))

# Bring in the lat long info
latlong <- data.frame(leyte %>% tbl("GPX"))

# calculate lat long
for(i in 1:nrow(final)){
    date <- as.character(final$Date[i])
    datesplit <- strsplit(date,"-", fixed=T)[[1]]
    year <- as.numeric (datesplit[1])
    month <- as.numeric(datesplit[2])
    day <- as.numeric(datesplit[3])
    time <- as.character(final$ObsTime[i])
    timesplit <- strsplit(time, ":", fixed=T)[[1]]
    hour <- as.numeric(timesplit[1])
    min <- as.numeric(timesplit[2])
    sec <- as.numeric(timesplit[3])

    # Convert time to GMT
    hour <- hour - 8
    if(hour <0){
      day <- day-1
      hour <- hour + 24
    }

    # Find the location records that match the date/time stamp (to nearest second)
    latlongindex <- which(latlong$month == month & latlong$day == day & latlong$hour == hour & latlong$min == min)
    i2 <- which.min(abs(latlong$sec[latlongindex] - sec))

    # Calculate the lat/long for this time
    if(length(i2)>0){
      final$lat[i] <- format(round(latlong$lat[latlongindex][i2], 11))
      final$lon[i] <- format(round(latlong$long[latlongindex][i2], 11))
    }
}
