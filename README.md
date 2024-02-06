https://blog.kubesimplify.com/getting-started-with-kind-creating-a-multi-node-local-kubernetes-cluster
https://mcvidanagama.medium.com/set-up-a-multi-node-kubernetes-cluster-locally-using-kind-eafd46dd63e5




kind create cluster --config my-k8s-cluster-config.yml
docker pull kindest/node:v1.25.3
kind delete cluster --name my-k8s-cluster


docker ps
docker exec -it c04633be10fd /bin/bash


kubectl get nodes
kubectl cluster-info
kubectl cluster-info --context kind-my-k8s-cluster

kubectl config get-contexts
kubectl config use-context <context-name>
kubectl cluster-info --context <context-name>
kind delete cluster --name <context-name>



# forbidden: User \"system:anonymous\" cannot get path \"/\"
# https://stackoverflow.com/questions/45094665/user-systemanonymous-cannot-get-path
kubectl proxy
http://127.0.0.1:8001

kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous



# Deploy app
# https://amdocs-1.gitbook.io/kubernetes-handbook/installation-and-running-mac-os/running-hello-world-application
kubectl apply -f helloworld.yml


# https://www.baeldung.com/ops/kubernetes-list-every-pod-node
kubectl get pods -o wide




# Ingress with KIND
https://kind.sigs.k8s.io/docs/user/ingress#ingress-nginx
https://www.baeldung.com/ops/kubernetes-kind

kubectl apply -f hello-service.yml
kubectl get services
curl localhost/hello


# Kubernetes dashboard
https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
https://stackoverflow.com/questions/72481655/creating-a-kubernetes-dashboard-token
kubectl apply -f service-account.yml
kubectl apply -f cluster-role-binding.yml

cd C:\Users\TO11RC\OneDrive - ING\miel\kubectl
kubectl version --output=json
kubectl -n kubernetes-dashboard create token admin-user

kubectl proxy
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/