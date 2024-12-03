# Step 1: Get the current username
$username = $env:USERNAME

# Initialize variables
$fullName = $null
$email = $null

# Step 2: Try to get the full name and email from local user account
$localUser = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
if ($localUser) {
    $fullName = $localUser.FullName
}

# Step 3: If full name or email not found locally, try Active Directory
if (-not $fullName -or -not $email) {
    try {
        # Import Active Directory module if not already imported
        Import-Module ActiveDirectory -ErrorAction SilentlyContinue

        # Attempt to get user info from Active Directory
        $domainUser = Get-ADUser -Identity $username -Properties DisplayName, EmailAddress -ErrorAction Stop
        if ($domainUser) {
            if (-not $fullName) { $fullName = $domainUser.DisplayName }
            if (-not $email) { $email = $domainUser.EmailAddress }
        }
    }
    catch {
        # Active Directory module not available or user not found
    }
}

# Step 4: If email is still not found, prompt the user
if (-not $email) {
    $email = Read-Host "Please enter your email address for Git configuration"
}

# Step 5: If full name is still not found, prompt the user
if (-not $fullName) {
    $fullName = Read-Host "Please enter your full name for Git configuration"
}

# Step 6: Generate SSH key if it doesn't exist
$sshKeyPath = "$HOME\.ssh\id_rsa"
if (-not (Test-Path "$sshKeyPath.pub")) {
    # Ensure the .ssh directory exists
    if (-not (Test-Path "$HOME\.ssh")) {
        New-Item -ItemType Directory -Path "$HOME\.ssh" | Out-Null
    }

    # Generate the SSH key
    ssh-keygen -t rsa -b 4096 -C $email -f $sshKeyPath -N '""'
    Write-Host "SSH key pair generated at $sshKeyPath"
}
else {
    Write-Host "SSH key pair already exists at $sshKeyPath"
}

# Step 7: Output the public key
Write-Host "`nYour public SSH key is:`n"
Get-Content "$sshKeyPath.pub"

# Step 8: Configure Git with the retrieved full name and email
git config --global user.name "$fullName"
git config --global user.email "$email"
git config --global core.autocrlf false
git config --global credential.helper 'cache --timeout=3600'

Write-Host "`nGit has been configured with the following settings:"
git config --global --list
