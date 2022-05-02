# Data Backup Directory
$backup_destination = "E:\UserBackup\" + $env:COMPUTERNAME + "_" + $date

#Log File Directory
$log_file = $backup_destination + "\backup.log"

$date = Get-Date -Format "MM.dd.yyyy"
$time = Get-Date -UFormat "%R"

#List of directories to back up
$backup_directories = ("$env:USERPROFILE\Contacts",
                      "$env:USERPROFILE\Desktop",
                      "$env:USERPROFILE\Documents",
                      "$env:USERPROFILE\Downloads",
                      "$env:USERPROFILE\AppData\Roaming\Microsoft\Signatures",
                      "$env:USERPROFILE\Pictures",
                      "$env:USERPROFILE\Videos",
                      "C:\Users\Public\Caterpillar",
                      "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Bookmarks",
                      "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Bookmarks.bak"
 
                      )  

#Function to output to backup.log
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $log_file -value $logstring
}

#creates backup directory
mkdir -p $backup_destination

#Appends Important Data to Log File
LogWrite "-------+ Backup Information +-------"
LogWrite "ComputerName: $env:COMPUTERNAME"
LogWrite "Username: $env:USERNAME"
LogWrite "Computer Model: $env:Model"
LogWrite "OS Version: $([System.Environment]::OSVersion.VersionString)"
LogWrite "Serial Number: $env:Serial"
LogWrite "Backed up at: $time"
LogWrite "----------------------------------`r`n"
$time

# Copies Directories to Backup Folder
foreach ($dir in $backup_directories)
{


   Write-Host -ForegroundColor Cyan "Copying $dir"
   Copy-Item -Path $dir -Destination $backup_destination -Force -Recurse
   LogWrite "Copied $dir"
}


Write-Host -ForegroundColor green "`r`nBackup Complete, Log file saved to $log_file"