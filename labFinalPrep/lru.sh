#!/bin/bash

read -p "Enter the number of pages: " np
for ((i = 0; i < np; i++)); do
    read -p "Enter page $((i + 1)): " pages[$i]
done

read -p "Enter the number of frames: " nf
declare -a frames
declare -a timestamps
for ((i = 0; i < nf; i++)); do
    frames[$i]=-1
    timestamps[$i]=-1
done

hit=0
miss=0
time=0

for ((i = 0; i < np; i++)); do
    found=0
    for ((j = 0; j < nf; j++)); do
        if ((frames[j] == pages[i])); then
            ((hit++))
            timestamps[$j]=$time
            found=1
            echo "${frames[@]} page hit no. $hit"
            break
        fi
    done

    if ((found == 0)); then
        ((miss++))
        # Find the least recently used frame
        lru_index=0
        oldest_time=${timestamps[0]}
        for ((k = 1; k < nf; k++)); do
            if ((timestamps[k] < oldest_time)); then
                oldest_time=${timestamps[k]}
                lru_index=$k
            fi
        done
        # Replace the LRU frame with the current page
        frames[$lru_index]=${pages[$i]}
        timestamps[$lru_index]=$time
        echo "${frames[@]} page miss no. $miss"
    fi
    ((time++))
done
