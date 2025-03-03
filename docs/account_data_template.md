# Example Table

| Category          | Data Point                      | Details to Capture                                                           | Notes/Examples                            |
| ----------------- | ------------------------------- | ---------------------------------------------------------------------------- | ----------------------------------------- |
| Account Basics    | Account ID                      | 12-digit AWS account ID                                                      | e.g., 123456789012                        |
|                   | Account Name/Alias              | Friendly name or alias for the account                                       | e.g., "Prod-Account-1"                    |
|                   | Purpose                         | Primary use of the account                                                   | e.g., Production, Development, Testing    |
|                   | Owner/Team                      | Team or department responsible for the account                               | e.g., "DevOps Team"                       |
| AWS Organizations | Organizational Unit (OU)        | OU membership (if AWS Organizations is in use)                               | e.g., "Production OU" or "Not in an OU"   |
|                   | Service Control Policies (SCPs) | List applied SCPs and their effects                                          | e.g., "DenyRegionExceptUSEast1"           |
|                   | AWS Control Tower Enrollment    | Is the account managed by AWS Control Tower? If yes, list applied guardrails | e.g., "Yes, Guardrail: EnforceMFA"        |
| Compute Resources | EC2 Instances                   | Number, instance types, and regions                                          | e.g., "5 t3.medium in us-east-1"          |
|                   | Reserved Instances (RIs)        | Number of RIs, instance types, terms, and utilization percentage             | e.g., "2 t3.medium, 1-year, 80% utilized" |
|                   | Savings Plans                   | Commitment amount and coverage                                               | e.g., "$500/month, covers 50% of compute" |
|                   | Auto Scaling                    | Is Auto Scaling enabled? List configurations                                 | e.g., "Yes, Min: 2, Max: 5, Desired: 3"   |
| Networking        | VPCs                            | Number of VPCs, CIDR blocks, and regions                                     | e.g., "2 VPCs, 10.0.0.0/16 in us-east-1"  |
|                   | Subnets                         | Number and types (public/private) per VPC                                    | e.g., "3 public, 2 private"               |
|                   | Direct Connect                  | Is Direct Connect in use? List connection details (location, bandwidth)      | e.g., "Yes, 1 Gbps, NY Data Center"       |
|                   | VPN                             | Number of VPNs and endpoints                                                 | e.g., "1 VPN to on-prem DC"               |
|                   | Transit Gateway/Peering         | Is Transit Gateway or VPC peering in use?                                    | e.g., "Transit Gateway ID: tgw-12345"     |
| IAM               | IAM Users                       | Total number of IAM users                                                    | e.g., "15 users"                          |
|                   | IAM Roles                       | Total number of roles and key use cases                                      | e.g., "10 roles, mostly for EC2"          |
|                   | Federated Identity              | Is SSO/federation in use? Provider details                                   | e.g., "Yes, Okta"                         |
|                   | MFA Enforcement                 | Is MFA enabled for root and IAM users?                                       | e.g., "Root: Yes, IAM: Partial (50%)"     |
|                   | Terraform Usage                 | Is Terraform used for IAM? List resources managed                            | e.g., "Yes, manages roles and policies"   |
|                   | Policy Management               | How are policies created/maintained?                                         | e.g., "Manual JSON in console"            |
| Services          | Core Services in Use            | List primary AWS services and their purpose                                  | e.g., "S3 for storage, RDS for databases" |
|                   | Region Usage                    | Regions where resources are deployed                                         | e.g., "us-east-1, us-west-2"              |
|                   | High Availability               | Are workloads multi-AZ or multi-region?                                      | e.g., "Yes, multi-AZ in us-east-1"        |
| Cost Management   | Billing Allocation              | How are costs tracked for this account?                                      | e.g., "Tagged by project code"            |
|                   | Cost Optimization Tools         | Tools in use for cost monitoring                                             | e.g., "Cost Explorer enabled"             |
| Monitoring        | CloudWatch                      | Is CloudWatch in use? Metrics and alarms configured                          | e.g., "Yes, CPU > 80% alarm"              |
|                   | CloudTrail                      | Is CloudTrail enabled? Scope (e.g., all regions, specific events)            | e.g., "Yes, all regions"                  |
| Challenges        | Known Issues                    | Any reported or observed issues specific to this account                     | e.g., "Frequent overprovisioning of EC2"  |

# Template Table

