#!/bin/bash
read -p "Enter number of blocks: " nb
declare -a blockSizes
#block input array
for ((i = 0; i < nb; i++)); do
    read -p "Block $i size: " value
    blockSizes[$i]=$value
done

read -p "Number of process: " n

#input for memory required for process
declare -a processMemory
declare -a processID
for ((i = 0; i < n; i++)); do
    read -p "Enter memory required for process $i (in bytes) ---- " value
    processMemory[$i]=$value
done

p=0 #block used?

printf "Processes\tProcess Size\tBlocks\tBlocks Size\tAllocated\tInt. Frag."
for ((i = 0; i < n; i++)); do
    printf "\np%d\t\t%d\t\tB%d\t\t%d" "$i" "${processMemory[$i]}" "$i" "${blockSizes[$i]}"
    if ((${processMemory[i]} > ${blockSizes[$i]})); then
        printf "\t\tNO\t\t---"
        p=1
    else
        if ((p == 1)); then
            fg=$((${blockSizes[$i - 1]} - ${processMemory[$i]}))
            p=0
        else
            fg=$((${blockSizes[$i]} - ${processMemory[$i]}))
        fi
        printf "\t\tYES\t\t %d" "$fg"

    fi
done
printf "\n\n"
