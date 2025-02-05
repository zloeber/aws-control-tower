# Control Tower Install

A generic design decision workbook for control tower:

| Input              | Value | Example                    | Description                           |
| ------------------ | ----- | -------------------------- | ------------------------------------- |
| Management Account |       | (AWS account id)           | Where tower is going to be installed  |
| Home Region        |       | (us-east-1)                |                                       |
| Additional Regions |       | []                         |                                       |
| Log Archive Email  |       | aws_logarchive@contoso.org |                                       |
| Audit Email        |       | aws_audit@contoso.org      |                                       |
| KMS ARN            |       | <arn>                      | Or create a new one (cost is nominal) |

Deploy control tower and wait.

# Organization Migration

# Questions

For each organization we will extend control tower over the following should be answered:

1. How many accounts? (Over 1000 cannot be brought into tower)
2. Existing OUs should not have more than 300 accounts.
3. Nested OUs are migrated individually.
4. May need to have cloudtrail disabled before registering with tower to avoid double-billing.

Enroll each account manually that will be migrated: https://docs.aws.amazon.com/en_us/controltower/latest/userguide/enroll-manually.html
