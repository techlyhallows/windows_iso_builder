. ".\0_config.ps1"

Write-Host "Adding drivers...."
Measure-Command {
    Add-WindowsDriver -Path $MOUNT_PATH -Driver $DRIVER_DIR -Recurse | Out-Default
} | Format-Table