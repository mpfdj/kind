@echo on
kubectl delete ingress helloworld-ingress
kubectl delete service helloworld-service
kubectl delete deployment helloworld-app
