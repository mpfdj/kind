# bwce-docker
https://github.com/TIBCOSoftware/bwce-docker



minikube delete --all

minikube start --cpus=4 --memory 20480 --disk-size "40g" ^
--driver=docker ^
--addons storage-provisioner ^
--embed-certs


# Generate and copy kubectl config
windows> kubectl config view --flatten >config
wsl> cp config ~/.kube


# Install TIBCO Control plane on Minikube
https://github.com/TIBCOSoftware/platform-provisioner.git
https://github.com/TIBCOSoftware/platform-provisioner/blob/main/docs/recipes/k8s/on-prem/minikube.md

Run wsl as Administrator
apt install yq
export PIPELINE_INPUT_RECIPE="docs/recipes/tests/test-container-binaries.yaml"
./dev/platform-provisioner.sh


# Upgrade tekton to latest
https://tekton.dev/docs/installation/
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml




kubectl create namespace tekton-tasks
kubectl get namespaces


helm upgrade -i helm-install charts/helm-install -f charts/helm-install/values.yaml







# Local helm install
https://github.com/TIBCOSoftware/tp-helm-charts

helm install tibco-cp charts/platform-bootstrap -f charts/platform-bootstrap/values.yaml --namespace tibco-control-plane --create-namespace
helm dependency build charts/platform-bootstrap

helm install tibco-cp charts/platform-base -f charts/platform-base/values.yaml --namespace tibco-control-plane
helm dependency build charts/platform-base

helm upgrade -i helm-install charts/helm-install -f charts/helm-install/values.yaml -n tekton-tasks



# Below steps are not required
https://stackoverflow.com/questions/62232137/unable-to-read-client-cert-and-client-key-when-trying-to-run-kubectl-get-pods-wi
minikube start --embed-certs

alias kubectl="cmd.exe /c kubectl"
alias helm="cmd.exe /c helm"

sudo cp /mnt/c/Users/TO11RC/.minikube/profiles/minikube/*.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates





# ----------------------------------------
# TIBCO Zoom session (Chenghao Chen)
# ----------------------------------------
Upgrade Docker Desktop to latest
Enable kind in Kubernetes Settings (1 node)

copy .kube/config from Windows host to WSL

kubectl get node
kubectl get pods -A

cd "/mnt/c/Users/TO11RC/OneDrive - ING/miel/workspace/bwce/platform-provisioner"

export PIPELINE_INPUT_RECIPE="docs/recipes/tests/test-local.yaml"
./dev/platform-provisioner.sh

kubectl get storageclass

export PIPELINE_INPUT_RECIPE="docs/recipes/tp-base/tp-base-on-prem.yaml"
./dev/platform-provisioner.sh



# Access to tibco platform dataplane
company subscription
activate subscription




# Kubernetes Dashboard
https://github.com/kubernetes/dashboard
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

kubectl get serviceAccounts
kubectl -n kubernetes-dashboard create token default


# Windows Docker Desktop - Kubernetes Dashboard - no data on pods is shown OR access is forbidden
https://stackoverflow.com/questions/75842692/windows-docker-desktop-kubernetes-dashboard-no-data-on-pods-is-shown-or-acce

touch k8s-dashboard-admin.yml
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: dashboard-admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: default
  namespace: kubernetes-dashboard


# Use cgroup v2 (warning shows in control-plane node)
touch C:\Users\TO11RC\.wslconfig

[wsl2]
memory=28GB
kernelCommandLine=cgroup_no_v1=all



kubectl create deployment bwce-http-app -o yaml --image=bwce-http-app:latest --dry-run=client > deployment.yml
kubectl create service loadbalancer bwce-http-app-service -o yaml --tcp=8080:8080 --dry-run=client > service.yml


kubectl apply -f deployment.yml --server-side

kubectl get pods
kubectl describe pod bwce-http-app-766465c4d-gcldv




kind get clusters
kind create cluster

# We need to create the Kind cluster manually and not via Docker Desktop because else the containerd binary is missing
kind create cluster --config .\kind-cluster.yml

# Load image in Kind cluster
kind get clusters
kind load docker-image bwce-http-app:latest --name kind
crictl images

# Install Ingress
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml

# Create a proxy for Ingress
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8080:80

# Get logs
kubectl get pods
kubectl logs <pod>
kubectl -n ingress-nginx get services

# Restart Ingress, do so by deleting it will automatically be re-created by the cluster
kubectl delete pod -n ingress-nginx -l app.kubernetes.io/component=controller

# Debugging Ingress
kubectl get pods -n ingress-nginx
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller
kubectl get ingress
kubectl get endpoints