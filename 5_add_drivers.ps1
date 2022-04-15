. ".\0_config.ps1"

Add-WindowsDriver -Path $MOUNT_PATH -Driver ".\drivers" -Recurse
