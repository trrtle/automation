LATESTPACMAN=$(sudo cat /var/log/pacman.log | grep "pacman -Syu" | tail -1)
COUNT=0

for CHAR in $LATESTPACMAN; do
    echo $CHAR
done