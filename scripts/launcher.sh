#!/bin/bash

OPERACION=venta

for BARRIO in `cat barrios.txt`
do
	for TIPO in `cat tipos.txt`
	do
		./crawler-zonaprop.sh $TIPO-$OPERACION-$BARRIO-publicado-hace-menos-de-1-dia &
	done
done
