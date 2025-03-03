#!/usr/bin/env bash

# Check if AWS CLI is installed
if ! command -v aws &>/dev/null; then
  echo "AWS CLI could not be found. Please install it to proceed."
  exit 1
fi

# Function to deregister a member account from Control Tower
deregister_account() {
  local account_id=$1
  echo "Deregistering account $account_id from Control Tower..."
  aws controltower deregister-account --account-id "$account_id"
}

# Function to delete the Control Tower landing zone
delete_landing_zone() {
  echo "Deleting Control Tower landing zone..."
  aws controltower delete-landing-zone
}

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
