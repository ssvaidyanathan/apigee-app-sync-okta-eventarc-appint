#!/bin/bash

# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ -z "$PROJECT_ID" ]; then
  echo "No PROJECT_ID variable set"
  exit
fi

if [ -z "$REGION" ]; then
  echo "No REGION variable set"
  exit
fi

if [ -z "$SERVICE_ACCOUNT_NAME" ]; then
  echo "No SERVICE_ACCOUNT_NAME variable set"
  exit
fi

remove_role_from_service_account() {
  local role=$1
  gcloud projects remove-iam-policy-binding "$PROJECT_ID" \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role="$role"
}

echo "Installing integrationcli"
curl -L https://raw.githubusercontent.com/GoogleCloudPlatform/application-integration-management-toolkit/main/downloadLatest.sh | sh -
export PATH=$PATH:$HOME/.integrationcli/bin

integrationcli prefs set --reg=$REGION --proj=$PROJECT_ID --token=$TOKEN

echo "Deleting the integration"
integrationcli integrations delete --name apigee-okta-sync

echo "Deleting the Auth Profiles"
integrationcli authconfigs delete --name okta-token
integrationcli authconfigs delete --name apigee-int-svc-account

echo "Deleting the Eventarc Trigger"
TRIGGER_NAME=apigee-app-sync
gcloud eventarc triggers delete $TRIGGER_NAME --location=global --project=$PROJECT_ID

echo "Deleting the Cloud Run Service"
SERVICE_NAME=dummy-hello
gcloud run services delete $SERVICE_NAME --region=$REGION --project=$PROJECT_ID --quiet

echo "Removing assigned roles from Service Account"
remove_role_from_service_account "roles/integrations.integrationInvoker"
remove_role_from_service_account "roles/apigee.admin"
remove_role_from_service_account "roles/pubsub.editor"

echo "Deleting Service Account"
gcloud iam service-accounts delete "${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" --project "$PROJECT_ID" --quiet
