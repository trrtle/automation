#!/bin/bash
# made by fitzcarraldo
 
DIR=$HOME/downloads/torrents/complete
 
# Get rid of old log file, if any
# rm $HOME/virus-scan.log 2> /dev/null
 
IFS=$(echo -en "\n\b")
 
# Optionally, you can use shopt to avoid creating two processes due to the pipe
shopt -s lastpipe
inotifywait --quiet --monitor --event close_write,moved_to --recursive --format '%w%f' $DIR | while read FILE
# Added '--recursive' so that a directory copied into $DIR also triggers clamscan/clamdscan, although downloads
# from the Web would just be files, not directories.
do
     # Have to check file length is nonzero otherwise commands may be repeated
     if [ -s $FILE ]; then 
          # Replace 'date >' with 'date >>' if you want to keep log file entries for previous scans.
          date > $HOME/virus-scan.log
          clamdscan --move=$HOME/virus-quarantine $FILE >> $HOME/virus-scan.log
          # kdialog --title "Virus scan of $FILE" --msgbox "$(cat $HOME/virus-scan.log)"
     fi
done
