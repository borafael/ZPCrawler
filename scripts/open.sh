#!/bin/bash

FILE=$1
BASE_URL=$2

for URL in `cat $1`
do
	firefox $BASE_URL$URL
done
