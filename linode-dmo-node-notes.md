# Linode-dmo-notes

Some notes on the process of spinning up a Dynamo node using docker and Merdball's dmo-node repo/dockerhub image:

repo: https://github.com/Nerdmaster/dmo-node
docker image: https://hub.docker.com/r/nerdmaster/dmo-node

### Basic process flow
This assumes a Linode account has already been created.

- Create Linode Ubuntu instance in preferred region. At this time, we are not using any region-specific linode feature.
    - Unless building a new image from the repo, the smallest nanode size should suffice.
- Install docker with snap
    ```bash
    snap install docker
    ```
- Clone repo
    ```bash
    git clone https://github.com/Nerdmaster/dmo-node.git
    ```
- Pull dockerhub image to be used by docker-compose
    - This assumes pull of the lastest image. Add a specific tag after the image name as needed.
    ```bash
    docker pull nerdmaster/dmo-node
        or
    docker pull nerdmaster/dmo-node:<tag>
    ```
- Update repo files to set proper configuration of container when starting
    - Update the image line of docker-compose.yml to the pulled tag as listed by docker images
        ```bash
        cd dmo-node
        vi docker-compose.yml
        ```
        - Update this line
            ```
            image: nerdmaster/dmo-node:<tag>
            ```
    - Copy docker-compose.override-example.yml to docker-compose.override.yml
        ```bash
        cp docker-compose.override-example.yml docker-compose.override.yml
        ```
        - Update the environment lines in docker-compose.override-example.yml and rename file to docker-compose.override.yml
            ```bash
            vi docker-compose.override.yml
            ```
            - Update these lines to suitable values for personal solo mining
                ```
                - RPC_USER=<user>
                - RPC_PASS=<password>
                ```
- Start up node container with command issued from repo directory with detached option
    ```bash
    docker-compose up -d
    ```
- Monitor node status by view the logs
    ```bash
    docker-compose logs -f node
    ```

### Linode stuff
If docker is installed via snap above, the binary will reside in a different location than what is referred to in the dmo-node.service file. There are different ways to update this, but symbolic links work well enough.

- Symlink the snap binary for docker-compose to the /usr/local/bin/ directory
    ```bash
    ln -s /snap/bin/docker-compose /usr/local/bin/
    ```
- Symlink the dmo-node repo directory to /opt as used by the dmo-node.service file
    ```bash while in the repo directory
    ln -s $(pwd) /opt/dmo-node
    ```
- Update the Required and After lines in the dmo-node.service file
    ```
    Requires=snap.docker.dockerd.service
    After=snap.docker.dockerd.service
    ```
