#!/usr/bin/env bash

# Set variables
AWS_REGION="us-east-2"
IAM_USER_NAME="terraform-user"
IAM_POLICY_NAME="terraform-policy"
S3_BUCKET_NAME="my-terraform-state-bucket"
DYNAMODB_TABLE_NAME="terraform-state-lock"

# Create IAM user
aws iam create-user --user-name $IAM_USER_NAME

# Create IAM policy
cat >/tmp/terraform-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:*",
                "ec2:*",
                "s3:*",
                "dynamodb:*",
                "lambda:*",
                "cloudwatch:*",
                "cloudformation:*",
                "route53:*",
                "vpc:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF

aws iam create-policy --policy-name $IAM_POLICY_NAME --policy-document file:///tmp/terraform-policy.json

# Attach IAM policy to IAM user
aws iam attach-user-policy --user-name $IAM_USER_NAME --policy-arn arn:aws:iam::aws:policy/$IAM_POLICY_NAME

# Create access key for IAM user
aws iam create-access-key --user-name $IAM_USER_NAME --query 'AccessKey.{AccessKeyId,SecretAccessKey}' --output text >access_key.txt

# Create S3 bucket for Terraform state
aws s3 mb s3://$S3_BUCKET_NAME

# Create DynamoDB table for Terraform state locking
aws dynamodb create-table --table-name $DYNAMODB_TABLE_NAME --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

# Output access key and secret key
echo "AccessKeyId: $(cat access_key.txt | cut -d' ' -f1)"
echo "SecretAccessKey: $(cat access_key.txt | cut -d' ' -f2)"

# Output Terraform configuration
cat >terraform.tf <<EOF
provider "aws" {
  region     = "$AWS_REGION"
  access_key = "$(cat access_key.txt | cut -d' ' -f1)"
  secret_key = "$(cat access_key.txt | cut -d' ' -f2)"
}

terraform {
  backend "s3" {
    bucket = "$S3_BUCKET_NAME"
    key    = "terraform.tfstate"
    region = "$AWS_REGION"
    dynamodb_table = "$DYNAMODB_TABLE_NAME"
  }
}
EOF

echo "Bootstrap complete!"
