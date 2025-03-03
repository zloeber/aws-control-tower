#!/usr/bin/env bash
# This script creates a new AWS IAM role for an assessment account
# and attaches a policy to it.
#
# Usage: ./new-assessment-role.sh [ROLE_NAME]
# (If no role name is provided, it defaults to "SPRAssessment".)

ROLE_NAME=${1:-"SPRAssessment"}
POLICY_DOCUMENT="config/aws-assessment-account-policy.json"

# Check if AWS CLI is installed
if ! command -v aws &>/dev/null; then
  echo "AWS CLI could not be found. Please install it and configure your credentials."
  exit 1
fi

# Check if the policy document exists
if [ ! -f "config/aws-assessment-account-policy.json" ]; then
  echo "Policy document not found. Please ensure 'config/aws-assessment-account-policy.json' exists."
  exit 1
fi

# Check if the role already exists and create it if not
ROLE_EXISTS=$(aws iam get-role --role-name "$ROLE_NAME" 2>&1)
if [[ $ROLE_EXISTS == *"NoSuchEntity"* ]]; then
  echo "Role $ROLE_NAME does not exist. Proceeding to create it."
  aws iam create-role --role-name "$ROLE_NAME" --assume-role-policy-document file://"$POLICY_DOCUMENT"
else
  echo "Role $ROLE_NAME already exists. Continuing."
fi

# Check if the policy is already attached to the role
# If not, attach the policy
POLICY_EXISTS=$(aws iam list-role-policies --role-name "$ROLE_NAME" | grep -w "${ROLE_NAME}Policy")
if [[ -n $POLICY_EXISTS ]]; then
  echo "Policy ${ROLE_NAME}Policy is already attached to the role."
else
  echo "Attaching policy ${ROLE_NAME}Policy to the role."
  aws iam put-role-policy --role-name "$ROLE_NAME" --policy-name "${ROLE_NAME}Policy" --policy-document file://"$POLICY_DOCUMENT"
fi

echo "Role $ROLE_NAME created and policy attached."
