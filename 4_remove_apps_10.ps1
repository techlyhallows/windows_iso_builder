. ".\0_config.ps1"

# tried to remove the fluff without breaking some features. (display sharing is driven by xbox)

#credit: https://community.spiceworks.com/topic/1548590-dism-to-remove-win10-appx-apps-from-wim
$apps=@( 	
    #Unnecessary Windows 10 AppX Apps
    "MicrosoftTeams"
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.GetHelp"
    "Microsoft.GetStarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MixedReality.Portal"
    "Microsoft.MSPaint" # Windows 10 "Paint 3D" app
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Todos"
    "Microsoft.Wallet"
    "Microsoft.WindowsAlarms"
    "Microsoft.Windowscommunicationsapps"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
)

Write-Host "Starting... (no output == no app)"
Measure-Command {
    foreach ($app in $apps)
    {
        Write-Host "Trying ${app}"
        Get-AppXProvisionedPackage -path $MOUNT_PATH | where DisplayName -like $app | Remove-AppxProvisionedPackage | Out-Default
    }
} | Format-Table