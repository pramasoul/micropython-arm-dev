#/bin/bash
docker run -it \
       --rm \
       --name upy-make \
       --user $(id -u):$(id -g) \
       --mount type=bind,source="${HOME}/Projects/micropython",target=/opt/micropython \
       --shm-size 1G \
       --cpus=4 \
       mad:latest \
       /bin/bash
