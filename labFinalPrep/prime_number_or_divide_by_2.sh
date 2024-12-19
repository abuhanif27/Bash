#!/bin/bash

read -p "Enter your number: " n

getPrime() {
    n=$1
    if ((n <= 0)); then
        echo -1
        return
    fi

    for ((i = 2; i < n; i++)); do
        if ((n % i == 0)); then
            echo 0
            return
        fi
    done

    echo 1
    return
}

getDivisibleBy2() {
    n=$1
    if ((n <= 0)); then
        echo -1
        return
    fi
    if ((n % 2 == 0)); then
        echo 1
        return
    fi
    echo 0
    return
}

isPrime=$(getPrime "$n")
isDivisibleBy2=$(getDivisibleBy2 "$n")

if ((isPrime == 0 && isDivisibleBy2 == 0)); then
    echo "$n is not prime and not divisible by 2"
elif ((isPrime == 0 && isDivisibleBy2 == 1)); then
    echo "$n is not a prime but divisible by 2"
elif ((isPrime == 1 && isDivisibleBy2 == 0)); then
    echo "$n is a prime and not divisible by 2"
elif ((isPrime == 1 && isDivisibleBy2 == 1)); then
    echo "$n is a prime and also divisible by 2"
else
    echo "$n is invalid input to check"
fi
