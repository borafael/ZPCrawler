#!/bin/bash

QUERY=$1
BASE_URL=http://www.zonaprop.com.ar
TMP_FILE=tmp.html

URL=$BASE_URL/$QUERY.html

echo "Crawlin' $URL"

TMP_FILE=$QUERY.tmp

FILE=$QUERY.txt

curl -s $URL > $TMP_FILE

grep -o /propiedades/.*\.html $TMP_FILE |uniq > $FILE

rm $TMP_FILE

if [ ! -s $FILE ]; then
        exit 1
fi

PAGE_NUMBER=2

PAGE_URL=$BASE_URL/$QUERY-pagina-$PAGE_NUMBER.html

echo $PAGE_URL

curl -s $PAGE_URL > $TMP_FILE

while [ -s $TMP_FILE ]
do
	((PAGE_NUMBER++))
	PAGE_URL=$BASE_URL/$QUERY-pagina-$PAGE_NUMBER.html
	echo $PAGE_URL
	curl -s $PAGE_URL > $TMP_FILE
	grep -o /propiedades/.*\.html $TMP_FILE |uniq >> $FILE
done

rm $TMP_FILE
