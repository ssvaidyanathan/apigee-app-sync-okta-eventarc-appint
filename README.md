# apigee-app-sync-okta-eventarc-appint
Demo to sync Apigee App credentials to Okta using EventArc and App Integration

## Pre-Requisites

1. GCP Project with access to create Pub/Sub, EventArc, CloudRun services
2. [Provision Apigee X](https://cloud.google.com/apigee/docs/api-platform/get-started/provisioning-intro) and configure [external access](https://cloud.google.com/apigee/docs/api-platform/get-started/configure-routing#external-access) for API traffic to your Apigee X instance
3. [Provision Application Integration](https://cloud.google.com/application-integration/docs/setup-application-integration)
4. An [Okta instance](https://developer.okta.com) and the [Okta Token](https://help.okta.com/en-us/content/topics/security/api.htm?cshid=ext-create-api-token#create-okta-api-token) required to call the Okta APIs

## (QuickStart) Setup using Cloud Shell

Use the following GCP Cloud Shell tutorial, and follow the instructions.

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/ssvaidyanathan/apigee-app-sync-okta-eventarc-appint&cloudshell_git_branch=main&cloudshell_workspace=.&cloudshell_tutorial=docs/cloudshell-tutorial.md)