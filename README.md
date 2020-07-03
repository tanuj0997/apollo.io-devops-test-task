# Apollo.io Devops Test Task
This is a monorepo for the test task provided by apollo.io

## Steps to Setup Webserver on Kubernetes
### 1. Setup enviroment
 - Install ansible 
 - Install terraform

### 2. Deploy flask Application with ansible and terraform

- Create compute Instance with terraform
  - Replace your details in terraform charts
    - `project = "{gcp_project_id}" (apollo-task-282212)`
    - `ssh-keys = "apollo:${file("{your_ssh_key}")}" (~/.ssh/apollo.pub)` 
    - `source_ranges = ["{your_ip}/32"](103.253.151.85/32)`

```bash
cd terraform
export GOOGLE_APPLICATION_CREDENTIALS={{path}}
terraform init
terraform apply -auto-approve
```
- Setup application with the help of ansible
  - Replace your details in hosts file and app.conf in ansible folder
    - Add your instance IP to hosts.yaml file (Instance_IP -> 35.184.201.35)
    - Add your ssh-key from previous step to `      ansible_ssh_private_key_file: {your_ssh_key} (~/.ssh/apollo)`
    - Add your instance IP to app.conf file `server_name 35.184.201.35(Instance_IP);
  `
```bash
cd ansible
ansible-playbook nginx_install.yaml -i hosts.yaml -u apollo
```  
### 3. Setup kubernetes cluster
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

### 4. Jenkins file 
- I have added a jenkins script from one of mine project for CI/CD setup of an application based on micro-service architecture 