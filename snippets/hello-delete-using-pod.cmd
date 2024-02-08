@echo on
kubectl delete ingress hello-ingress
kubectl delete service hello-service
kubectl delete pod hello-app
