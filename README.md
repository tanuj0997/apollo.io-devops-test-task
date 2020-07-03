# Apollo.io Devops Test Task
This is a monorepo for the test task provided by apollo.io

## Steps to Setup Webserver on Kubernetes

- Build Docker image
```bash
make IMAGE_NAME="webserver" build-webserver
```

- Login to docker
```bash
docker login -u <username> -p <password>
```

- Push the docker image
```bash
make IMAGE_NAME="webserver" push-webserver
```

- Install Kubernetes Helm chart for webserver
```bash
make install-webserver
```
