provider "aws" {
  region = var.region
}

resource "aws_organizations_organization" "this" {
  aws_service_access_principals = var.aws_service_access_principals
  enabled_policy_types          = var.enabled_policy_types
}

variable "region" {
  description = "The AWS region to deploy the organization in"
  type        = string
  default     = "us-east-1"
}

variable "aws_service_access_principals" {
  description = "List of AWS service principals to enable integration with AWS Organizations"
  type        = list(string)
  default     = []
}

variable "enabled_policy_types" {
  description = "List of policy types to enable in the organization"
  type        = list(string)
  default     = []
}

output "organization_id" {
  description = "The ID of the AWS Organization"
  value       = aws_organizations_organization.this.id
}