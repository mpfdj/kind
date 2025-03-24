:: Kind homepage
:: https://kind.sigs.k8s.io/

:: Create Kind cluster
kind create cluster --config .\kind-cluster.yml

:: Install dashboard
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
kubectl apply -f k8s-dashboard-admin.yml

:: Install Ingress
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml

:: Start dashboard
timeout 30
start cmd.exe /k kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
start https://localhost:8443/
start cmd.exe /k get-token.cmd

:: Start a proxy for Ingress
:: TIBCO bwce app is available on http://localhost:8080/bwce
start cmd.exe /k kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8080:80
