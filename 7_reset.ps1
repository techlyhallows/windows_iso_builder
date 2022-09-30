. ".\0_config.ps1"

Measure-Command {
    Dismount-WindowsImage -Path $MOUNT_PATH -Discard  | Out-Default
    Remove-Item -Path "$ISO_BUILD_DIR*.*" -Recurse -Force | Out-Default
} | Format-Table