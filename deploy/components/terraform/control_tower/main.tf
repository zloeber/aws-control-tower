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


resource "aws_controltower_control" "deployment" {
  control_identifier = "arn:aws:controltower:${data.aws_region.current.name}::control/AWS-GR_EC2_VOLUME_INUSE_CHECK"
  target_identifier = [
    for x in data.aws_organizations_organizational_units.example.children :
    x.arn if x.name == "Infrastructure"
  ][0]

  parameters {
    key   = "AllowedRegions"
    value = jsonencode(["us-east-1"])
  }
}