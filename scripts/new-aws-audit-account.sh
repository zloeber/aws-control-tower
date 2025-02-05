#!/bin/bash

# Variables
USER_NAME=${1:-"ReadOnlyCollector-SPR"}

POLICY_ARN="arn:aws:iam::aws:policy/ReadOnlyAccess"

# Create IAM user
aws iam create-user --user-name "$USER_NAME"

# Attach ReadOnlyAccess policy
aws iam attach-user-policy --user-name "$USER_NAME" --policy-arn "$POLICY_ARN"

# Create access key
ACCESS_KEY_JSON=$(aws iam create-access-key --user-name "$USER_NAME")

# Extract Access Key ID and Secret Access Key
ACCESS_KEY_ID=$(echo "$ACCESS_KEY_JSON" | jq -r '.AccessKey.AccessKeyId')
SECRET_ACCESS_KEY=$(echo "$ACCESS_KEY_JSON" | jq -r '.AccessKey.SecretAccessKey')

# Output credentials
echo "User '$USER_NAME' created successfully."
echo "Access Key ID: $ACCESS_KEY_ID"
echo "Secret Access Key: $SECRET_ACCESS_KEY"
echo "Make sure to store these credentials securely."

# Optional: Save credentials to a file
echo -e "[AWS ReadOnly User Credentials]\nAccess Key ID: $ACCESS_KEY_ID\nSecret Access Key: $SECRET_ACCESS_KEY" >aws_readonly_credentials.txt
echo "Credentials saved to aws_readonly_credentials.txt (delete after use!)"
