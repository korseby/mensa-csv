#!/bin/bash
#
# mensa.sh fetches a list + prices of lunches and saves them in a csv file
# you need sed, perl and Rscript in your $PATH
#
# you probably want to do this once every weekday, so adding this via crontab -e is recommended:
# 00      10      *       *       1-5     /home/kpeters/mensa.sh

IFS="
"
TMPFILE="/tmp/mensa.rss"
TBLFILE="/tmp/mensa.table"
CSVFILE="/home/kpeters/mensa.csv"

wget -O $TMPFILE 'https://www.meine-mensa.de/speiseplan_rss?location_id=5'
cat $TMPFILE | perl -pe 's/<[^>]*>//g' | sed -e '/^\s*$/d' | sed -n '/CDATA/,$p' | sed '/CDATA/d' | sed '/Weinbergmensa/d' | sed '/\]\]/,$d' | sed -e 's/^[ \t]*//' | sed -e 's/\&euro\;//g' | sed -e 's/\;//g' > $TBLFILE

NAME=( $(cat /tmp/mensa.table | sed -n '1~4p') )
STUDIERENDE=( $(cat /tmp/mensa.table | sed -n '2~4p') )
MITARBEITER=( $(cat /tmp/mensa.table | sed -n '3~4p') )
GAESTE=( $(cat /tmp/mensa.table | sed -n '4~4p') )

for ((i=1;i<${#NAME[@]};i++)); do
        echo "${NAME[0]};${NAME[$i]};${STUDIERENDE[$i]};${MITARBEITER[$i]};${GAESTE[$i]}" >> $CSVFILE
done