| Category          | Data Point                      | Details to Capture                                                           | Notes/Examples                            |
| ----------------- | ------------------------------- | ---------------------------------------------------------------------------- | ----------------------------------------- |
| Account Basics    | Account ID                      | 12-digit AWS account ID                                                      | e.g., 123456789012                        |
|                   | Account Name/Alias              | Friendly name or alias for the account                                       | e.g., "Prod-Account-1"                    |
|                   | Purpose                         | Primary use of the account                                                   | e.g., Production, Development, Testing    |
|                   | Owner/Team                      | Team or department responsible for the account                               | e.g., "DevOps Team"                       |
| AWS Organizations | Organizational Unit (OU)        | OU membership (if AWS Organizations is in use)                               | e.g., "Production OU" or "Not in an OU"   |
|                   | Service Control Policies (SCPs) | List applied SCPs and their effects                                          | e.g., "DenyRegionExceptUSEast1"           |
|                   | AWS Control Tower Enrollment    | Is the account managed by AWS Control Tower? If yes, list applied guardrails | e.g., "Yes, Guardrail: EnforceMFA"        |
| Compute Resources | EC2 Instances                   | Number, instance types, and regions                                          | e.g., "5 t3.medium in us-east-1"          |
|                   | Reserved Instances (RIs)        | Number of RIs, instance types, terms, and utilization percentage             | e.g., "2 t3.medium, 1-year, 80% utilized" |
|                   | Savings Plans                   | Commitment amount and coverage                                               | e.g., "$500/month, covers 50% of compute" |
|                   | Auto Scaling                    | Is Auto Scaling enabled? List configurations                                 | e.g., "Yes, Min: 2, Max: 5, Desired: 3"   |
| Networking        | VPCs                            | Number of VPCs, CIDR blocks, and regions                                     | e.g., "2 VPCs, 10.0.0.0/16 in us-east-1"  |
|                   | Subnets                         | Number and types (public/private) per VPC                                    | e.g., "3 public, 2 private"               |
|                   | Direct Connect                  | Is Direct Connect in use? List connection details (location, bandwidth)      | e.g., "Yes, 1 Gbps, NY Data Center"       |
|                   | VPN                             | Number of VPNs and endpoints                                                 | e.g., "1 VPN to on-prem DC"               |
|                   | Transit Gateway/Peering         | Is Transit Gateway or VPC peering in use?                                    | e.g., "Transit Gateway ID: tgw-12345"     |
| IAM               | IAM Users                       | Total number of IAM users                                                    | e.g., "15 users"                          |
|                   | IAM Roles                       | Total number of roles and key use cases                                      | e.g., "10 roles, mostly for EC2"          |
|                   | Federated Identity              | Is SSO/federation in use? Provider details                                   | e.g., "Yes, Okta"                         |
|                   | MFA Enforcement                 | Is MFA enabled for root and IAM users?                                       | e.g., "Root: Yes, IAM: Partial (50%)"     |
|                   | Terraform Usage                 | Is Terraform used for IAM? List resources managed                            | e.g., "Yes, manages roles and policies"   |
|                   | Policy Management               | How are policies created/maintained?                                         | e.g., "Manual JSON in console"            |
| Services          | Core Services in Use            | List primary AWS services and their purpose                                  | e.g., "S3 for storage, RDS for databases" |
|                   | Region Usage                    | Regions where resources are deployed                                         | e.g., "us-east-1, us-west-2"              |
|                   | High Availability               | Are workloads multi-AZ or multi-region?                                      | e.g., "Yes, multi-AZ in us-east-1"        |
| Cost Management   | Billing Allocation              | How are costs tracked for this account?                                      | e.g., "Tagged by project code"            |
|                   | Cost Optimization Tools         | Tools in use for cost monitoring                                             | e.g., "Cost Explorer enabled"             |
| Monitoring        | CloudWatch                      | Is CloudWatch in use? Metrics and alarms configured                          | e.g., "Yes, CPU > 80% alarm"              |
|                   | CloudTrail                      | Is CloudTrail enabled? Scope (e.g., all regions, specific events)            | e.g., "Yes, all regions"                  |
| Challenges        | Known Issues                    | Any reported or observed issues specific to this account                     | e.g., "Frequent overprovisioning of EC2"  |

# Template Table

| Category          | Data Point                      | Value(s) |
| ----------------- | ------------------------------- | -------- |
| Account Basics    | Account ID                      |          |
|                   | Account Name/Alias              |          |
|                   | Purpose                         |          |
|                   | Owner/Team                      |          |
| AWS Organizations | Organizational Unit (OU)        |          |
|                   | Service Control Policies (SCPs) |          |
|                   | AWS Control Tower Enrollment    |          |
| Compute Resources | EC2 Instances                   |          |
|                   | Reserved Instances (RIs)        |          |
|                   | Savings Plans                   |          |
|                   | Auto Scaling                    |          |
| Networking        | VPCs                            |          |
|                   | Subnets                         |          |
|                   | Direct Connect                  |          |
|                   | VPN                             |          |
|                   | Transit Gateway/Peering         |          |
| IAM               | IAM Users                       |          |
|                   | IAM Roles                       |          |
|                   | Federated Identity              |          |
|                   | MFA Enforcement                 |          |
|                   | Terraform Usage                 |          |
|                   | Policy Management               |          |
| Services          | Core Services in Use            |          |
|                   | Region Usage                    |          |
|                   | High Availability               |          |
| Cost Management   | Billing Allocation              |          |
|                   | Cost Optimization Tools         |          |
| Monitoring        | CloudWatch                      |          |
|                   | CloudTrail                      |          |
| Challenges        | Known Issues                    |          |
