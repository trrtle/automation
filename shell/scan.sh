#! /bin/bash
# when a file is added to the dir run a clamscan

DIR=$HOME/downloads/torrents/complete

# Optionally, you can use shopt to avoid creating two processes due to the pipe
shopt -s lastpipe
inotifywait --quiet --monitor --event close_write,moved_to --recursive --format '%w%f' $DIR | while read FILE
do
     # Have to check file length is nonzero otherwise commands may be repeated
     if [ -s $FILE ]; then
          echo $FILE
          clamscan -r -i $FILE >> $HOME/virus-scan.log
     fi
done
