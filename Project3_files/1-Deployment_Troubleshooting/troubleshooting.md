Troubleshooting steps for Hello World APP

I'm adding this in lieu of the before screenshot.  
The rubric does not call for the screen shot, so I did not take one of the log errors.

Troubleshooting steps for Hello World app:
1.  Use the command  "kubectl logs <hello_world_pod_name>"
     - get nginx health check status return HTTP status 500 error the application is not reachable
     - something is wrong on the internal web server
     - log show that failed health check you want to ping /healthz, indicating a fault health check path
2. corrected the health check path in app/hello-world/hello.yml
3. redeploy the hello-world application using command "kubectl apply -f starter/apps/hello-world/hello.yml"
4. then run the log command again, see screenshot "p3_sc_tf_infra_success.png"
