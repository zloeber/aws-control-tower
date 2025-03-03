data "aws_region" "current" {}

resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

# Create the Management Account (this is typically your root account)
resource "aws_organizations_account" "management_account" {
  name      = var.management_account_name
  email     = var.management_account_email
  role_name = "OrganizationAccountAccessRole"
}

# Create an Organizational Unit (OU) for the workloads
resource "aws_organizations_organizational_unit" "workloads_ou" {
  name      = "Workloads"
  parent_id = aws_organizations_organization.org.roots[0].id
}

# Create a new AWS account within the Workloads OU
resource "aws_organizations_account" "workload_account" {
  name      = "Workload Account"
  email     = "workload@example.com"  # Replace with your email
  role_name = "OrganizationAccountAccessRole"
  parent_id = aws_organizations_organizational_unit.workloads_ou.id
}

resource "aws_controltower_landing_zone" "deployment" {
  manifest_json = file("${path.module}/LandingZoneManifest.json")
  version       = "3.3"
}