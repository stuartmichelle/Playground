# 16 dates and times wickham 

library(tidyverse)
library(lubridate)
library(nycflights13)
library(stringr) # for my test

# current time ####
today()
now()

# use lubridate to convert a string into a date ####
ymd("2017-01-31")
#> [1] "2017-01-31"
mdy("January 31st, 2017")
#> [1] "2017-01-31"
dmy("31-Jan-2017")
#> [1] "2017-01-31"
ymd(20170131)

# TEST
dates <- tibble(
  year   = c("2015", "2015", "2016", "2016"),
  month  = c(   "1",    "2",     "1",    "2"),
  day = c("12", "14", "13", "22"),
  time = c("15:04", "12:03", "22:30", "14:02")
)

dates$string <- str_c(dates$year, dates$month, dates$day, sep = "-")
dates$dttm <- str_c(dates$string, dates$time, sep = " ")

ymd(dates$string)
# ymd_hms(dates$dttm) # this generated the error All formats failed to parse. No formats found. because there were no seconds for the input
ymd_hm(dates$dttm)

ymd_hms("2017-01-31 20:11:59")
#> [1] "2017-01-31 20:11:59 UTC"
mdy_hm("01/31/2017 08:01")
#> [1] "2017-01-31 08:01:00 UTC"

ymd(20170131, tz = "UTC")
#> [1] "2017-01-31 UTC"

# convert components into date ####
# make_datetime needs all components, can't use date, time, it needs each separate.
flights %>% 
  select(year, month, day, hour, minute)

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))

# time is displayed strangely in the flights dataset to so make a function to fix the time into hour and minute columns
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}  
  flights_dt <- flights %>% 
    filter(!is.na(dep_time), !is.na(arr_time)) %>% 
    mutate(
      dep_time = make_datetime_100(year, month, day, dep_time),
      arr_time = make_datetime_100(year, month, day, arr_time),
      sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
      sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
    ) %>% 
    select(origin, dest, ends_with("delay"), ends_with("time"))

  flights_dt
  
  
  # distribution of departure times
  # over a year
  
  flights_dt %>% 
    ggplot(aes(dep_time)) + 
    geom_freqpoly(binwidth = 86400) # 86400 seconds = 1 day (1 = 1 second b/c use dttm)
  
  # over a day
  flights_dt %>% 
    filter(dep_time < ymd(20130102)) %>% 
    ggplot(aes(dep_time)) + 
    geom_freqpoly(binwidth = 600) # 600 s = 10 minutes (1 = 1 day b/c use date)
  
  # as_date switches between datetime and date formats ####
  as_datetime(today())
  #> [1] "2017-01-13 UTC"
  as_date(now())
  #> [1] "2017-01-13"
  
  # if the date is a numeric value like 456382, use as_date or as_datetime
  as_datetime(60 * 60 * 10)
  #> [1] "1970-01-01 10:00:00 UTC"
  as_date(365 * 10 + 2)
  #> [1] "1980-01-01"
  
# TEST
    as_datetime(45163)
    
# pulling out pieces ####
    datetime <- ymd_hms("2016-07-08 12:34:56")
    
    year(datetime)
    #> [1] 2016
    month(datetime)
    #> [1] 7
    mday(datetime) # day of the month
    #> [1] 8
    
    yday(datetime) # day of the year
    #> [1] 190
    wday(datetime) # day of the week
    #> [1] 6
    
    month(datetime, label = TRUE) # get abbreviated month or day name
    #> [1] Jul
    #> 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec
    wday(datetime, label = TRUE, abbr = FALSE) # get full month or day name
    
    
# which day of the week do fewest flights depart?    
    flights_dt %>% 
      mutate(wday = wday(dep_time, label = TRUE)) %>% 
      ggplot(aes(x = wday)) +
      geom_bar()  
    
# flights departing at each minute of the hour
    flights_dt %>% 
      mutate(minute = minute(dep_time)) %>% 
      group_by(minute) %>% 
      summarise(
        avg_delay = mean(arr_delay, na.rm = TRUE),
        n = n()) %>% 
      ggplot(aes(minute, avg_delay)) +
      geom_line()
        
