@echo off
start cmd.exe /k kubectl proxy
start http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
start cmd.exe /k .\dashboard\get-token.cmd