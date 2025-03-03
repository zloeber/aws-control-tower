#!/bin/bash

# Script to create an AWS IAM role with read-only access

# Variables
ROLE_NAME="SPRReadOnlyAssessmentRole"
TRUST_POLICY_FILE="trust-policy.json"
POLICY_DOCUMENT="config/aws-assessment-account-policy.json"
DESCRIPTION="Role for SPR read-only environment assessment"

# Automatically get the current AWS account ID
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text 2>/dev/null)

# Check if AWS CLI is installed
if ! command -v aws &>/dev/null; then
  echo "AWS CLI is not installed. Please install it first."
  exit 1
fi

# Check if AWS CLI is configured and can get account ID
if [ -z "$AWS_ACCOUNT_ID" ]; then
  echo "Unable to retrieve AWS Account ID. Ensure AWS CLI is configured with valid credentials."
  exit 1
fi

# Check if role already exists
if aws iam get-role --role-name "$ROLE_NAME" &>/dev/null; then
  echo "Role '$ROLE_NAME' already exists. Skipping creation."
  exit 0
fi

# Create trust policy JSON file
# This allows any IAM principal in the same account to assume the role
cat >$TRUST_POLICY_FILE <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${AWS_ACCOUNT_ID}:root"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

# Create the role
echo "Creating IAM role: $ROLE_NAME"
aws iam create-role \
  --role-name "$ROLE_NAME" \
  --assume-role-policy-document file://$TRUST_POLICY_FILE \
  --description "$DESCRIPTION" 2>/dev/null

if [ $? -eq 0 ]; then
  echo "Role '$ROLE_NAME' created successfully"
else
  echo "Failed to create role"
  rm -f $TRUST_POLICY_FILE
  exit 1
fi

# Create the policy if it doesn't exist
POLICY_EXISTS=$(aws iam list-policies --query "Policies[?PolicyName=='${ROLE_NAME}Policy'].PolicyName" --output text)
if [[ -n $POLICY_EXISTS ]]; then
  echo "Policy ${ROLE_NAME}Policy already exists. Continuing."
else
  echo "Creating policy ${ROLE_NAME}Policy."
  aws iam create-policy \
    --policy-name "${ROLE_NAME}Policy" \
    --policy-document file://"$POLICY_DOCUMENT"
fi

# Get the policy arn
POLICY_ARN=$(aws iam list-policies --query "Policies[?PolicyName=='${ROLE_NAME}Policy'].Arn" --output text)
if [[ -z $POLICY_ARN ]]; then
  echo "Failed to retrieve policy ARN. Exiting."
  rm -f $TRUST_POLICY_FILE
  exit 1
fi
echo "Policy ARN: $POLICY_ARN"

# Attach the policy to the role
echo "Attaching policy to role"
# aws iam put-role-policy \
#   --role-name "$ROLE_NAME" \
#   --policy-name "${ROLE_NAME}Policy" \
#   --policy-document file://"$POLICY_DOCUMENT" 2>/dev/null
aws iam attach-role-policy \
  --role-name "$ROLE_NAME" \
  --policy-arn "$POLICY_ARN" 2>/dev/null

if [ $? -eq 0 ]; then
  echo "Policy attached successfully"
else
  echo "Failed to attach policy"
  rm -f $TRUST_POLICY_FILE
  exit 1
fi

# Clean up
rm -f $TRUST_POLICY_FILE

echo "Role creation complete. ARN: "
aws iam get-role --role-name "$ROLE_NAME" --query 'Role.Arn' --output text
