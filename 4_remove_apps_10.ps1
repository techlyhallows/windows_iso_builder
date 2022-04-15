. ".\0_config.ps1"

# tried to remove the fluff without breaking some features. (display sharing is driven by xbox)

Write-Host "Removing fluff from mounted Windows...."
#credit: https://community.spiceworks.com/topic/1548590-dism-to-remove-win10-appx-apps-from-wim
$apps=@( 	
    #Unnecessary Windows 10 AppX Apps
    "*Microsoft.BingNews*"
    "*Microsoft.GetHelp*"
    "*Microsoft.Getstarted*"
    "*Microsoft.Messaging*"
    "*Microsoft.Microsoft3DViewer*"
    "*Microsoft.MicrosoftOfficeHub*"
    "*Microsoft.MicrosoftSolitaireCollection*"
    "*Microsoft.NetworkSpeedTest*"
    "*Microsoft.Office.Sway*"
    "*Microsoft.OneConnect*"
    "*Microsoft.People*"
    "*Microsoft.Print3D*"
    "*Microsoft.SkypeApp*"
    "*Microsoft.WindowsFeedbackHub*"
    "*Microsoft.ZuneMusic*"
    "*Microsoft.ZuneVideo*"

    #Sponsored Windows 10 AppX Apps
    #Add sponsored/featured apps to remove in the "*AppName*" format
    "*EclipseManager*"
    "*ActiproSoftwareLLC*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Duolingo-LearnLanguagesforFree*"
    "*PandoraMediaInc*"
    "*CandyCrush*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Twitter*"
    "*Facebook*"

    "Microsoft.549981C3F5F10"
    "Microsoft.Office.OneNote"
)

foreach ($app in $apps) {
    Write-Host "  Trying... ${app}"
	Get-AppXProvisionedPackage -path $MOUNT_PATH | where DisplayName -like $app | Remove-AppxProvisionedPackage
    }