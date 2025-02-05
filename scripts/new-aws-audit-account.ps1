#!pwsh
# Parameters
$UserName = "ReadOnlyCollector-SPR"
$PolicyArn = "arn:aws:iam::aws:policy/ReadOnlyAccess"

# Import AWS PowerShell module
Import-Module AWS.Tools.IAM

# Create the IAM User
$User = New-IAMUser `
  -UserName $UserName `
  -PermissionsBoundary $PolicyArn `
  -NoServiceLinkedRole

# Attach the ReadOnly policy
Register-IAMUserPolicy -UserName $UserName -PolicyArn $PolicyArn

# Create an access key for the user
$AccessKey = New-IAMAccessKey -UserName $UserName

# Output credentials
Write-Output "User '$UserName' created successfully."
Write-Output "Access Key ID: $($AccessKey.AccessKeyId)"
Write-Output "Secret Access Key: $($AccessKey.SecretAccessKey)"
Write-Output "Make sure to store these credentials securely."
