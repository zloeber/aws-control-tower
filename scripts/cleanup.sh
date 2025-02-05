#!/usr/bin/env bash

# Define the roles and policies to be removed
roles=("AWSControlTowerAdmin" "AWSControlTowerCloudTrailRole" "AWSControlTowerStackSetRole")
policies=("AWSControlTowerAdminPolicy" "AWSControlTowerCloudTrailRolePolicy" "AWSControlTowerStackSetRolePolicy")

# Function to detach policies from roles
detach_policies() {
  for role in "${roles[@]}"; do
    for policy in "${policies[@]}"; do
      aws iam detach-role-policy --role-name "$role" --policy-arn "arn:aws:iam::aws:policy/$policy"
    done
  done
}

# Function to delete roles
delete_roles() {
  for role in "${roles[@]}"; do
    aws iam delete-role --role-name "$role"
  done
}

# Function to delete policies
delete_policies() {
  for policy in "${policies[@]}"; do
    aws iam delete-policy --policy-arn "arn:aws:iam::aws:policy/$policy"
  done
}

# Detach policies from roles
detach_policies

# Delete roles
delete_roles

# Delete policies
delete_policies

account_id="$(aws sts get-caller-identity --query Account --output text)"
# Additional steps to fully decommission AWS Control Tower
aws controltower deregister-managed-account --account-id "${account_id}"
aws controltower disable-control-tower
