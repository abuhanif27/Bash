#!/bin/bash
declare -a file_sizes
declare -a block_sizes
declare -a block_allocated
declare -a file_allocated_indexes
declare -a frag

read -p "Enter number of blocks: " nb
read -p "Enter number of files: " nf

#take input for block sizes
for ((i = 0; i < nb; i++)); do
    read -p "Enter size of block $i: " value
    block_sizes[$i]=$value
    block_allocated[$i]=0 #default block is not used
done

#take input for file sizes
for ((i = 0; i < nf; i++)); do
    read -p "Enter size of file $i: " value
    file_sizes[$i]=$value
done

for ((i = 0; i < nf; i++)); do
    smallest=-1
    for ((j = 0; j < nb; j++)); do
        temp=$((${block_sizes[$j]} - ${file_sizes[$i]}))
        if (($temp >= 0 && ${block_allocated[$j]} == 0)); then
            if ((smallest == -1 || temp < smallest)); then
                smallest=$temp
                file_allocated_indexes[$i]=$j
            fi
        fi
    done
    if ((smallest != -1)); then
        block_allocated[${file_allocated_indexes[$i]}]=1
        frag[$i]=$smallest
    else
        file_allocated_indexes[$i]=-1
        frag[$i]=-1
    fi
done

echo "Block sizes: ${block_sizes[@]}"
echo "File sizes: ${file_sizes[@]}"
echo "File allocated to blocks (by index): ${file_allocated_indexes[@]}"
echo "Fragmentation for each file: ${frag[@]}"
