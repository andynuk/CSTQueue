# Get the private key from the environment variable
#echo "Setting up DevHub Connection..."
#mkdir keys
#echo $SFDC_SERVER_KEY | base64 -d > keys/server.key

# Authenticate to salesforce
#echo "Authenticating..."
#sfdx force:auth:jwt:grant --clientid $SFDC_PROD_CLIENTID --jwtkeyfile keys/server.key --username $SFDC_PROD_USER --setdefaultdevhubusername -a DevHub


#Delete a scratch org
echo "Name of Scratch Org to delete"
echo ${CIRCLE_BRANCH}
echo "Delete the Scratch Org..."
sfdx force:org:delete -p -u ${CIRCLE_BRANCH}
