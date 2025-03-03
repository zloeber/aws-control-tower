#!/bin/bash

# Set the management account ID
MANAGEMENT_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Trust relationship JSON file
cat >/tmp/trust_relationship.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::$MANAGEMENT_ACCOUNT_ID:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF

# Set the role name
ROLE_NAME="AWSControlTowerExecution"

# Create the role
aws iam create-role \
  --role-name $ROLE_NAME \
  --description "Execution role for AWS Control Tower" \
  --assume-role-policy-document file:///tmp/trust_relationship.json

# Attach the AdministratorAccess policy
aws iam attach-role-policy \
  --role-name $ROLE_NAME \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
