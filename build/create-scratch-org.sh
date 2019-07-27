# Get the private key from the environment variable
echo "Setting up DevHub Connection..."
mkdir keys
echo $SFDC_SERVER_KEY | base64 -d > keys/server.key

# Authenticate to salesforce
echo "Authenticating..."
sfdx force:auth:jwt:grant --clientid $SFDC_PROD_CLIENTID --jwtkeyfile keys/server.key --username $SFDC_PROD_USER --setdefaultdevhubusername -a DevHub --json 


#Create a scratch org
echo "Name of Scratch Org"
echo ${CIRCLE_BRANCH}

echo "Creating the Scratch Org..."
sfdx force:org:create -f config/project-scratch-def.json -a ${CIRCLE_BRANCH} -s -d 1 --json 


#Create org wide email address
echo "Create org email address... "
SFDC_EMAIL_ID= $(sfdx  sfpowerkit:org:orgwideemail:create -e andynuk@gmail.com -n TestEmail -p -u ${CIRCLE_BRANCH} --json | jq --raw-output .result.id) 


echo "reading email id created"
echo $SFDC_EMAIL_ID

echo "Valiate org email address... "
sfdx sfpowerkit:org:orgwideemail:verify -i $SFDC_EMAIL_ID -u andynuk@gmail.com

echo "Delete the Scratch Org..."
sfdx force:org:delete -p -u ${CIRCLE_BRANCH}
