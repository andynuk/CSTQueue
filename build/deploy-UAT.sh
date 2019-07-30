#Deploy the package to UAT
echo "Name of Package Id"
echo ${PACKAGEID}

echo "Deploy the package to UAT..."
sfdx force:package:install -p ${PACKAGEID} -u UAT -w 10 -k rutland  
