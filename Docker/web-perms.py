#python 3


import subprocess
import sys

# set users, groups and directory
user = "user"
group = "group"
dir = "directory"

# change the user
p1 = subprocess.run(f"sudo chown -R {user} {dir}", shell=True, capture_output=True)

if p1.returncode == 0:
    print(f"set user to {user} of directory {dir}... done!")

else:
    print(f"Error {p1.stderr}")
    sys.exit()


# change the group
p2 = subprocess.run(f"sudo chgrp -R {group} {dir}", shell=True, capture_output=True)

if p2.returncode == 0:
    print(f"set group to {group} of directory {dir}... done!")

else:
    print(f"Error {p2.stderr}")
    sys.exit()

# change the permissions
p3 = subprocess.run(f"sudo chmod -R 570 {dir}", shell=True, capture_output=True)

if p3.returncode == 0:
    print(f" Changed permissions of {dir} to 570")

else:
    print(f"Error {p3.stderr}")
    sys.exit()

# show ls -l output
p4 = subprocess.run(f"ls -l {dir}", shell=True, capture_output=True, text=True)
print(p4.stdout)
