# Backup-DriveD.ps1
# Backup from Drive D: to Drive E: (only new or updated files)

# Source and destination paths
$Source = "D:\"
$Destination = "E:\Backup_D\"

# Log file path
$LogFile = "C:\BackupLogs\Backup_D.log"

# Create the log directory if it doesn't exist
if (!(Test-Path -Path (Split-Path -Path $LogFile))) {
    New-Item -ItemType Directory -Path (Split-Path -Path $LogFile) | Out-Null
}

# Log start time
Add-Content -Path $LogFile -Value "Starting backup: $(Get-Date)"
Write-Host "Starting backup: $(Get-Date)"

# Perform the backup using robocopy and display progress
Write-Host "Running backup for new or updated files only..."
Start-Process robocopy -ArgumentList "$Source", "$Destination", "/E", "/XO", "/TEE", "/LOG:$LogFile" -NoNewWindow -Wait

# Log end time
Add-Content -Path $LogFile -Value "Backup completed: $(Get-Date)"
Write-Host "Backup completed successfully at $(Get-Date). See log for details: $LogFile"
