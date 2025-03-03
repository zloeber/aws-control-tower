variable "workload_account_email" {
  description = "The email address for the workload account."
  type        = string
}

variable "management_account_email" {
  description = "The email address for the management account."
  type        = string
}

variable "management_account_name" {
  description = "The name for the management account."
  type        = string
  default = "Workloads"
}

variable "workload_account_name" {
  description = "The name for the workload account."
  type        = string
  default = "Workloads"
}

variable "stage" {
  description = "The stage to deploy to."
  type        = string
  default     = "dev"
}

variable "region" {
  description = "The AWS region to deploy to."
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "The AWS account ID to deploy to."
  type        = string
  default     = "123456789012"
}
