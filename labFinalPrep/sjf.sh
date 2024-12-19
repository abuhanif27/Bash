#!/bin/bash

read -p "Enter no. of process: " n
declare -a burstTime
declare -a waitingTime
declare -a turnAroundTime
declare -a processID

for ((i = 0; i < n; i++)); do
    read -p "process $i: " value
    burstTime[$i]=$value
    processID[$i]=$i
done

#bubble sort

for ((i = 0; i < n; i++)); do
    for ((j = 1; j < n - i; j++)); do
        if ((${burstTime[$j]} < ${burstTime[$j - 1]})); then
            #swap burstTime array but higher value
            temp=${burstTime[$j - 1]}
            burstTime[$j - 1]=${burstTime[$j]}
            burstTime[$j]=$temp

            # swap process id based on higher burst time
            temp=${processID[$j - 1]}
            processID[$j - 1]=${processID[$j]}
            processID[$j]=$temp

        fi
    done
done

echo "Burst Time: ${burstTime[@]}"
echo "ProcessID: ${processID[@]}"

waitingTime[0]=0
totalWaitingTime=0
turnAroundTime[0]=${burstTime[0]}
totalTurnAroundTime=${turnAroundTime[0]}

for ((i = 1; i < n; i++)); do
    waitingTime[$i]=${turnAroundTime[$i - 1]}
    turnAroundTime[$i]=$((${waitingTime[$i]} + ${burstTime[$i]}))
    totalWaitingTime=$(($totalWaitingTime + ${waitingTime[$i]}))
    totalTurnAroundTime=$(($totalTurnAroundTime + ${turnAroundTime[$i]}))
done

printf "\n\t PROCESS \tBURST TIME \t WAITING TIME \t TURNAROUND TIME\n"
#print process details
for ((i = 0; i < n; i++)); do
    printf "\t P%d \t\t %d \t\t %d \t\t %d\n" "${processID[i]}" "${burstTime[i]}" "${waitingTime[i]}" "${turnAroundTime[i]}"
done

waitingTimeAvg=$(echo "scale=2; $totalWaitingTime/$n" | bc)
turnAroundTimeAvg=$(echo "scale=2; $totalTurnAroundTime/$n" | bc)

# Print averages
printf "\n\n"
printf "Average Waiting Time --> %.2f \n" "$waitingTimeAvg"
printf "\n"
printf "Average Turnaround Time --> %.2f \n" "$turnAroundTimeAvg"
printf "\n"
