# MENSA-CSV

## Description
mensa.sh fetches a list + prices of lunches and saves them in a csv file.

## Prerequisites
You need sed, perl and Rscript in your $PATH

## Fancy stuff
You probably want to do this once every weekday, so adding this via `crontab -e` is recommended:
```00      10      *       *       1-5     /home/kpeters/mensa.sh```

