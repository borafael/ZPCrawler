#!/bin/bash

DB_USER=root
DB_PASS=termopilas
DB_NAME=zonaprop

BASE_URL=http://www.zonaprop.com.ar/propiedades

ID=`echo "$1" |sed 's-.*/propiedades/.*\-\([0-9]*\)\.html-\1-g'`
TITLE=`echo "$1" |sed 's-.*/propiedades/\(.*\)-\1-g'`
TYPE=$2
BARRIO=$3

URL=$BASE_URL/$TITLE

TMP_FILE="$TITLE.tmp"

curl -s $URL > $TMP_FILE

#dont forget to escape hyphens!
PRECIO=`cat $TMP_FILE |grep "<span class=\"valor\" >U$S" |sed 's-<span class="valor" >U$S\(.*\)</span>-\1-g'`
SUP_TOTAL=`cat $TMP_FILE |grep "</small> Superficie total</span>" |sed 's-<span class="nombre"><i class="licon licon\-superficie_total"></i>\([0-9]*\)<small>m&#178;</small> Superficie total</span>-\1-g'`
SUP_CUBIERTA=`cat $TMP_FILE |grep "licon licon\-superficie_cubierta" |sed 's-<span class="nombre"><i class="licon licon\-superficie_cubierta"></i>\([0-9]*\)<small>m&#178;</small> Superficie cubierta</span>-\1-g'`
CANT_AMBIENTES=`cat $TMP_FILE |grep -m 1 "licon licon\-ambientes" |sed 's-<span class="nombre"><i class="licon licon\-ambientes"></i>\([1-9][0-9]*\).*</span>-\1-g'`
CANT_DORMITORIOS=`cat $TMP_FILE |grep "licon licon\-dormitorios" |sed 's-<span class="nombre"><i class="licon licon\-dormitorios"></i>\([1-9][0-9]*\).*</span>-\1-g'`
CANT_BANOS=`cat $TMP_FILE |grep -m 1 "licon licon\-banos" |sed 's-<span class="nombre"><i class="licon licon\-banos"></i>\([1-9]\).*-\1-g'`

INSERT_SQL="INSERT INTO avisos (createdOn, codigo, tipo, url, barrio, precio, supTotal, supCubierta, cantAmbientes, cantDormitorios, cantBanos) VALUES (now(), $ID, '$TYPE', '$URL', '$BARRIO', replace(trim('$PRECIO'), '.', ''), $SUP_TOTAL, $SUP_CUBIERTA, $CANT_AMBIENTES, $CANT_DORMITORIOS, $CANT_BANOS);"

echo $INSERT_SQL |mysql -u$DB_USER -p$DB_PASS $DB_NAME

rm $TMP_FILE
