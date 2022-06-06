#! /usr/bin/bash

function set_variables {
  NUM_OF_REPLICAS=1
  NUM_V1_PODS=$(kubectl get pods -n udacity |grep -c canary-v1)
  NUM_V2_PODS=$(kubectl get pods -n udacity |grep -c canary-v2)
  NUM_OF_ATTEMPTS=0
  CANARY_APP_DIR="/home/cloudshell-user/nd087-c3-deployment-roulette/starter/apps/canary"
  HOME_DIR=$(echo $HOME)
}

function verify_deployment {
  echo "Starting $NUM_OF_REPLICAS Canary Deployment"
  read -p "Do you want to continue? (Y/N): " REPLY
  
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      echo "Deploying $NUM_OF_REPLICAS replica(s)..."
    else
      exit
    fi
}

function display_current_deployment_status {
  echo "Current Deployment Status"
  echo ""
  echo "    V1 Pods: $NUM_V1_PODS"
  echo " "
  echo "    V2 Pods: $NUM_V2_PODS"
  echo " "
}

function initialize_deployment {
  kubectl apply -f $CANARY_APP_DIR/canary-v2.yml
  sleep 1
}

function canary_deployment {
  kubectl scale deployment canary-v2 --replicas=$NUM_V1_PODS
}

function check_deployment_status {
DEPLOY_ATTEMPTS=0

RO_STATUS_CMD="kubectl rollout status deployment/canary-v2 -n udacity"
until $RO_STATUS_CMD || [ DEPLOY_ATTEMPTS -eq 30 ]; do
  $RO_STATUS_CMD
  DEPLOY_ATTEMPTS=$((DEPLOY_ATTEMPTS + 1))
  sleep 1
done
echo "Canary deployment SUCCESSFUL. $NUM_v2_PODS canary-v2 replicas are deployed"
}


## main start here
clear
set_variables
display_current_deployment_status
if [[ $NUM_V1_PODS -gt 0 ]]
then
  verify_deployment
  initialize_deployment
  canary_deployment
  check_deployment_status
  display_current_deployment_status
  echo "Canary Deployment Done."
else
  echo "There are no canary-v1 deployments to match"
  exit 
fi

