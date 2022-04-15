. ".\0_config.ps1"

$start = Get-Location

Write-Host "Checking for Windows image...."
if (Test-Path -Path $ISO_BUILD_DIR\sources\install.wim) {
    Write-Host "  Removing exising image...."
    Remove-Item $ISO_BUILD_DIR\sources\install.wim
}

Write-Host "  Compressing mounted + customized .wim."
New-WindowsImage -CapturePath $MOUNT_PATH -ImagePath $ISO_BUILD_DIR\sources\install.wim -name "Custom Windows" -Verify -CompressionType fast

$image_name = Read-host "Name your ISO image (without .iso)"
Write-Host "Creating Winows-Custom.iso image in ${TEMP_PATH}"
Set-Location "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg"

Write-Host "Mounting ISO..."
Mount-DiskImage -ImagePath $ISO_PATH -PassThru | Out-Null
$DRIVELETTER = (Get-DiskImage $ISO_PATH | Get-Volume).DriveLetter
Write-Host "Mounted ISO to ${DRIVELETTER}!"

.\oscdimg.exe -m -o -u2 -udfver102 -lCustomWindow -bootdata:2#p0,e,b${DRIVELETTER}:\boot\etfsboot.com#pEF,e,b${DRIVELETTER}:\efi\microsoft\boot\efisys.bin $ISO_BUILD_DIR $TEMP_PATH$image_name.iso

Dismount-DiskImage -ImagePath $ISO_PATH

Set-Location $start
