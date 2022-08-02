# How to create a tekton environment

# Install minikube
```sh
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

# Install kubectl
```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
```

# Install tekton cli
```sh
curl -OL https://github.com/tektoncd/cli/releases/download/v0.24.0/tkn_0.24.0_Linux_x86_64.tar.gz
sudo tar xvzf tkn_*_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn
```

# Start minikube
```sh
minikube start
```

# Install tekton pipeline
```sh
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

# Install git-clone task
```sh
tkn hub install task git-clone
```
