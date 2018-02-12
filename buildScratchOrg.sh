#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOUR='\033[0m'
ERROR_MARKER="${RED}[ERROR]${NO_COLOUR}"
SUCCESS_MARKER="${GREEN}[SUCCESS]${NO_COLOUR}"

# Initialize
payroll_cloud_user_alias=$1

# Check usage
if [ "$#" -ne 1 ]; then
    echo "Invalid Usage"
    echo "Correct usage $0 <name_of_scratch_org>"
    echo "Use command sfdx force:org:list to display all orgs you have"
    echo "If you want to create a new org - use $0 <name_of_scratch_org_to_create>"
    exit 1
fi

# Check create scratch org
echo "Creating scratch org with alias $payroll_cloud_user_alias.."
if sfdx force:org:create -f config/project-scratch-def.json -s -v DevHub -a "$payroll_cloud_user_alias"
then
    echo "Scratch org with alias $payroll_cloud_user_alias created"
else
    echo -e "$ERROR_MARKER Problem creating scratch org with alias $payroll_cloud_user_alias"
    exit 1
fi

if ! sfdx force:source:push -u "$payroll_cloud_user_alias"
then
    echo -e "$ERROR_MARKER Problem pushing payroll-cloud-us to scratch org"
    exit 1
fi

sfdx force:apex:execute -f ./config/apex/register-user-provider.apex -u "$payroll_cloud_user_alias"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Problem registering user provider"
    exit 1
fi

sh checkproviderregistration.sh "$payroll_cloud_user_alias" "User"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Deployment failed on Provider Registration for User"
    exit 1
fi   

sfdx force:apex:execute -f ./config/apex/register-user-field-mappings.apex -u "$payroll_cloud_user_alias"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Problem registering user field-mappings"
    exit 1
fi
sh checkfieldmappingregistration.sh "$payroll_cloud_user_alias" "User"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Deployment failed on Field Mapping Registration for User"
    exit 1
fi

sfdx force:apex:execute -f ./config/apex/register-address-provider.apex -u "$payroll_cloud_user_alias"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Problem registering address provider"
    exit 1
fi
sh checkproviderregistration.sh "$payroll_cloud_user_alias" "Address"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Deployment failed on Provider Registration for Address"
    exit 1
fi   

sfdx force:apex:execute -f ./config/apex/register-address-field-mappings.apex -u "$payroll_cloud_user_alias"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Problem registering address field-mappings"
    exit 1
fi
sh checkfieldmappingregistration.sh "$payroll_cloud_user_alias" "Address"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Deployment failed on Field Mapping Registration for Address"
    exit 1
fi

sfdx force:apex:execute -f ./config/apex/register-contact-provider.apex -u "$payroll_cloud_user_alias"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Problem registering contact provider"
    exit 1
fi
sh checkproviderregistration.sh "$payroll_cloud_user_alias" "Contact"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Deployment failed on Provider Registration for Contact"
    exit 1
fi   

sfdx force:apex:execute -f ./config/apex/register-contact-field-mappings.apex -u "$payroll_cloud_user_alias"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Problem registering contact field-mappings"
    exit 1
fi
sh checkfieldmappingregistration.sh "$payroll_cloud_user_alias" "Contact"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
    echo -e "$ERROR_MARKER Deployment failed on Field Mapping Registration for Contact"
    exit 1
fi

echo ""
echo -e "$SUCCESS_MARKER Deployment to Org $payroll_cloud_user_alias was successful"
