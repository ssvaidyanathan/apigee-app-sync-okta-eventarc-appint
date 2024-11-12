# apigee-app-sync-okta-eventarc-appint
Demo to sync Apigee App credentials to Okta using EventArc and App Integration


## Steps to run

1) Create the Eventarc trigger pointing to a helloworld Cloud Run service (us-docker.pkg.dev/cloudrun/container/hello)
2) Once the trigger is creted, check the topic created and take a note of the the topic name
3) Open env.sh and provide all the details
4) Run `source env.sh`
5) Run `./deploy.sh`
6) This should create a service account, assign roles to it and then publish the integration 