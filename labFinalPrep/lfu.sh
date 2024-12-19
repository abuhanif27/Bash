#!/bin/bash
read -p "Enter the number of pages: " np
for ((i = 0; i < np; i++)); do
    read -p "Enter page $((i + 1)): " pages[$i]
done

read -p "Enter the number of frames: " nf
declare -a frames
declare -a frequencies
declare -a timestamps

for ((i = 0; i < nf; i++)); do
    frames[$i]=-1
    frequencies[$i]=0
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
            ((frequencies[j]++))
            timestamps[$j]=$time
            found=1
            echo "${frames[@]} page hit no. $hit"
            break
        fi
    done

    if ((found == 0)); then
        ((miss++))
        # Find the least frequently used frame
        lfu_index=0
        min_frequency=${frequencies[0]}
        oldest_time=${timestamps[0]}

        for ((k = 1; k < nf; k++)); do
            if ((frequencies[k] < min_frequency || (frequencies[k] == min_frequency && timestamps[k] < oldest_time))); then
                min_frequency=${frequencies[k]}
                oldest_time=${timestamps[k]}
                lfu_index=$k
            fi
        done

        # Replace the LFU frame with the current page
        frames[$lfu_index]=${pages[$i]}
        frequencies[$lfu_index]=1
        timestamps[$lfu_index]=$time
        echo "${frames[@]} page miss no. $miss"
    fi
    ((time++))
done
