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

# Function to deregister a member account from Control Tower
deregister_account() {
  local account_id=$1
  echo "Deregistering account $account_id from Control Tower..."
  aws controltower deregister-account --account-id "$account_id"
}

# Function to delete the Control Tower landing zone
delete_landing_zone() {
  echo "Deleting Control Tower landing zone..."
  landing_zone_id=$(aws controltower list-landing-zones --query 'landingZones[0].arn')
  aws controltower delete-landing-zone --landing-zone-id "$landing_zone_id"
}

main() {
  # Check if AWS CLI is installed
  if ! command -v aws &>/dev/null; then
    echo "AWS CLI could not be found. Please install it to proceed."
    exit 1
  fi

  # Main script execution
  echo "Starting the removal of AWS Control Tower..."

  # List all accounts in the Control Tower
  accounts=$(aws organizations list-accounts --query 'Accounts[*].Id' --output text)

  # Deregister each account
  for account_id in $accounts; do
    deregister_account "$account_id"
  done

  # Delete the Control Tower landing zone
  delete_landing_zone
  echo "AWS Control Tower removal process completed."

  account_id="$(aws sts get-caller-identity --query Account --output text)"
  # Additional steps to fully decommission AWS Control Tower
  aws controltower deregister-managed-account --account-id "${account_id}"
  aws controltower disable-control-tower
  aws organizations disable-aws-service-access --service-principal controltower.amazonaws.com

  # Detach policies from roles
  detach_policies

  # Delete roles
  delete_roles

  # Delete policies
  delete_policies
}

main "$@"
# End of script
