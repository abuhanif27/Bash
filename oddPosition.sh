#!/bin/bash

read -p "Enter a 7-digit number:" number

for (( i=0; i<${#number}; i+=2 )); do
  echo "${number:$i:1}"
done
