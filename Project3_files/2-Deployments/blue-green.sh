#!/bin/bash
APP_DIR="/home/cloudshell-user/nd087-c3-deployment-roulette/starter/apps/blue-green"
echo "APP Directory:${APP_DIR}"
echo "Green deployment started"
sed 's/blue/green/g' ${APP_DIR}/blue.yml > ${APP_DIR}/green.yml
kubectl apply -f ${APP_DIR}/green.yml
while [ $(kubectl get pods -n udacity | grep -c green) -ne $(kubectl get pods -n udacity | grep -c blue) ]
do
	echo "Waiting for Green deployment to complete"
	sleep 1
done
echo "Green deployment complete"
