@echo off

:: Install k8s cluster
kind create cluster --config my-k8s-cluster-config.yml

:: Install Ingress
:: https://kind.sigs.k8s.io/docs/user/ingress#ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

:: Install dashboard
:: https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f .\dashboard\service-account.yml
kubectl apply -f .\dashboard\cluster-role-binding.yml

:: Start dashboard
start cmd.exe /k kubectl proxy
start http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
start cmd.exe /k .\dashboard\get-token.cmd
