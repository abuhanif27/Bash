#!/bin/bash
declare -a processID
declare -a burstTime
declare -a waitingTime
declare -a turnAroundTime
declare -a priority

read -p "Enter number of pcoess: " n

#read input
for ((i = 0; i < n; i++)); do
    read -p "Enter value of pocess $i: " value
    burstTime[$i]=$value
    processID[$i]=$i

    read -p "Enter priority of process $i: " pr
    priority[$i]=$pr
done

#bubble sort (based on priority)
for ((i = 0; i < n; i++)); do
    for ((j = 1; j < n - i; j++)); do
        if ((${priority[$j]} < ${priority[$j - 1]})); then
            #swap priority
            temp=${priority[$j - 1]}
            priority[$j - 1]=${priority[$j]}
            priority[$j]=$temp

            #swap burst time
            temp=${burstTime[$j - 1]}
            burstTime[$j - 1]=${burstTime[$j]}
            burstTime[$j]=$temp

            #swap process id
            temp=${processID[$j - 1]}
            processID[$j - 1]=${processID[$j]}
            processID[$j]=$temp
        fi
    done
done

waitingTime[0]=0
totalWaitingTime=0

turnAroundTime[0]=${burstTime[0]}
totalTurnAroundTime=${turnAroundTime[0]}

for ((i = 1; i < n; i++)); do
    waitingTime[$i]=${turnAroundTime[$i - 1]}
    totalWaitingTime=$(($totalWaitingTime + ${waitingTime[$i]}))

    turnAroundTime[$i]=$((${waitingTime[$i]} + burstTime[$i]))
    totalTurnAroundTime=$(($totalTurnAroundTime + ${turnAroundTime[$i]}))

done

printf "PROCESS\tBURST TIME\tPRIORITY\tWAITING TIME\tTURNAROUND TIME\n"

for ((i = 0; i < n; i++)); do
    printf "P%d\t%d\t\t%d\t\t\t%d\t\t%d\n" "${processID[i]}" "${burstTime[i]}" "${priority[i]}" "${waitingTime[i]}" "${turnAroundTime[i]}"
done
