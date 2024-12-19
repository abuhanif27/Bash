#!/bin/bash

declare -a block_sizes
declare -a file_sizes
declare -a block_allocated
declare -a frag
declare -a file_allocated_indexes

read -p "Enter number of block sizes: " nb
read -p "Enter number of file sizes: " nf

#take input fo block sizes
for ((i = 0; i < nb; i++)); do
    read -p "Enter size of block $i: " value
    block_sizes[$i]=$value
    block_allocated[$i]=0 #initally no block is used
done

#take input for file sizes
for ((i = 0; i < nf; i++)); do
    read -p "Enter size of file $i: " value
    file_sizes[$i]=$value
done

#allocated-file using first-fit alogrithms
for ((i = 0; i < nf; i++)); do
    file_allocated_indexes[$i]=-1
    frag[$i]=-1
    for ((j = 0; j < nb; j++)); do
        temp=$((${block_sizes[$j]} - ${file_sizes[$i]}))
        if (($temp >= 0 && ${block_allocated[$j]} == 0)); then
            block_allocated[$j]=1
            file_allocated_indexes[$i]=$j
            frag[$i]=$temp
            break # stop searching after first suitable block is found
        fi
    done
done

echo "Block sizes: ${block_sizes[@]}"
echo "File sizes: ${file_sizes[@]}"
echo "File allocated to blocks (by index): ${file_allocated_indexes[@]}"
echo "Fragmentation for each file: ${frag[@]}"
