. ".\0_config.ps1"

Dismount-WindowsImage -Path $MOUNT_PATH -Discard
dism /Cleanup-Wim
Remove-Item -Path "$ISO_BUILD_DIR*.*" -Recurse -Force
