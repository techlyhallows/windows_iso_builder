Param ([Parameter(Mandatory=$true)][string]$image_name)

Measure-Command {
    .\3.1_mount_uncompressed.ps1 | Out-Default
    .\3.2_list_apps.ps1 | Out-Default
    .\4_remove_apps_10.ps1 | Out-Default
    .\5.1_add_drivers.ps1 | Out-Default
    .\5.2_add_updates.ps1 | Out-Default
    .\6.1_prepare_iso_dir.ps1 | Out-Default
    .\6.2_customize.ps1 | Out-Default
    .\6.3_create_iso.ps1 -image_name $image_name | Out-Default
} | Format-Table