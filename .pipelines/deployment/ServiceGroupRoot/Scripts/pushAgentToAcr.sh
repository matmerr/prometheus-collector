#!/bin/bash
set -e

if [ $STEP_NAME == "PushKSMChart" ] && [ $PUSH_NEW_KSM_CHART == "false" ]; then
  echo "Skipping pushing KSM Chart"
  exit 0
fi

if [ $STEP_NAME == "PushNEChart" ] && [ $PUSH_NEW_NE_CHART == "false" ]; then
  echo "Skipping pushing NE Chart"
  exit 0
fi

if [ -z $IMAGE_TAG ]; then
  echo "-e error value of IMAGE_TAG variable shouldnt be empty. Check release variables"
  exit 1
fi

if [ -z $MCR_REGISTRY ]; then
  echo "-e error MCR_REGISTRY shouldnt be empty. Check release variables"
  exit 1
fi

if [ -z $PROD_MCR_REPOSITORY ]; then
  echo "-e error PROD_MCR_REPOSITORY shouldnt be empty. Check release variables"
  exit 1
fi

if [ -z $DEV_MCR_REPOSITORY ]; then
  echo "-e error value of DEV_MCR_REPOSITORY shouldn't be empty. Check release variables"
  exit 1
fi

if [ -z $ACR_REGISTRY ]; then
  echo "-e error value of ACR_REGISTRY shouldn't be empty. Check release variables"
  exit 1
fi

if [ -z $PROD_ACR_REPOSITORY ]; then
  echo "-e error value of PROD_ACR_REPOSITORY shouldn't be empty. Check release variables"
  exit 1
fi

echo "Done checking that all necessary variables exist."

# Login to az cli and authenticate to acr
echo "Login cli using managed identity"

# Retries needed due to: https://stackoverflow.microsoft.com/questions/195032
n=0
signInExitCode=-1
until [ "$n" -ge 5 ]
do
   az login --identity && signInExitCode=0 && break
   n=$((n+1))
   sleep 15
done

if [ $signInExitCode -eq 0 ]; then
  echo "Logged in successfully"
else
  echo "-e error failed to login to az with managed identity credentials"
  exit 1
fi

PROD_ACR_REPOSITORY_WITHOUT_SLASH="${PROD_ACR_REPOSITORY:1}"
echo "Pushing ${PROD_ACR_REPOSITORY_WITHOUT_SLASH}:${IMAGE_TAG} to ${ACR_REGISTRY}"
az acr import --name $ACR_REGISTRY --source ${MCR_REGISTRY}${DEV_MCR_REPOSITORY}:${IMAGE_TAG} --image ${PROD_ACR_REPOSITORY_WITHOUT_SLASH}:${IMAGE_TAG}
if [ $? -eq 0 ]; then
  echo "Retagged and pushed image successfully"
else
  echo "-e error failed to retag and push image to destination ACR"
  exit 1
fi