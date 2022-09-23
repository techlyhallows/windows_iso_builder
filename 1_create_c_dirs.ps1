. ".\0_config.ps1"

New-Item -Path $WORK_PATH -Name $MOUNT_PATH_NAME -ItemType "directory"
New-Item -Path $WORK_PATH -Name $ISO_PATH_NAME -ItemType "directory"
New-Item -Path $WORK_PATH -Name $TEMP_PATH_NAME -ItemType "directory"
New-Item -Path $TEMP_PATH -Name $UPDATES_PATH_NAME -ItemType "directory"
