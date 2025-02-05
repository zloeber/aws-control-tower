# AWS Control Tower Discovery Tools

## 1. AWS CLI-Based Scripts

You can use the AWS Command Line Interface (CLI) to query information across multiple accounts and regions. Here are some examples:

### a. List All Accounts in an Organization

```bash
aws organizations list-accounts --output table
```

### b. List All Regions Enabled in an Account

```bash
aws ec2 describe-regions --output table
```

### c. List All S3 Buckets Across Accounts

```bash
aws s3api list-buckets --output table
```

### d. List All IAM Users and Roles

```bash
aws iam list-users --output table
aws iam list-roles --output table
```

### e. List All VPCs and Subnets

```bash
aws ec2 describe-vpcs --output table
aws ec2 describe-subnets --output table
```

### f. List All EC2 Instances

```bash
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PrivateIpAddress,PublicIpAddress]' --output table
```

### g. List All Lambda Functions

```bash
aws lambda list-functions --output table
```

### h. List All RDS Instances

```bash
aws rds describe-db-instances --output table
```

### i. List All CloudTrail Trails

```bash
aws cloudtrail describe-trails --output table
```

### j. List All Config Rules

```bash
aws configservice describe-config-rules --output table
```

## 2. Multi-Account and Multi-Region Scripts

To gather information across multiple accounts and regions, you can use a script like this:

```bash
#!/bin/bash

# Set the list of accounts and regions
ACCOUNTS=("account1" "account2" "account3")
REGIONS=("us-east-1" "us-west-2" "eu-west-1")

# Loop through accounts and regions
for account in "${ACCOUNTS[@]}"; do
  for region in "${REGIONS[@]}"; do
    echo "Checking account: $account in region: $region"

    # Assume a role in the target account
    aws sts assume-role --role-arn "arn:aws:iam::$account:role/AdminRole" --role-session-name "InventorySession" > assume-role-output.txt
    export AWS_ACCESS_KEY_ID=$(jq -r '.Credentials.AccessKeyId' assume-role-output.txt)
    export AWS_SECRET_ACCESS_KEY=$(jq -r '.Credentials.SecretAccessKey' assume-role-output.txt)
    export AWS_SESSION_TOKEN=$(jq -r '.Credentials.SessionToken' assume-role-output.txt)

    # Run AWS CLI commands
    aws ec2 describe-instances --region $region --output table
    aws s3api list-buckets --region $region --output table
    # Add more commands as needed

    # Unset temporary credentials
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
  done
done
```

## 3. AWS Config Aggregator

AWS Config Aggregator allows you to aggregate configuration and compliance data from multiple accounts and regions into a single dashboard. You can use this to gather information about resource configurations, compliance status, and drift detection.

### Steps to Set Up Config Aggregator:

1. Enable AWS Config in all accounts and regions.
2. Create an aggregator in the management account.
3. Use the AWS CLI or Console to query aggregated data.

## 4. AWS Resource Explorer

AWS Resource Explorer is a tool that allows you to search and discover resources across accounts and regions. You can use it to gather information about resources like EC2 instances, S3 buckets, and RDS databases.

### Steps to Set Up Resource Explorer:

1. Enable Resource Explorer in all accounts and regions.
2. Create an index and aggregator in the management account.
3. Use the AWS CLI or Console to search for resources.

## 5. Third-Party Tools

There are several third-party tools that can automate the discovery and inventory of AWS resources:

### a. CloudMapper

- **Description:** CloudMapper is an open-source tool that helps visualize and analyze AWS environments.
- **GitHub:** [CloudMapper](https://github.com/duo-labs/cloudmapper)
- **Features:** Generates network diagrams, identifies misconfigurations, and provides inventory reports.

### b. ScoutSuite

- **Description:** ScoutSuite is an open-source multi-cloud security auditing tool.
- **GitHub:** [ScoutSuite](https://github.com/nccgroup/ScoutSuite)
- **Features:** Audits AWS environments for security best practices and compliance.

### c. Prowler

- **Description:** Prowler is an open-source security tool for AWS.
- **GitHub:** [Prowler](https://github.com/prowler-cloud/prowler)
- **Features:** Checks for compliance with CIS Benchmarks, GDPR, HIPAA, and more.

### d. Cloud Custodian

- **Description:** Cloud Custodian is an open-source tool for managing and governing cloud resources.
- **GitHub:** [Cloud Custodian](https://github.com/cloud-custodian/cloud-custodian)
- **Features:** Provides policy-based management and reporting for AWS resources.

## 6. AWS Well-Architected Tool

The AWS Well-Architected Tool can help you assess the current state of your AWS environment and identify areas for improvement. It provides a detailed report based on the Well-Architected Framework pillars (operational excellence, security, reliability, performance efficiency, and cost optimization).

### Steps to Use the Tool:

1. Run a Well-Architected review for each workload.
2. Export the results for analysis.

## 7. Custom Python/Boto3 Scripts

If you need more flexibility, you can write custom scripts using the AWS SDK for Python (Boto3). Here’s an example:

```python
import boto3

# Initialize a session
session = boto3.Session()

# Get a list of all regions
ec2_client = session.client('ec2')
regions = [region['RegionName'] for region in ec2_client.describe_regions()['Regions']]

# Loop through regions and gather information
for region in regions:
  print(f"Checking region: {region}")
  ec2_resource = session.resource('ec2', region_name=region)

  # List EC2 instances
  instances = ec2_resource.instances.all()
  for instance in instances:
    print(f"Instance ID: {instance.id}, State: {instance.state['Name']}")

  # Add more resource checks as needed
```

## 8. AWS Trusted Advisor

AWS Trusted Advisor provides real-time guidance to help you provision resources following AWS best practices. It covers cost optimization, security, fault tolerance, and performance.

### Steps to Use Trusted Advisor:

1. Enable Trusted Advisor in the management account.
2. Review the recommendations and export the data.
