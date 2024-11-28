read -p "Enter number of blocks: " num_blocks
read -p "Enter number of files: " num_files

for (( i=1; i<=num_blocks; i++ ))
   do
      read -p "Enter size of Block $i: " block_size[$i]
      block_available[$i]=0
done

for (( i=1; i<=num_files; i++ ))
   do
      read -p "Enter size of File $i: " file_size[$i]
done

for (( i=1; i<=num_files; i++ ))
   do
      smallest_fragment=-1
      best_block_index=-1

      for (( j=1; j<=num_blocks; j++ ))
         do
            remaining_space=$((block_size[$j] - file_size[$i]))
            if [ $remaining_space -ge 0 ] && [ ${block_available[$j]} -eq 0 ]
               then
                  if [ $smallest_fragment -eq -1 ] || [ $remaining_space -lt $smallest_fragment ]
                     then
                        smallest_fragment=$remaining_space
                        best_block_index=$j
                  fi
            fi
      done

      if [ $best_block_index -ne -1 ]
         then
            block_available[$best_block_index]=1
            file_allocation[$i]=$best_block_index
            fragmentation[$i]=$smallest_fragment
      else
         file_allocation[$i]=-1
         fragmentation[$i]=-1
      fi
done

echo "File Sizes: ${file_size[@]}"
echo "Block Sizes: ${block_size[@]}"
echo "File -> Block Allocation: ${file_allocation[@]}"
echo "Fragmentation: ${fragmentation[@]}"
