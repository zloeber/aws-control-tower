#!/usr/bin/env python3

import boto3
import json
from datetime import datetime

# Initialize AWS clients
organizations = boto3.client('organizations')
iam = boto3.client('iam')
ec2 = boto3.client('ec2')
config = boto3.client('config')
cloudtrail = boto3.client('cloudtrail')
guardduty = boto3.client('guardduty')
sts = boto3.client('sts')
ce = boto3.client('ce')  # Cost Explorer

# Function to get AWS account ID
def get_account_id():
    return sts.get_caller_identity()["Account"]

# Function to get AWS Organizations details
def get_organizations_info():
    try:
        org_info = organizations.describe_organization()
        accounts = organizations.list_accounts()
        return {
            "organization": org_info['Organization'],
            "accounts": accounts['Accounts']
        }
    except organizations.exceptions.AWSOrganizationsNotInUseException:
        return {"organization": None, "accounts": []}

# Function to get IAM details
def get_iam_info():
    roles = iam.list_roles()
    identity_providers = iam.list_saml_providers()
    return {
        "roles": roles['Roles'],
        "identity_providers": identity_providers['SAMLProviderList']
    }

# Function to get VPC and networking details
def get_networking_info():
    vpcs = ec2.describe_vpcs()
    subnets = ec2.describe_subnets()
    vpn_connections = ec2.describe_vpn_connections()
    return {
        "vpcs": vpcs['Vpcs'],
        "subnets": subnets['Subnets'],
        "vpn_connections": vpn_connections['VpnConnections']
    }

# Function to get AWS Config rules
def get_config_rules():
    rules = config.describe_config_rules()
    return rules['ConfigRules']

# Function to get CloudTrail trails
def get_cloudtrail_trails():
    trails = cloudtrail.describe_trails()
    return trails['trailList']

# Function to get GuardDuty detectors
def get_guardduty_detectors():
    detectors = guardduty.list_detectors()
    if detectors['DetectorIds']:
        return guardduty.get_detector(DetectorId=detectors['DetectorIds'][0])
    return {}

# Function to get cost allocation tags and budgets
def get_cost_info():
    tags = ce.get_tags()
    budgets = boto3.client('budgets').describe_budgets(AccountId=get_account_id())
    return {
        "cost_allocation_tags": tags['Tags'],
        "budgets": budgets['Budgets']
    }

# Function to get monitoring tools (CloudWatch)
def get_monitoring_info():
    alarms = boto3.client('cloudwatch').describe_alarms()
    return {
        "cloudwatch_alarms": alarms['MetricAlarms']
    }

# Function to get disaster recovery and backup details
def get_backup_info():
    backup_plans = boto3.client('backup').list_backup_plans()
    return {
        "backup_plans": backup_plans['BackupPlansList']
    }

# Main function to gather all data
def gather_aws_info():
    account_id = get_account_id()
    data = {
        "account_id": account_id,
        "timestamp": datetime.utcnow().isoformat(),
        "organizations": get_organizations_info(),
        "iam": get_iam_info(),
        "networking": get_networking_info(),
        "config_rules": get_config_rules(),
        "cloudtrail_trails": get_cloudtrail_trails(),
        "guardduty_detectors": get_guardduty_detectors(),
        "cost_info": get_cost_info(),
        "monitoring": get_monitoring_info(),
        "backup": get_backup_info()
    }
    return data

# Save data to a JSON file
def save_to_json(data, filename):
    with open(filename, 'w') as f:
        json.dump(data, f, indent=4, default=str)

# Execute the script
if __name__ == "__main__":
    aws_data = gather_aws_info()
    save_to_json(aws_data, "aws_account_info.json")
    print("AWS account information saved to aws_account_info.json")