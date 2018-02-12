#!/bin/bash

# Check usage
if [ "$#" -ne 2 ]; then
    echo "Invalid Usage"
    echo "Correct usage $0 <name_of_scratch_org> <object type> "
    echo "Use command sfdx force:org:list to display all orgs you have"
    echo "If you want to create a new org - use $0 <name_of_scratch_org_to_create>"
    exit 1
fi
log=soqlresults.json
payroll_cloud_user_alias=$1
objectType=$2

echo "Checking that Field Mapping for $objectType has been created..."
installCheck=true
counter=0

while ($installCheck) ;
do
    echo "Querying for metadata..."
    sfdx force:data:soql:query -q "SELECT DeveloperName FROM SOB_CFG_Field_Mapping__mdt WHERE Object_Type__c = '$objectType'" -u $payroll_cloud_user_alias --json > $log
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        echo "Unable to query for provider"
        exit 1
    fi

    echo "Checking record exists..."
    if node checksoql.js $log
    then
        echo "Field Mapping not ready"
        ((counter++))

        if [ $counter -ge 3 ]; then
            echo "Giving up waiting for metadata deployment of $objectType for Field Mapping"
            exit 1
        fi
        sleep 10
    else
        installCheck=false
    fi
done

rm soqlresults.json
