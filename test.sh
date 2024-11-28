#!/bin/bash

# This is designed for test
run=1
while [ $run -eq 1 ]
do
    read -p "Type something here: " type
    if [ "$type" = "exit" ]  # Use '=' for string comparison
    then 
        echo "Thank you for using"
        run=0  # Change run to 0 to exit the loop
    else
        echo "You typed: $type"
    fi
done

