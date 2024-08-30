# get all user on the system
Get-LocalUser | Select-Object -Property Name,Enabled | Format-Table