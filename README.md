# Easy-User-Backup
Simple powershell script to easily backup userdata from common directories

There are two scripts, one to backup userdata and one to restore userdata. Since this is mostly a personal script, the drivepath to backup data is hardcoded to the F:\ Directory. You can change this easily on line 8 in each script.

Each script will prompt you for a username to backup, and then go to C:\Users\[Username] to search for that users files. If userfiles are stored in a different directory they will NOT be backed up.

This is a very basic script, so you will likely need to customize it to better suit your needs.
