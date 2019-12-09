# Python 3

import subprocess

def shellCommand(command):
    print(f"running command: {command}")

    p1 = subprocess.run(command, shell=True, capture_output=True, text=True)

    if p1.returncode == 0:
        print("done!..")
    else:
        print(f"error: {p1.stderr}")
        userConfirmation()

def userConfirmation():
    # asking the user if he wants to continue running the script
    keepGoing = 0

    while keepGoing == 0:
        userInput1 = input("do you want to exit the script? y/n?: ") # allow upper case letters

        if userInput1 == "y" or userInput1 == "yes":
            exit() # exit the script

        elif userInput1 == "n" or userInput1 == "no":
            userInput2 = input("are you sure want to continue running the script? y/n?: ")
            if userInput2 == "y" or userInput2 == "yes":
                keepGoing = 1 # continue running the script
            elif userInput2 == "n" or userInput2 == "no":
                exit() # exit the script
            else:
                continue
            
        else:
            continue


# stop docker
shellCommand("sudo systemctl stop docker")

# mount all drives from fstab
shellCommand("sudo mount -a")

# run a rsync test
shellCommand("sudo rsync -na --exclude-from=rsync-homedir-excludes.txt /home/turtle/ /home/turtle/Network/Micky/Backups/Zubat")
# rsync my home directory to a mounted network drive
shellCommand("sudo rsync -a --exclude-from=rsync-homedir-excludes.txt /home/turtle/ /home/turtle/Network/Micky/Backups/Zubat")


