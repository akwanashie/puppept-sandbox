## Testing Puppet Manifests

This follows [James Attard's tutorial](https://medium.com/swlh/install-puppet-server-on-docker-fe4a80cbe3be)

### Configure the Server + DB

- Start the stack

```bash
export DOMAIN=akwanashie && docker-compose up -d
```

- Copy manifests to puppet server

```bash
cp -r ../manifests/environments volumes/code
```

- Run the manifests against the server itself

```bash
docker exec -it puppetserver puppet agent -tv
```

- Point your browser to the PuppetDB Docker container: http://puppetDB:8080 to view analytics pertaining to your Puppet infrastructure.

### Configure the Agent

- The agent is installed in the `puppet-agent-dockerfile` using [this guide](https://puppet.com/docs/puppet/6.17/install_agents.html).

- Build the agent image

```bash
docker-compose build
```

- Configure an agent

```bash
docker exec -it puppetagent puppet ssl bootstrap
```

- Run the agent

```bash
docker exec -it puppetagent puppet agent -tv
```

### Shut Down

```bash
docker-compose down -v
rm -rf volumes postgres-custom
```