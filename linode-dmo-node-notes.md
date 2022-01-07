# Linode-dmo-node-notes

Some notes on the process of spinning up a Dynamo node using docker and Merdball's dmo-node repo/dockerhub image:

repo: https://github.com/Nerdmaster/dmo-node
docker image: https://hub.docker.com/r/nerdmaster/dmo-node

### IMPORTANT FIREWALL STUFF
It seems that any Linode instance created has all ports allowed **INBOUND** and OUTBOUND by **DEFAULT** aside from any host firewall that may be subsequently installed/configured on the instance. From a security standpoint, this is generally bad. Prior to creating any Linode instance, it is highly suggested to create a Linode firewall via the web console. They are included in the service free of charge and can be associated with any subsequently created Linode instances.

When a firewall is created, the default inbound policy is **ACCEPT**. Again, it is suggested to set the default inbound policy to **DROP** after which rules may be added to accept traffic on specific ports or from specific addresses. There are drop-downs in the rule configuration interface for common values in the port and address fields.
##### Some Suggested Rules:
- Allow full-node traffic from DMO network
    - 6432/tcp from all
- Allow SSH from your home public IP address
    - 22/tcp from <ip address/32>
- Allow miner traffic to RPC listener for solo mining
    - 6433/tcp from <ip address/32>

Once the firewall is created with rules configured, Linode instances can be added to the firewall from the Linodes tab after clicking on the firewall name. As mentioned in help tips, a Linode instance can only be associated to one firewall. It may be suggested to set up another default firewall for assocation without the full-node traffic allowance while initially setting up the Docker container and/or completing needed system updates on a freshly-provisioned instance.

### Linode instance creation basic process flow
There's plenty of help on the Linode site on how to generally create an instance. These steps are specific to the setup of Docker/Docker-Compose and the repos/images needed for the dmo-node container.

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

### Linode instance docker-compose details
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
