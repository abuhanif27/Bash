#!/bin/bash
read -p "Enter the number of pages : " np
for ((i = 0; i < np; i++)); do
    read pages[$i]
done

read -p " Enter the number of frames : " nf
for ((i = 0; i < nf; i++)); do
    frames[$i]=-1
done
hit=0
miss=0
index=0
for ((i = 0; i < np; i++)); do
    for ((j = 0; j < nf; j++)); do
        if ((${frames[$j]} == ${pages[$i]})); then
            ((hit++))
            echo "${frames[@]} page hit no. $hit"
            break
        fi
    done
    if (($j == $nf)); then
        ((miss++))
        frames[$index]=${pages[$i]}
        index=$(((index + 1) % nf))
        echo "${frames[@]} page miss no. $miss"
    fi
done
