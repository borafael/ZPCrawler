#!/bin/bash

FILES_DIR=files
SCRIPTS_DIR=scripts
WORK_DIR=work

if [ -d $WORK_DIR ]; then
	rm -Rf $WORK_DIR
fi

mkdir $WORK_DIR
cp $FILES_DIR/* $WORK_DIR/
cp $SCRIPTS_DIR/* $WORK_DIR/
cd $WORK_DIR
./launcher.sh 1 > logs.txt 2 > logs.txt 
./launcher-single.sh 1 > logs.txt 2 > logs.txt 
