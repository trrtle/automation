#! /bin/bash
# maintanance.sh
# 1. creates a file called arch-pkgs.txt with all the installed packages.
# 2. creates a file called arch-aur-pkgs.txt with all the installed packages from the aur
# 3. backup the home directory
# 4. remove unecessary dependencies.
# 5. update the system.
#
# script is still in development
############

PKGLIST="/home/turtle/pkgs.txt"
AURPKGLIST="/home/turtle/aur-pkgs.txt"
EXCLUDESFILE = "~/Development/Scripts/automation/shell/rsync-homedir-excludes.txt"

# 1. create a file called arch-pkgs.txt with all the installed packages.
sudo pacman -Qqtn > $PKGLIST
EXITCODE=$?
if [[ $EXITCODE -eq 0 ]]; then
    echo $(pacman -Qqtn | wc -l) "packages written to $PKGLIST"
else
    echo 'error with sudo pacman -Qqtn > $PKGLIST'
fi

# 2. create a file called arch-aur-pkgs.txt with all AUR pkgs
sudo pacman -Qqem > $AURPKGLIST
EXITCODE=$?
if [[ $EXITCODE -eq 0 ]]; then
    echo $(pacman -Qqem | wc -l) "packages written to $AURPKGLIST"
else
    echo 'error with sudo pacman -Qqem > $AURPKGLIST'
fi


# 3. backup the home directory
echo "terminate docker service..."
sudo systemctl stop docker
EXITCODE=$?
if [[ $EXITCODE -eq 0 ]]; then
    echo "Master, the operation is well executed :D"
else
    echo 'Sorry Master, i cannot stop docker :('
    exit 1;
fi

echo "Mounting network drives"
sudo mount -a
EXITCODE=$?
if [[ $EXITCODE -eq 0 ]]; then
    echo 'All the network drives are mounted!'
else
    echo 'Sorry master, i cant mount the drives. Are you at home?'
    exit 1;
fi

# do a rsync test
echo "Master, please give me a second while i test the backup"
sudo rsync -na --exclude-from=$EXCLUDESFILE /home/turtle/ /home/turtle/Network/Micky/Backups/Zubat
EXITCODE=$?
if [[ $EXITCODE -eq 0 ]]; then
    echo 'Test well executed, im so goood'
else
    echo 'Operation terminated: Bleep bleep boop'
    exit 1;
fi

# Run rsync
echo "STARTING BACKUP NOW"
sudo rsync -av --no-l --exclude-from=rsync-homedir-excludes.txt /home/turtle/ /home/turtle/Network/Micky/Backups/Zubat > backup_log.txt
EXITCODE=$?
if [[ $EXITCODE -eq 0 ]]; then
    echo 'Backup is complete. oh boi you got some nasty shit in there.'
else
    echo 'Operation terminated. To much data to handle'
    exit 1;
fi


# echo "Removing filthy unused packages..."
# # 4. remove unecessary dependencies.
# sudo pacman -Rns $(pacman -Qtdq)
# EXITCODE=$?
# if [[ $EXITCODE -eq 0 ]]; then
#     echo 'I am clean'
# else
#     echo 'Operation terminated. To nasty!'
#     exit 1;
# fi

# 5. update the system.
echo "Update all my packages..."
sudo pacman -Syu
EXITCODE=$?
if [[ $EXITCODE -eq 0 ]]; then
    echo 'I am fully up-to-date!'
else
    echo 'Operation terminated'
    exit 1;
fi
