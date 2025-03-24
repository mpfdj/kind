@echo on
kubectl delete ingress bwce-http-app-ingress
kubectl delete service bwce-http-app-service
kubectl delete deployment bwce-http-app
