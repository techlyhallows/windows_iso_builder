$ErrorActionPreference = "Stop"
. ".\0_config.ps1"


Write-Host "Checking for existing mount...."
if (Test-Path -Path "${MOUNT_PATH}\Windows") {
    Write-Host "Exiting mount found! Run 7_cleanup if you're done."
    Exit
}

Write-Host "Mounting ISO..."
Mount-DiskImage -ImagePath $ISO_PATH -PassThru

$DRIVELETTER = (Get-DiskImage $ISO_PATH | Get-Volume).DriveLetter
Write-Host "Mounted ISO to ${DRIVELETTER}!"
$SOURCES = "${DRIVELETTER}:\sources"


dism /Get-WimInfo /WimFile:$SOURCES\install.wim
$wim_index = Read-host "What index (version of Windows) for extraction?"

if ("" -eq $wim_index) {
    Write-Host "No input, dismounting ISO and exiting!"
    Dismount-DiskImage -ImagePath $ISO_PATH
    Exit
}
if (Test-Path -Path "$SOURCES/install.wim") {
    $source_image = "$SOURCES/install.wim"
} else {
    $source_image = "$SOURCES/install.esd"
}
Write-Host "Starting image extraction to temp working path: ${wim_path}....."
dism /export-image /SourceImageFile:$source_image /SourceIndex:$wim_index /DestinationImageFile:$WIM_PATH /CheckIntegrity /Compress:None
