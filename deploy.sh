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

if [ -z "$OKTA_TOKEN" ]; then
  echo "No OKTA_TOKEN variable set"
  exit
fi

if [ -z "$OKTA_DOMAIN" ]; then
  echo "No OKTA_DOMAIN variable set"
  exit
fi

add_role_to_service_account() {
  local role=$1
  gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role="$role"
}

TOKEN=$(gcloud auth print-access-token)

gcloud iam service-accounts create "$SERVICE_ACCOUNT_NAME" --project "$PROJECT_ID"

add_role_to_service_account "roles/apigee.admin" #Apigee Organization Admin
add_role_to_service_account "roles/integrations.integrationInvoker" #Application Integration Invoker

TRIGGER_NAME=apigee-app-sync
TOPIC_NAME=$(gcloud eventarc triggers describe $TRIGGER_NAME --location global --project $PROJECT_ID --format=json | jq -r '.transport.pubsub.topic | split("/") | last' -r)

cp -r integration/local integration/dev
cp -r integration/src integration/src_bkup

sed -i "s/SERVICE_ACCOUNT_NAME/$SERVICE_ACCOUNT_NAME/g" integration/dev/authconfigs/apigee-int-svc-account.json
sed -i "s/PROJECT_ID/$PROJECT_ID/g" integration/dev/authconfigs/apigee-int-svc-account.json
sed -i "s/OKTA_TOKEN/$OKTA_TOKEN/g" integration/dev/authconfigs/okta-token.json
sed -i "s/OKTA_DOMAIN/$OKTA_DOMAIN/g" integration/dev/config-variables/app-event-config.json
sed -i "s/PROJECT_ID/$PROJECT_ID/g" integration/dev/overrides/overrides.json
sed -i "s/TOPIC_NAME/$TOPIC_NAME/g" integration/dev/overrides/overrides.json
sed -i "s/PROJECT_ID/$PROJECT_ID/g" integration/src/app-event.json
sed -i "s/SERVICE_ACCOUNT_NAME/$SERVICE_ACCOUNT_NAME/g" integration/src/app-event.json
sed -i "s/TOPIC_NAME/$TOPIC_NAME/g" integration/src/app-event.json

echo "Installing integrationcli"
curl -L https://raw.githubusercontent.com/GoogleCloudPlatform/application-integration-management-toolkit/main/downloadLatest.sh | sh -
export PATH=$PATH:$HOME/.integrationcli/bin

integrationcli prefs set --reg=$REGION --proj=$PROJECT_ID --token=$TOKEN

echo "Publishing the integration"
integrationcli integrations apply -f integration/. \
 -e dev --sa $SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com  \
 --grant-permission --wait

 rm -rf integration/dev integration/src

 mv integration/src_bkup integration/src