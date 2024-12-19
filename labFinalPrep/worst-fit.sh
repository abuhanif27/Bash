#!/bin/bash

declare -a block_sizes
declare -a file_sizes
declare -a frag
declare -a block_allocated
declare -a file_allocated_indexes

read -p "Enter number of blocks: " nb
read -p "Enter number of files: " nf

#take input for block sizes
for ((i = 0; i < nb; i++)); do
    read -p "Enter size of block $i: " value
    block_sizes[$i]=$value
    block_allocated[$i]=0 #inintally all block is free
done

#take input for file sizes
for ((i = 0; i < nf; i++)); do
    read -p "Enter size of file  $i: " value
    file_sizes[$i]=$value
done

highest=0

for ((i = 0; i < nf; i++)); do
    for ((j = 0; j < nb; j++)); do
        temp=$((${block_sizes[$j]} - ${file_sizes[$i]}))
        if (($temp > $highest && ${block_allocated[$j]} == 0)); then
            highest=$temp
            file_allocated_indexes[$i]=$j
        fi
    done
    #block is used
    block_allocated[${file_allocated_indexes[$i]}]=1
    frag[$i]=$highest
    highest=0
done

echo "Block Sizes are: ${block_sizes[@]}"
echo "File Sizes are: ${file_sizes[@]}"
echo "File allocated indexes are: ${file_allocated_indexes[@]}"
echo "Fragmentations are: ${frag[@]}"
