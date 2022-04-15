. ".\0_config.ps1"

Dismount-WindowsImage -Path $MOUNT_PATH -Save

dism /Unmount-Wim  /MountDir:$MOUNT_PATH /commit
dism /Cleanup-Wim

Remove-Item $TEMP_PATH\install_uncompressed.wim
