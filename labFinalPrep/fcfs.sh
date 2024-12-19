#!/bin/bash
declare -a burstTime
declare -a waitingTime
declare -a turnAroundTime
declare -a processID

read -p "Enter The number of process: " n

#input for process

for ((i = 0; i < n; i++)); do
    read -p "Enter value for process $i: " value
    burstTime[$i]=$value
    processID[$i]=$i
done

waitingTime[0]=0
totalWaitingTime=0
turnAroundTime[0]=${burstTime[0]}
totalTurnAroundTime=${turnAroundTime[0]}

for ((i = 1; i < n; i++)); do
    waitingTime[$i]=${turnAroundTime[$i - 1]}
    totalWaitingTime=$(($totalWaitingTime + waitingTime[$i]))
    turnAroundTime[$i]=$((${waitingTime[$i]} + ${burstTime[$i]}))
    totalTurnAroundTime=$(($totalTurnAroundTime + turnAroundTime[$i]))
done

waitingTimeAvg=$(echo "scale=2; $totalWaitingTime/$n" | bs)
turnAroundTimeAvg=$(echo "scale=2; $totalTurnAroundTime/$n" | bs)

printf "PROCESS\tBURST TIME\tWAITING TIME\tTURNAROUND TIME\n"

for ((i = 0; i < n; i++)); do
    printf "P%d\t%d\t\t%d\t\t%d\n" "${processID[i]}" "${burstTime[i]}" "${waitingTime[i]}" "${turnAroundTime[i]}"
done

printf "\n\nAverage Waiting Time: $waitingTimeAvg\n"
echo "Average Turn Around Time: $turnAroundTimeAvg"
