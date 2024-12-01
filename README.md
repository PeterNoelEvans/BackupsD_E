If you're using Windows 11, Bash scripts won't work directly unless you're running a Linux subsystem (WSL). For Windows, you can use PowerShell or a batch file for a similar backup solution. Here's how you can create a backup script in Windows:

---

### **PowerShell Script**

```powershell
# Backup-DriveD.ps1
# Backup from Drive D: to Drive E:

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

# Perform the backup using robocopy
$robocopyCommand = @"
robocopy "$Source" "$Destination" /MIR /LOG+:"$LogFile"
"@

Invoke-Expression -Command $robocopyCommand

# Log end time
Add-Content -Path $LogFile -Value "Backup completed: $(Get-Date)"
Write-Host "Backup completed. Check the log at $LogFile"
```

---

### **Steps to Use the Script**
1. **Create the Script**:
   - Open Notepad or a PowerShell editor.
   - Paste the script above.
   - Save it as `Backup-DriveD.ps1` on your computer.

2. **Create the Backup Directory**:
   - Make sure the destination path (`E:\Backup_D\`) exists or adjust the script to your preferred backup location.

3. **Run the Script**:
   - Open PowerShell as Administrator.
   - Navigate to the script's location and run:
     ```powershell
     ./Backup-DriveD.ps1
     ```

4. **Enable Script Execution**:
   If you see a script execution policy error, enable script running by typing:
   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

5. **Automate the Backup**:
   - Use Task Scheduler to run the script automatically at a specified time:
     - Open Task Scheduler and create a new task.
     - Set the trigger (e.g., daily at 2:00 AM).
     - Set the action to run PowerShell with the command:
       ```powershell
       powershell.exe -ExecutionPolicy Bypass -File "C:\Path\To\Backup-DriveD.ps1"
       ```

---

### **Explanation of the Script**
- **Robocopy**:
  - `/MIR`: Mirrors the source to the destination, including deletions.
  - `/LOG+`: Appends the operation logs to the specified log file.
- **Log File**: Stores a detailed log of the backup process.

---

Let me know if you need further assistance or customization!