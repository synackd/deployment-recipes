# OpenCHAMI Quickstart

## Dependencies

The OpenCHAMI services themselves are all containerized and tested running under `docker compose`.  It should be possible to run OpenCHAMI services on any system with docker installed.

This quickstart makes a few assumptions about the target operating system and is only tested on Rocky Linux 9.3 running on x86 processors.  Feel free to file bugs about other configurations, but we will prioritize support for systems that we can directly test at LANL.

### Assumptions

* Linux - The quickstart automation makes several assumptions about the behavior Unix tools and their operation under bash from Rocky Linux 9.3
* x86_64 - Some of the containers involved are built and tested for alternative operating systems and architectures, but the solution as a whole is only tested with x86 containers
* Dedicated System - The docker compose setup assumes that it can take control of several TCP ports and interact with the host network for DHCP and TFTP.  It is tested on a dedicated virtual machine
* Local Name Registration - The quickstart bootstraps a Certificate Authority and issues an SSL certificate with a predictable name.  For access, you will need to add that name/IP to /etc/hosts on all clients or make it resolvable through your site DNS

## Start Here

1. Clone the repository and switch to that directory
   ```bash
   git clone https://github.com/OpenCHAMI/deployment-recipes.git
   cd deployment-recipes/quickstart/
   ```
1. Create the secrets file and choose a name for your system.  We use `foobar` in our example.
    - __Note__ The certificates for the system use the name you provide in this file.  It's not easy to change.
    - __Note__ The script attempts to figure out which ip address is most likely to be your system ip.  If it is unsuccessful, `LOCAL_IP=` will be empty and you'll need to update it manually
    - __Note__ The full url will be https://foobar.openchami.cluster which you should set manually in /etc/hosts and point to the same ip address as `LOCAL_IP` in `.env`.
    - __Note__ The `generate-configs.sh` script accepts an optional second argument that allows a custom domain to be specified. If not specified, it defaults to "openchami.cluster", which is used throughout these instructions.
   
   ```bash
   # Create the secrets in the .env file.  Do not share them with anyone. 
   ./generate-configs.sh foobar
   # Confirm that LOCAL_IP has a value and matches what you want the interface to OpenCHAMI to be. We do our best to guess what your primary interface is.
   grep LOCAL_IP .env
   ```
   If you have problems with this step, check to make sure that the main IP address of your host is in `.env` as `LOCAL_IP`.
1. Update your /etc/hosts to point your system name to your local ip (this is important for valid certs)
1. Start the main services
   ```bash 
   docker compose -f base.yml -f postgres.yml -f jwt-security.yml -f haproxy-api-gateway.yml -f  openchami-svcs.yml -f autocert.yml up -d
   ```
   __If this step produces an error like: `Error response from daemon: invalid IP address in add-host: ""` it means you're missing the LOCAL_IP in step 2.__
   You can fix it by destroying everything, editing `.env` manually and starting over.  The command to destroy is the same as the command to create, just replace `up -d` with `down --volumes`
   
1. Use the running system to download your certs and create your access token(s)
   ```bash
   # Assuming you're using bash as your shell, you can use the included functions to simplify interactions with your new OpenCHAMI system.
   source bash_functions.sh
   # Download the root ca so you can validate the ssl certificates included with your system
   get_ca_cert > cacert.pem
   # Create a jwt access token for use with the apis.
   ACCESS_TOKEN=$(gen_access_token)
   # If you're curious about that token, you can safely copy and paste it into https://jwt.io to learn more.
   # Use curl to confirm that everything is working
   curl --cacert cacert.pem -H "Authorization: Bearer $ACCESS_TOKEN" https://foobar.openchami.cluster/hsm/v2/State/Components
   # This should respond with an empty set of Components: {"Components":[]}
   ```
1. Create a token that can be used by the dnsmasq-loader which reads from smd.  This activates our automatic dns/dhcp system.  The command automatically adds it to .env
   ```bash
    echo "DNSMASQ_ACCESS_TOKEN=$(gen_access_token)" >> .env
    ```
1. Use docker-compose to bring up your dnsmasq contianers.  The only difference between this command and the one above is the addition of the `dnsmasq.yml` file.  Docker compose needs to know about all the files to follow dependencies.
   ```bash
   docker compose -f base.yml -f postgres.yml -f jwt-security.yml -f haproxy-api-gateway.yml -f openchami-svcs.yml -f autocert.yml -f dnsmasq.yml up -d
   ```


## cloud-init Server Setup

OpenCHAMI utilizes the cloud-init platform for post-boot configuration.
A custom cloud-init server container is included with this quickstart Docker Compose setup, but must be populated prior to use.

