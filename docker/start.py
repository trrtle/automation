#python 3


import subprocess

# change the container names in the container list to match the names of your container.
containers = ["container1", "container2", "container3"]

# start docker in systemd
p1 = subprocess.run("sudo systemctl start docker", shell=True, capture_output=True, text=True)
print("startup docker...")

if p1.returncode == 0:
    print("done")

    # start all wordpress containers
    for container in containers:
        p2 = subprocess.run(f"docker container start {container}", shell=True, capture_output=True, text=True)
        if p2.returncode == 0:
            print(p2.stdout + " booted...")
        else:
            print(f"Error {p2.stderr}" )
    
else:
    print(f"Error {p1.stderr}")


