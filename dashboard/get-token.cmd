@echo off
cd "C:\Users\TO11RC\OneDrive - ING\miel\kubectl"
.\kubectl -n kubernetes-dashboard create token admin-user
pause
exit