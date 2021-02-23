#!/bin/bash
dmsetup status | grep snap > old

sleep 10

dmsetup status | grep snap > current

x=0
y=0

while [ $x -le 100 ]
do
  if [ $(diff old current) ]
  then
    echo "estan diferentes"
    y=0
  else
  	echo "estan igual"
  	y=$((y+1))
  fi
  if [ $y -gt 3 ]
  then
  	exit 1
  fi
  x=$((x+1))
  rm ./old
  mv ./current ./old
  sleep 10
  dmsetup status | grep snap > current
done
exit 0