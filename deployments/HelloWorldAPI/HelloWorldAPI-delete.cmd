@echo on
kubectl delete ingress helloworld-api-ingress
kubectl delete service helloworld-api-service
kubectl delete deployment helloworld-api-app
