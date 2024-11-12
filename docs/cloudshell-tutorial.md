# apigee-app-sync-okta-eventarc-appint

---

Demo to sync Apigee App credentials to Okta using EventArc and App Integration

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

Let's get started!

---

## Setup environment

Ensure you have an active GCP account selected in the Cloud shell

```sh
gcloud auth login
```

Navigate to the 'apigee-app-sync-okta-eventarc-appint' directory in the Cloud shell.

```sh
cd apigee-app-sync-okta-eventarc-appint
```

Edit the provided sample `env.sh` file, and set the environment variables there.

Click <walkthrough-editor-open-file filePath="apigee-app-sync-okta-eventarc-appint/env.sh">here</walkthrough-editor-open-file> to open the file in the editor

Then, source the `env.sh` file in the Cloud shell.

```sh
source ./env.sh
```

---

## Deployment

Next, let's deploy the sample to Apigee. Just run

```bash
./deploy.sh
```
---

## Verification

You can test by creating an app in Apigee and see if its syncing into Okta

---

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You've successfully deployed a solution to sync the credentials from Apigee to Okta

<walkthrough-inline-feedback></walkthrough-inline-feedback>
