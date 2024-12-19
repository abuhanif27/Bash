#!/bin/bash
read -p "Enter Memory Size: " memorySize
read -p "Enter Block Size: " blockSize

ef=$(($memorySize % $blockSize)) #external Fragmentation
i=0
p=0
tif=0 #total internal Fragmentation

read -p "Enter the number of process: " n

#take input for memory required process
declare -a processMemory
for ((i; i < n; i++)); do
    read -p "Enter Memory required for process $i (in Bytes) --- " value
    processMemory[$i]=$value
done

availableBlocks=$(($memorySize / $blockSize))

printf "\nNumber of blocks avaialbe in memory --- %d\n" "$availableBlocks"

printf "\nPROCESS\tMEMORY REQUIRED\tALLOCATED\tINTERNAL FRAGMENTATION"
for ((i = 0; i < n && p < availableBlocks; i++)); do
    printf "\nP%d\t\t%d" "$i" "${processMemory[$i]}"
    if ((${processMemory[$i]} > $blockSize)); then
        printf "\t\tNO\t\t---"
    else
        fg=$(($blockSize - ${processMemory[$i]})) #fragmentation
        printf "\t\tYES\t\t%d" "$fg"
        p=$(($p + 1))
        tif=$(($tif + $fg))
    fi
done

#handle process that cannot be allocated
if ((i < n)); then
    printf "\nMemmory is full, Remaining process cannot be acommodated!"
fi

printf "\nTotal Interal Fragmentaion: %d" "$tif"
printf "\nTotal External Fragmentation: %d\n" "$ef"
