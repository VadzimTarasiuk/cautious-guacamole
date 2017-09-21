#!/bin/bash

#DEFAULTS
FILES_SOURCE=`pwd`;
FILES_DEST=`pwd`;
EXT='.torrent';
DATA_PATH=`pwd`;
VB=0;
read -r -d '' USAGE << EOM
  The script is suited to filter collection of torrent-files with automatically given names matching the downloaded data. 
It searches the .torrent files and folders with the same name and copies the files to a specified path. New copies of files 
could be then passed to a torrent-manager application all as one.
    Usage: 
      -s - Source path of the torrent-files. The defult is current folder (pwd). 
      -d - Destination path to copy matching files. The default is current folder (pwd).
      -f - Target Directory for downloaded data. The default is current folder (pwd).
      -h - This message. Default path for already downloaded folders is current folder (pwd).
      -v - Not yet implemented. Verbose output of copied files and folders not matching any torrents.
      -e - Change an extension. Default is '.torrent' but it may differs depending on torrent-manager. Be aware of dots.

  example: bash /tmp/scripts/namecounting.sh -s /somepath/somefolder -d ./ -f localfolder/downloads/ -e .torrent.backups -v
EOM

#ARGUMENTS
case "$1" in
  -h | --help)
  echo "$USAGE"; exit 0;;
esac

while getopts s:d:f:e:v option
do
  case "${option}"
  in
  s) FILES_SOURCE="${OPTARG}";;
  d) FILES_DEST="${OPTARG}";;
  f) DATA_PATH="${OPTARG}";;
  e) EXT="${OPTARG}";;
  v) echo "===== Verbose option activated ====="; VB=1;;
  esac
done


#THE MAIN CODE
torrents_arr=();
if [[ $VB == 1 ]]; then echo "List of files found in path $FILES_SOURCE :"; fi
for file in "$FILES_SOURCE"/*; do
  if [[ -f $file ]]; then
    new_item=`basename "$file" "$EXT"`;
    torrents_arr=("${torrents_arr[@]}" "$new_item");
    if [[ $VB == 1 ]]; then
      echo "    $new_item"
    fi
  fi
done

folders_arr=();
if [[ $VB == 1 ]]; then echo "List of folders found in path $DATA_PATH :"; fi 
for dir in $DATA_PATH/*; do
  if [[ -d $dir ]]; then
    new_item=`basename "$dir"`;
    folders_arr=("${folders_arr[@]}" "$new_item");
    if [[ $VB == 1 ]]; then
      echo "    $new_item"
    fi
  fi
done

counter=0; i=0; j=0;
for i in "${torrents_arr[@]}"; do
  for j in "${folders_arr[@]}"; do
    if [[ "$i" == "$j" ]]; then
      new_item="$FILES_SOURCE"/"$i""$EXT";
      counter=$((counter+1));
      cp "$FILES_SOURCE"/"$i""$EXT" "$FILES_DEST"
      if [[ $VB == 1 ]]; then
        echo "File $new_item copied to $FILES_DEST"
      fi
    fi
  done
done
echo "==== $counter objects were processed. ===="
