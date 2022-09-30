. ".\0_config.ps1"

Write-Host "Mounting ISO..."
Mount-DiskImage -ImagePath $ISO_PATH -PassThru | Out-Null
$DRIVELETTER = (Get-DiskImage $ISO_PATH | Get-Volume).DriveLetter
Write-Host "Mounted ISO to ${DRIVELETTER}!"

Write-Host "Copying base ISO contents, minus install.*..."
Measure-Command {
    Copy-Item -Path "${DRIVELETTER}:\*" -Recurse -Force -Destination "${ISO_BUILD_DIR}" -Exclude "install.*" | Out-Default
    Write-Host "Copy complete!"
} | Format-Table
Write-Host "Unmounting ISO @ ${DRIVELETTER}."
Dismount-DiskImage -ImagePath $ISO_PATH
