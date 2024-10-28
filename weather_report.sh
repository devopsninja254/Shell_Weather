!# /bin/bash 

# add a header to the weather report, using tabs as delimiters 
header=$(echo -e "year/tmonth/tday/tobs_temp/tfc_temp")  # write output to rx_poc.log 

echo $header>rx_poc.log 

# echo -e "year/tmonth/tday/thour/tobs_temp/tfc_temp">rx_poc.log

# assign city name
city=Casablanca

# obtain weather info for the city
curl -s wttr.in/$city?T --output weather_report

# Extract the current temperature, and store it in a shell variable called obs_temp
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')

echo "The current Temperature of $city: $obs_temp"   # print current temperature to console 

# Extract tomorrow's temperature forecast for noon, and store it in a shell variable called fc_temp
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*')

echo "The forecasted temperature for noon tomorrow for $city : $fc_temp C"  # print temp to console 

# Store the current hour, day, month, and year in corresponding shell variables
#Assign Country and City to variable TZ
TZ='Morocco/Casablanca'


# Use command substitution to store the current day, month, and year in corresponding shell variables:
hour=$(TZ='Morocco/Casablanca' date -u +%H) 
day=$(TZ='Morocco/Casablanca' date -u +%d) 
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)


# Merge the fields into a tab-delimited record, corresponding to a single row in Table 1
record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")
echo $record>>rx_poc.log


# do this on system to create cron and run task everyday at noon
# crontab -e
# 0 8 * * * /home/project/weather_report.sh


# Create a script to report historical forecasting accuracy