The cloud-init server provides two API endpoints, described in the sections below.
Choose the appropriate option for your needs.

### Unprotected Data

#### Setup
The first endpoint, located at `/cloud-init/`, permits access to all stored data (and should therefore not contain configuration secrets).
Storing data into this endpoint is accomplished via HTTP POST requests containing JSON-formatted cloud-init configuration details.
For example:
```bash
curl 'https://foobar.openchami.cluster/cloud-init/' \
    -X POST \
    -d '{"name": "IDENTIFIER", "cloud-init": {
        "userdata": {
            "write_files": [{"content": "hello world", "path": "/etc/hello"}]
        },
        "metadata": {...},
        "vendordata": {...}
    }}'
```
`IDENTIFIER` can be:
- A node MAC address
- A node xname
- An SMD group name
It may be easiest to add nodes to a group for testing, and upload a cloud-init configuration for that group to this server.

#### Usage
Data is retrieved via HTTP GET requests to the `meta-data`, `user-data`, and `vendor-data` endpoints.
For example, one could download all cloud-init data for a node/group via `curl 'https://foobar.openchami.cluster/cloud-init/<IDENTIFIER>/{meta-data,user-data,vendor-data}'`.

When retrieving data, `IDENTIFIER` can also be omitted entirely (e.g. `https://foobar.openchami.cluster/cloud-init/user-data`).
In this case, the cloud-init server will attempt to look up the relevant xname based on the request's source IP address.

Thus, the intended use case is to set nodes' cloud-init datasource URLs to `https://foobar.openchami.cluster/cloud-init/`, from which the cloud-init client will load its configuration data.
Note that in this case, no `IDENTIFIER` is provided, so IP-based autodetection will be performed.

### JWT-Protected Data

#### Setup
The second endpoint, located at `/cloud-init-secure/`, restricts access to its cloud-init data behind a valid bearer token (i.e. a JWT).
Storing data into this endpoint requires a valid access token, which we assume is stored in `$ACCESS_TOKEN`.
The workflow described for unprotected data can be used, with the addition of the required authorization header, via e.g. `curl`'s `-H "Authorization: Bearer $ACCESS_TOKEN"`.

#### Usage
In order to access this protected data, nodes must also supply valid JWTs.
These may be distributed to nodes at boot time by including [`tpm-manager.yml`](tpm-manager.yml) in the `docker compose` command provided above.
(It should be provided last, since it supplements service definitions from other files.)

For nodes without hardware TPMs, the TPM manager will drop a JWT into `/var/run/cloud-init-jwt`.
The token can be retrieved and included with a request to the cloud-init server, using an invocation such as:
```bash
curl 'https://foobar.openchami.cluster/cloud-init-secure/<IDENTIFIER>/{meta-data,user-data,vendor-data}' \
    --create-dirs --output '/PATH/TO/DATA-DIR/#1' \
    --header "Authorization: Bearer $(</var/run/cloud-init-jwt)"
```
cloud-init (i.e. on the node) can then be pointed at `file:///PATH/TO/DATA-DIR/` as its datasource URL.

For nodes *with* hardware TPMs, the token will be dropped into the TPM's secure storage with `ownerread|ownerwrite` scope, and can be retrieved using the `tpm2_nvread` command.


## What's next?

### Refresh your certificates

This quickstart takes advantage of short lived certs and tokens.  To renew the certificate for your system, run these commands daily, perhaps with cron:

```bash
docker compose -f base.yml -f postgres.yml -f jwt-security.yml -f haproxy-api-gateway.yml -f openchami-svcs.yml -f autocert.yml  restart acme-register
sleep 5
docker compose -f base.yml -f postgres.yml -f jwt-security.yml -f haproxy-api-gateway.yml -f openchami-svcs.yml -f autocert.yml  restart acme-deploy
sleep 5
docker compose -f base.yml -f postgres.yml -f jwt-security.yml -f haproxy-api-gateway.yml -f openchami-svcs.yml -f autocert.yml  restart haproxy

```

## Helpful docker cheatsheet

This quickstart uses `docker compose` to start up services and define dependencies.  If you have a basic understanding of docker, you should be able to work with the included services.  Some handy items to remember for when you are exploring the deployment are below.


`docker volume list` This lists all the volumes.  If they exist, the project will try to reuse them.  That might not be what you want.
`docker network list` ditto for networks
`docker ps -a` the -a shows you containers that aren't running.  We have several containers that are designed to do their thing and then exit.
`docker logs <container-id>` allows you to check the logs of containers even after they have exited
`docker compose ... down --volumes` will not only bring down all the services, but also delete the volumes

## Going even further
