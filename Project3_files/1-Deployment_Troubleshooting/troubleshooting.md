Troubleshooting steps for Hello World
I'm adding this in lieu of the before screenshot.  
The rubric does not call for the screen shot, so I did take one of the log errors.

Troubleshooting steps for Hello World app:
1.  Use the command  "kubectl logs <hello_world_pod_name>"
     - the health check fails and return 500 error indicating the end point is not reachable
     - and something is wrong on the internal web server
     - log show that failed health check you want to ping /healthz, indicating a fault health check path
2. corrected the health check path
3. redeploy the hello-world application
4. then run the log command again, see screenshot 
