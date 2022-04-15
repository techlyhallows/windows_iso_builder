$ErrorActionPreference = "Stop"
. ".\0_config.ps1"


Write-Host "Checking for existing mount...."
if (Test-Path -Path "${MOUNT_PATH}\Windows") {
    Write-Host "Exiting mount found! Run 9_cleanup if you're done."
    Exit
}

Write-Host "Mounting ISO..."
Mount-DiskImage -ImagePath $ISO_PATH -PassThru | Out-Null

$DRIVELETTER = (Get-DiskImage $ISO_PATH | Get-Volume).DriveLetter
Write-Host "Mounted ISO to ${DRIVELETTER}!"
$SOURCES = "${DRIVELETTER}:\sources"


Write-Host "Copying base ISO contents, minus install.esd..."
Copy-Item -Path "${DRIVELETTER}:\*" -Recurse -Force -Destination "${ISO_BUILD_DIR}" -Exclude "install.esd"
Write-Host "Copy complete!"


dism /Get-WimInfo /WimFile:$SOURCES/install.esd
$wim_index = Read-host "What index (version of Windows) for extraction?"

if ("" -eq $wim_index) {
    Write-Host "No input, dismounting ISO and exiting!"
    Dismount-DiskImage -ImagePath $ISO_PATH
    Exit
}


$wim_path = "${TEMP_PATH}install_uncompressed.wim"
Write-Host "Starting image extraction to temp working path: ${wim_path}....."
dism /export-image /SourceImageFile:$SOURCES/install.esd /SourceIndex:$wim_index /DestinationImageFile:$wim_path /CheckIntegrity /Compress:None

Write-Host "Mounting Uncompressed image.."
Mount-WindowsImage -ImagePath $wim_path -Index 1 -Path $MOUNT_PATH