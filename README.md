# apigee-app-sync-okta-eventarc-appint
Demo to sync Apigee App credentials to Okta using EventArc and App Integration


## Steps to run

1) Clone this repo `git clone https://github.com/ssvaidyanathan/apigee-app-sync-okta-eventarc-appint.git`
2) Run `cd apigee-app-sync-okta-eventarc-appint`
3) Create the Eventarc trigger pointing to a helloworld Cloud Run service (us-docker.pkg.dev/cloudrun/container/hello)
4) Once the trigger is creted, check the topic created and take a note of the the topic name
5) Open [env.sh](./env.sh) and provide all the details
6) Run `source env.sh`
7) Run `./deploy.sh`
8) This should create a service account, assign roles to it and then publish the integration 