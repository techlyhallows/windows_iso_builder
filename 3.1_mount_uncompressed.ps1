. ".\0_config.ps1"
Write-Host "Mounting Uncompressed image.."
Measure-Command {
    Mount-WindowsImage -ImagePath $WIM_PATH -Index 1 -Path $MOUNT_PATH | Out-Default
} | Format-Table