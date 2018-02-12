# sf-cust-metadata
Sample code to demonstrate custom metadata problems in Salesforce

## To Execute
This is an SFDX example, you must have sfdx setup on your machine.

```bash
sh ./buildScratchOrg scratch-org-alias
```

## Results
The build will produce one of two outcomes
1) A failure
```bash
-e [ERROR] Deployment failed on Field Mapping Registration for Address
```
2) Success
```bash
-e [SUCCESS] Deployment to Org scratch-org-alias was successful
```

Depending on the time of day, the rate of success vs failure varies.
Typically, one out of every five attempts will fail.

## Problem Scratch Org instances
Some S/F instances are more prone to the error than others.
1. CS85
2. CS65

![Alt text](/images/deploy_status.png?raw=true "Deploy Status")
![Alt text](/images/deploy_status_view_details.png?raw=true "Deploy Status View Details")
