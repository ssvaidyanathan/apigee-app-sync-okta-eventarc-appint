# apigee-app-sync-okta-eventarc-appint

---

Demo to sync Apigee App credentials to Okta using EventArc and App Integration

## Pre-Requisites

1. [Provision Apigee X](https://cloud.google.com/apigee/docs/api-platform/get-started/provisioning-intro) and configure [external access](https://cloud.google.com/apigee/docs/api-platform/get-started/configure-routing#external-access) for API traffic to your Apigee X instance
2. [Provision Application Integration](https://cloud.google.com/application-integration/docs/setup-application-integration)
3. An [Okta instance](https://developer.okta.com) and the [Okta Token](https://help.okta.com/en-us/content/topics/security/api.htm?cshid=ext-create-api-token#create-okta-api-token) required to call the Okta APIs

Let's get started!

---

## Setup environment

Ensure you have an active GCP account selected in the Cloud shell

```sh
gcloud auth login
```

Edit the provided sample `env.sh` file, and set the environment variables there.

Click <walkthrough-editor-open-file filePath="env.sh">here</walkthrough-editor-open-file> to open the file in the editor

Then, source the `env.sh` file in the Cloud shell.

```sh
source ./env.sh
```

---

## Deploy Cloud Run service

Enable the services

```sh
gcloud services enable pubsub.googleapis.com run.googleapis.com eventarc.googleapis.com --project $PROJECT_ID

```

Now, lets deploy the Cloud Run Service

```sh
SERVICE_NAME=dummy-hello
gcloud run deploy $SERVICE_NAME --image=us-docker.pkg.dev/cloudrun/container/hello \
    --region $REGION --project $PROJECT_ID --no-allow-unauthenticated
```

---

### Configure Eventarc trigger

Eventarc Event Receiver Permission to the default service account

```sh

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --member="serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com" \
    --role="roles/eventarc.eventReceiver"
```

Configure Event Arc Trigger

```sh
TRIGGER_NAME=apigee-app-sync
gcloud eventarc triggers create $TRIGGER_NAME \
--destination-run-service=$SERVICE_NAME \
--location=global \
--project=$PROJECT_ID \
--destination-run-region=$REGION \
--event-filters="type=google.cloud.audit.log.v1.written" \
--event-filters="serviceName=apigee.googleapis.com" \
--event-filters="methodName=google.cloud.apigee.v1.DeveloperApps.CreateDeveloperApp" \
--service-account=$PROJECT_NUMBER-compute@developer.gserviceaccount.com
```

---

## Deployment

In your GCP console, go to IAM and then select the "Include Google-provided role grants" check box and look for `service-PROJECT_NUMBER@gcp-sa-integrations.iam.gserviceaccount.com` and assign the Pub/Sub Editor Role

Next, let's deploy the sample. Just run

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

## Cleanup

To clean up all the resources

```sh
source env.sh
./cleanup.sh
```
