#!/bin/bash

read -p "who many times you want as fibonnaic? " n
result=0
a=0
b=1
for ((i = 2; i < $n - 2; i++)); do
    result=$((a + b))
    a=$((i - 1))
    echo $a
    b=$((i - 2))
    echo $b
done

echo "Factorial of $n is : "$result
