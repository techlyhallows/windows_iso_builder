. ".\0_config.ps1"

Write-Host "Adding updates to {$MOUNT_PATH} from $UPDATES_PATH ...."
Measure-Command {
    dism /image:$MOUNT_PATH /Add-Package /Packagepath:$UPDATES_PATH | Out-Default
} | Format-Table