#!/bin/bash

read -p  "Enter a number: " number

declare -A frequency

len=${#number}
i=0

while (( i < len ))
do
  digit=${number:$i:1}
  ((frequency[$digit]++))
  ((i++))
done

for digit in "${!frequency[@]}"
do
  echo "$digit = ${frequency[$digit]} times"
done
