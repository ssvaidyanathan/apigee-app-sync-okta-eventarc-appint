# apigee-app-sync-okta-eventarc-appint
Demo to sync Apigee App credentials to Okta using EventArc and App Integration


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