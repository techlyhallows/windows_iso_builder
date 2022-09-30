Param ([Parameter(Mandatory=$true)][string]$image_name)

$ErrorActionPreference = "Stop"
. ".\0_config.ps1"

if (Test-Path -Path $ISO_BUILD_DIR\sources\install.wim) {
    Write-Host " !!!! Pre-existing install.wim found! It will be removed after naming your iso!"
}

#$image_name = Read-host "Name your ISO image (without .iso) to be created in ${TEMP_PATH}"
if (Test-Path -Path $ISO_BUILD_DIR\sources\install.wim) {
    Remove-Item $ISO_BUILD_DIR\sources\install.wim
}

Write-Host "Compressing mounted + customized .wim."
Measure-Command {
    New-WindowsImage -CapturePath $MOUNT_PATH -ImagePath $ISO_BUILD_DIR\sources\install.wim -name "Custom Windows" -Verify -CompressionType fast | Out-Default
} | Format-Table
Write-Host "Creating ${image_name}.iso image in ${TEMP_PATH}"
$start = Get-Location
Set-Location "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg"
Measure-Command {
    .\oscdimg.exe -m -o -u2 -udfver102 -lCustomWindows -bootdata:2#p0,e,b${ISO_BUILD_DIR}boot\etfsboot.com#pEF,e,b${ISO_BUILD_DIR}efi\microsoft\boot\efisys.bin $ISO_BUILD_DIR $TEMP_PATH$image_name.iso | Out-Default
} | Format-Table
Set-Location $start
