$ErrorActionPreference = 'SilentlyContinue'
# Get the latest tag.
$Tag = (Invoke-RestMethod -Uri "https://api.github.com/repos/SpacingBat3/WebCord/releases")[0].tag_name
$Version = $Tag.Trim("v")

$Host.UI.RawUI.WindowTitle="WebCord Installer - Aetopia"
Write-Output "WebCord made by SpacingBat3: https://github.com/SpacingBat3/WebCord"
Write-Output "Downloading WebCord ($Tag)..."

#Download WebCord.
if($env:PROCESSOR_ARCHITECTURE -eq "x86"){
    $Download = "https://github.com/SpacingBat3/WebCord/releases/latest/download/WebCord-win32-ia32-$Version.zip"
}
else {
    $Download = "https://github.com/SpacingBat3/WebCord/releases/latest/download/WebCord-win32-x64-$Version.zip"
}
$DownloadOutput = "$env:TEMP\WebCord$Version.zip"
curl.exe -# -L $Download -output $DownloadOutput

#Extract WebCord.
$InstallDirectory = "$env:APPDATA\WebCord"
Write-Output "Extracting WebCord ($Tag)..."
New-Item -Path "$InstallDirectory" -ItemType "Directory" -Force | Out-Null
Stop-Process -Name "webcord" -Force -ErrorAction Ignore
Expand-Archive -Path $DownloadOutput -DestinationPath "$InstallDirectory" -Force
Write-Output "WebCord $Tag Installed."

# Create a Shortcut in the Start Menu.
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\WebCord.lnk")
$Shortcut.TargetPath = "$InstallDirectory\webcord.exe"
$Shortcut.Save()

# Start WebCord.
cmd /c start "$InstallDirectory\webcord.exe"
