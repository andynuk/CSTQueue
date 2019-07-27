#Install dependencies, SFDX CLI in this case
echo "Installing Dependencies... "
sudo npm install -global sfdx-cli

echo "Installing jq to read json... "
sudo apt-get install jq

echo "Installing plugins... "
echo y |sfdx plugins:install https://github.com/Accenture/sfpowerkit -f

