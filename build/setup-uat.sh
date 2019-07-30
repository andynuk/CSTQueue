# Get the private key from the environment variable
echo "Setting up UAT Connection..."
mkdir uatkeys
echo $SFDC_SERVER_KEY | base64 -d > uatkeys/server.key

# check what we are authorised to connect to 
#echo "Listing orgs we are authorised to..."
#sfdx force:auth:list

# Authenticate to salesforce
echo "Authenticating..."
sfdx force:auth:jwt:grant --instanceurl https://test.salesforce.com --clientid $CONSUMERKEYUAT --jwtkeyfile uatkeys/server.key --username $SFDC_UAT_USER  -a UAT 
 
echo "New listing orgs we are authorised to..."
sfdx force:auth:list