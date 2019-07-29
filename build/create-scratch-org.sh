#!/bin/sh

# Get the private key from the environment variable
echo "Setting up DevHub Connection..."
mkdir keys
echo $SFDC_SERVER_KEY | base64 -d > keys/server.key



# Authenticate to salesforce
echo "Authenticating..."
RES=$(sfdx force:auth:jwt:grant --clientid $SFDC_PROD_CLIENTID --jwtkeyfile keys/server.key --username $SFDC_PROD_USER --setdefaultdevhubusername -a DevHub --json)
SFDC_AUTHENTICATE_ID=$(echo ${RES} | jq --raw-output .result.orgId) 
echo "OrgId..."
echo ${SFDC_AUTHENTICATE_ID}

#Create a scratch org
echo "Name of Scratch Org"
echo ${CIRCLE_BRANCH}

echo "Creating the Scratch Org..."
RES=$(sfdx force:org:create -f config/project-scratch-def.json -a ${CIRCLE_BRANCH} -s -d 1 --json) 

#Create org wide email address
echo "Create org email address... "
SFDC_CREATE_EMAIL=$(sfdx  sfpowerkit:org:orgwideemail:create -e test@example.com -n TestEmail -p -u ${CIRCLE_BRANCH} --json)
SFDC_EMAIL_ID=$(echo $SFDC_CREATE_EMAIL| jq --raw-output .result.id) 

echo "reading email id created"
echo ${SFDC_EMAIL_ID}

echo "Valiate org email address... "
RES=$(sfdx sfpowerkit:org:orgwideemail:verify -i ${SFDC_EMAIL_ID} -u ${CIRCLE_BRANCH})
echo ${RES}

