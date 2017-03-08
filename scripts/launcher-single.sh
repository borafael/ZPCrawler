#!/bin/bash

OPERACION=venta

for TYPE in `cat tipos.txt`
do
	for BARRIO in `cat barrios.txt`
	do
		FILE=$TYPE-$OPERACION-$BARRIO-publicado-hace-menos-de-1-dia.txt
		echo "Opening $FILE"
		for URL in `cat $FILE`
		do
			echo "Crawlin' $URL"
			./crawler-zonaprop-single.sh $URL $TYPE $BARRIO &
		done

		rm $FILE
	done 
done
