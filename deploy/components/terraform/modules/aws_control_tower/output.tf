# Output the account IDs
output "management_account_id" {
  value = aws_organizations_account.management_account.id
}

output "workload_account_id" {
  value = aws_organizations_account.workload_account.id
}