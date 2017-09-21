#!/bin/bash

torrents_arr=();
for file in /mnt/d/qtors/*; do
#  torrentfiles_arr[i]+=${file##*/};
  torrents_arr=("${torrents_arr[@]}" "`basename "$file" .txt`");
done

folders_arr=(); n=0;
for dir in ./*; do
  if [[ -d $dir ]]; then
    folders_arr=("${folders_arr[@]}" "`basename "$dir"`");
  fi
done

#echo "${torrents_arr[3]}"
#echo "${folders_arr[3]}"
#if [[ "${torrents_arr[3]}" == "${folders_arr[3]}" ]]; then
#  echo "Basically they are equal"
#else 
#  echo "Something is wrong with comparement"
#fi

counter=0; i=0; j=0;
for i in "${torrents_arr[@]}"; do
  for j in "${folders_arr[@]}"; do
    if [[ "$i" == "$j" ]]; then
      counter=$((counter+1));
      cp /mnt/d/qtors/"$i".txt ./
    fi
  done
done
echo "We have $counter coincedences"