# flights scheduled to depart
    sched_dep <- flights_dt %>% 
      mutate(minute = minute(sched_dep_time)) %>% 
      group_by(minute) %>% 
      summarise(
        avg_delay = mean(arr_delay, na.rm = TRUE),
        n = n())
    
    ggplot(sched_dep, aes(minute, avg_delay)) +
      geom_line()    
    
    # people like to plan for "nice" time departures, so minutes tend to be 05, 10, 20, etc.
    ggplot(sched_dep, aes(minute, n)) +
      geom_line()
  
    # round down with floor_date ####
    
    # Each function takes a vector of dates to adjust and then the name of the unit round down (floor), round up (ceiling), or round to
    flights_dt %>% 
      count(week = floor_date(dep_time, "week")) %>% 
      ggplot(aes(week, n)) +
      geom_line()
    
    # set the date time ####
    (datetime <- ymd_hms("2016-07-08 12:34:56"))
    #> [1] "2016-07-08 12:34:56 UTC"
    
    year(datetime) <- 2020
    datetime
    #> [1] "2020-07-08 12:34:56 UTC"
    month(datetime) <- 01
    datetime
    #> [1] "2020-01-08 12:34:56 UTC"
    hour(datetime) <- hour(datetime) + 1
    
    # set many at once with update ####
    update(datetime, year = 2020, month = 2, mday = 2, hour = 2)
    
    # values will roll over to next day if needed
    ymd("2015-02-01") %>% 
      update(mday = 30)
    #> [1] "2015-03-02"
    ymd("2015-02-01") %>% 
      update(hour = 400)
    #> [1] "2015-02-17 16:00:00 UTC"
    
    # the distribution of flights across the course of the day for every day of the year:
    flights_dt %>% 
      mutate(dep_hour = update(dep_time, yday = 1)) %>%  #keep the times but make all of the days the same day
      ggplot(aes(dep_hour)) +
      geom_freqpoly(binwidth = 300)
    
# duration ####
    # In R, when you subtract two dates, you get a difftime object:
      
      # How old is Hadley?
      h_age <- today() - ymd(19791014)
    h_age # not great
    
    # better way
    as.duration(h_age) # duration always uses seconds
    
    dseconds(15)
    #> [1] "15s"
    dminutes(10)
    #> [1] "600s (~10 minutes)"
    dhours(c(12, 24))
    #> [1] "43200s (~12 hours)" "86400s (~1 days)"
    ddays(0:5)
    #> [1] "0s"                "86400s (~1 days)"  "172800s (~2 days)"
    #> [4] "259200s (~3 days)" "345600s (~4 days)" "432000s (~5 days)"
    dweeks(3)
    #> [1] "1814400s (~3 weeks)"
    dyears(1)
    
    # Larger units are created by converting minutes, hours, days, weeks, and years to seconds at the standard rate (60 seconds in a minute, 60 minutes in an hour, 24 hours in day, 7 days in a week, 365 days in a year)    
    
    2 * dyears(1)
    #> [1] "63072000s (~2 years)"
    dyears(1) + dweeks(12) + dhours(15)
    #> [1] "38847600s (~1.23 years)"
    
    tomorrow <- today() + ddays(1)
    last_year <- today() - dyears(1)
    
    one_pm <- ymd_hms("2016-03-12 13:00:00", tz = "America/New_York")
    
    one_pm
    #> [1] "2016-03-12 13:00:00 EST"
    one_pm + ddays(1)
    #> [1] "2016-03-13 14:00:00 EDT"
    
    # periods ####
    one_pm
    #> [1] "2016-03-12 13:00:00 EST"
    one_pm + days(1)
    #> [1] "2016-03-13 13:00:00 EDT"
    
    seconds(15)
    #> [1] "15S"
    minutes(10)
    #> [1] "10M 0S"
    hours(c(12, 24))
    #> [1] "12H 0M 0S" "24H 0M 0S"
    days(7)
    #> [1] "7d 0H 0M 0S"
    months(1:6)
    #> [1] "1m 0d 0H 0M 0S" "2m 0d 0H 0M 0S" "3m 0d 0H 0M 0S" "4m 0d 0H 0M 0S"
    #> [5] "5m 0d 0H 0M 0S" "6m 0d 0H 0M 0S"
    weeks(3)
    #> [1] "21d 0H 0M 0S"
    years(1)
    #> [1] "1y 0m 0d 0H 0M 0S"
    
    10 * (months(6) + days(1))
    #> [1] "60m 10d 0H 0M 0S"
    days(50) + hours(25) + minutes(2)
    #> [1] "50d 25H 2M 0S"
    
    # A leap year
    ymd("2016-01-01") + dyears(1)
    #> [1] "2016-12-31"
    ymd("2016-01-01") + years(1)
    #> [1] "2017-01-01"
    
    # Daylight Savings Time
    one_pm + ddays(1)
    #> [1] "2016-03-13 14:00:00 EDT"
    one_pm + days(1)
    #> [1] "2016-03-13 13:00:00 EDT"
    
    # Some planes appear to have arrived at their destination before they departed from New York City.
    flights_dt %>% 
      filter(arr_time < dep_time) 
    
    flights_dt <- flights_dt %>% 
      mutate(
        overnight = arr_time < dep_time, # find flights where it appears that they arrived before they departed
        arr_time = arr_time + days(overnight * 1), # add one day to the arrival time
        sched_arr_time = sched_arr_time + days(overnight * 1) # add one day to sched arrival time
      )
    
    