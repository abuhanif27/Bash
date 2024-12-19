#!/bin/bash

fibo() {
    n=$1
    first=0
    second=1

    if ((n < 4)); then # question condition: n must be greater than or equal to 4
        echo "-1"
        return
    else
        fibo=(0 1) # array initialization
        for ((i = 2; i < n; i++)); do
            value=$(($first + $second))
            fibo[$i]=$value
            first=$second
            second=$value
        done
        echo "${fibo[@]}"
        return
    fi
}

read -p "For what number you want fibonacci series?: " n

fibo_series=($(fibo "$n"))
length=${#fibo_series[@]} # get length of array

if (($length > 1)); then
    echo "Fibo Series is: ${fibo_series[@]}"

    echo "Before Swapping Second Highest value: ${fibo_series[$length - 2]}"
    echo "Before Swapping Second Lowest value: ${fibo_series[1]}"

    #swap second_highest and second lowest without using any extra variable
    fibo_series[1]=$((${fibo_series[length - 2]} + ${fibo_series[1]}))
    fibo_series[$length - 2]=$((${fibo_series[1]} - ${fibo_series[$length - 2]}))
    fibo_series[1]=$((${fibo_series[1]} - ${fibo_series[$length - 2]}))

    echo "After Swapping Second Highest value: ${fibo_series[$length - 2]}"
    echo "After Swapping Second Lowest value: ${fibo_series[1]}"
else
    echo "Invalid range for Fibonacci series."
fi
