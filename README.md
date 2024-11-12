# apigee-app-sync-okta-eventarc-appint
Demo to sync Apigee App credentials to Okta using EventArc and App Integration

## (QuickStart) Setup using Cloud Shell

Use the following GCP Cloud Shell tutorial, and follow the instructions.

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/ssvaidyanathan/apigee-app-sync-okta-eventarc-appint&cloudshell_git_branch=main&cloudshell_workspace=.&cloudshell_tutorial=docs/cloudshell-tutorial.md)

## Pre-Requisites

1. [Provision Apigee X](https://cloud.google.com/apigee/docs/api-platform/get-started/provisioning-intro)
2. Configure [external access](https://cloud.google.com/apigee/docs/api-platform/get-started/configure-routing#external-access) for API traffic to your Apigee X instance
3. [Provision Application Integration](https://cloud.google.com/application-integration/docs/setup-application-integration)
4. Make sure the following tools are available in your terminal's $PATH (Cloud Shell has these preconfigured)
    - [gcloud SDK](https://cloud.google.com/sdk/docs/install)
    - [integrationcli](https://github.com/GoogleCloudPlatform/application-integration-management-toolkit)
    - unzip
    - curl
    - jq

## Steps to run

1) Clone this repo `git clone https://github.com/ssvaidyanathan/apigee-app-sync-okta-eventarc-appint.git`
2) Run `cd apigee-app-sync-okta-eventarc-appint`
3) Open [env.sh](./env.sh) and provide all the details
4) Run `source env.sh`
5) Run `./deploy.sh`
6) This should do the following:
   1) Create a service account and assign roles to it
   2) Deploy a dummy Cloud Run service
   3) Configure a EventArc pointing to the Cloud Run service
   4) Extract the Topic Name 
   5) Update the integration configurations and publish the integration 