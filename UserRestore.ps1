$date = Get-Date -Format "MM.dd.yyyy"
$time = Get-Date -UFormat "%R"

#User to Backup
$usr = Read-Host "Enter User to restore: "

# Location of Backed up Data
$restore_directory = "F:\UserBackup\" + $usr + "_" + $date

#Log File Directory
$log_file = $restore_directory + "\restore.log"

#usr profile
$usr_profile = "C:\Users\$usr"

#Directories to restore backup files to
$restore_destination = ("$usr_profile\Contacts",
                      "$usr_profile\Desktop",
                      "$usr_profile\Documents",
                      "$usr_profile\Downloads",
                      "$usr_profile\AppData\Roaming\Microsoft\Signatures",
                      "$usr_profile\Pictures",
                      "$usr_profile\Videos",
                      "C:\Users\Public\Caterpillar",
                      "$usr_profile\AppData\Local\Google\Chrome\User Data\Default\Bookmarks",
                      "$usr_profile\AppData\Local\Google\Chrome\User Data\Default\Bookmarks.bak"
 
                      )

#Directories of backed up files
$restore_origin = ("$restore_directory\Contacts\*",
                    "$restore_directory\Desktop\*",
                    "$restore_directory\Documents\*",
                    "$restore_directory\Downloads\*",
                    "$restore_directory\Signatures\*",
                    "$restore_directory\Pictures\*",
                    "$restore_directory\Videos\*",
                    "$restore_directory\Caterpillar\*",
                    "$restore_directory\Bookmarks",
                    "$restore_directory\Bookmarks.bak"
                    )

#Function to output to restore.log
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $log_file -value $logstring
}

#Appends Important Data to Log File
LogWrite "-------+ Restore Information +-------"
LogWrite "ComputerName: $env:COMPUTERNAME"
LogWrite "Username: $usr"
LogWrite "Computer Model: $env:Model"
LogWrite "OS Version: $([System.Environment]::OSVersion.VersionString)"
LogWrite "Serial Number: $env:Serial"
LogWrite "Restored at: $time on $date"
LogWrite "----------------------------------`r`n"

$i = 0
# Copies Directories to Backup Folder
foreach ($dir in $restore_origin)
{
   $dest = $restore_destination[$i].ToString()
   Write-Host -ForegroundColor Cyan "`r`nCopying $dir to $dest"
   Copy-Item -Path $dir -Destination $dest -Force -Recurse
   LogWrite "Restored $dir`t to $dest"
   $i++
}

Write-Host -ForegroundColor green "`r`nRestore Complete. Log file saved to $log_file"
