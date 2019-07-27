#Install dependencies, SFDX CLI in this case
echo "Installing Dependencies... "
sudo npm install -global sfdx-cli
echo "Installing plugins... "
#sfdx plugins:install https://github.com/Accenture/sfpowerkit -f
npm i sfpowerkit
