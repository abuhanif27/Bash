#!/bin/bash
declare -a array
read -p "how many itesm you want in your array?: " n
sum=0
#Enter elements
for ((i = 0; i < n; i++)); do
    read -p "Enter value of item ($i): " value
    sum=$((sum + value))
    array[$i]=$value
done

echo "Array: ${array[@]}"

#bubble sort
for ((i = 0; i < n; i++)); do
    for ((j = 1; j < n - i; j++)); do
        if ((${array[$j]} > ${array[$j - 1]})); then
            temp=${array[$j - 1]}
            array[$j - 1]=${array[$j]}
            array[$j]=$temp
        fi
    done
done

highest=${array[0]}
lowest=${array[n - 1]}

echo "Sorted Array: ${array[@]}"

echo "Highest item from the array: $highest"

echo "Lowest item from the array: $lowest"

echo "sum of all items are: $sum"
