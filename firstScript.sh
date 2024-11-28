#!/bin/bash

# This is our first script

INPUT_STRING="hello"

while [ "$INPUT_STRING" != "bye" ]
do
    read -p "Type something (bye to quit): " INPUT_STRING
    echo "YOU TYPED: $INPUT_STRING"
done

