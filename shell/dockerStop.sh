docker container stop $(docker container ls -q -f name="$1")