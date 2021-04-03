#!/bin/bash

STAGES=$1
DIM=$2
FA_RATE=$3

POS=25
NEG=1800
NEG_PER_POS=$NEG/$POS
NEG_PER_POS_2_3=$NEG_PER_POS*2/3
SAMPLES=$POS*$NEG_PER_POS_2_3
$NUM_POS=$SAMPLES*3/4
$NUM_NEG=$NUMPOS/2

rm -rf data
find neg -iname "*.jpg" > bg.txt
mkdir all
touch all/info.lst

for (( i=1; i<=$POS; i++)) do
	START=(i-1)*$NEG_PER_POS
	mkdir net$i
	for (( j=$START + 1; j<=$START+$NEG_PER_POS; j++)) do
		cp neg/$j.jpg net$i
	done
	find net$i -iname "*.jpg" > net$i.txt
	opencv_createsamples -img pos_sample/$i.png -bg net$i.txt -info info$i/info.lst -pngoutput info$i -maxxangle 0.5 -maxyangle 0.5 -maxzangle 0.5 -num $NEG_PER_POS_2_3
	sed "s/^/$i|/" info$i/info.lst >> all/info.lst
	cd info$i
	for file in *.jpg; do
		mv "$file" "../all/$i|$file"
	done	
	cd ..
done

rm -rf net*
opencv_createsamples -info all/info.lst -num $SAMPLES -w $DIM -h $DIM -vec positives.vec 
rm -rf info*
mkdir data
opencv_traincascade -data data -vec positives.vec -bg bg.txt -numPos $NUM_POS -numNeg $NUM_NEG -numStages $STAGES -w $DIM -h $DIM -maxFalseAlarmRate  $FA_RATE
rm -rf all
rm positives.vec
rm bg.txt




