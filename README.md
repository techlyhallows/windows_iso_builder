# windows_iso_builder

create custom iso images from official windows iso media. add drivers, remove bloatware and repackage into a bootable/flashable iso. 


# dependencies 

## windows

* install [winget](https://docs.microsoft.com/en-us/windows/package-manager/winget/)
* install windows adk: `winget install Microsoft.WindowsADK`
  * it takes a while so just wait
* download windows iso using [windows media creation tool](https://go.microsoft.com/fwlink/?LinkId=691209)
* for drivers see [driver packs readme](./drivers/README.md)

## linux

untested


# usage
read script comments for more information. some of the "1-9*.ps1" scripts only need to be run once, some can be run multiple times. run them in order, reading this doc, at to avoid missing some user steps.

> `8_cleanup` does not remove the directories created in `1_create_c_dirs`. 

## 0_config.ps1
read and modify to suit your needs.

## 1_create_c_dirs.ps1
creates the locations in `0_config`. if you run with the defaults in config it this is a good time to download an iso to `C:\TMP\Windows.iso`.

## 2_convert_esd_to_wim.ps1
mount the official iso and convert the install.esd to an install.wim. mount the install.wim to the mount point in config.
copies iso files

### mounted install.wim
at mount location you'll see a windows directory structure. you may place files here that will end up in your final image.

## 3_list_apps.ps1
list apps 'installed' in mounted windows image

## 4_remove_apps_10.ps1
read and modify to suit your needs.

## 5_add_drivers.ps1
see [drivers README.md](./drivers/README.md)

## 6_create_iso.ps1
finalize and create bootable media

## 7_cleanup.ps1
dismount windows image and delete uncompressed_install.wim

# bonus
* place [Autounattend.xml](./files/Autounattend.xml) in $ISO_BUILD_DIR and windows installer will boot to audit mode, where you can do updates before the OOBE.
  * key is for generic pro activation