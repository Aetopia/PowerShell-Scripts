$Host.UI.RawUI.WindowTitle = "Blur GUI + CTT Blur Installer"
$ErrorActionPreference = 'SilentlyContinue'
Import-Module BitsTransfer
Write-Output "Installation Options

1. Blur GUI + CTT Blur Installer
2. Blur GUI Only (Replaces blurconf.bat with an AHK GUI.)

"
CHOICE /C 12 /N
switch ($LASTEXITCODE){
1 {
cls
Remove-Item "$env:APPDATA\BlurConfig" -Force -Recurse
if (!(Test-Path "C:\Program Files\AutoHotkey")){
Write-Output "Installing AutoHotkey..."
Start-BitsTransfer -DisplayName "Downloading AutoHotkey" -Description " " "https://www.autohotkey.com/download/ahk-install.exe" "$env:TEMP\AutoHotkey.exe"
Start-Process "$env:TEMP\AutoHotkey.exe" -Wait
}
Start-BitsTransfer -DisplayName 'Downloading "BlurGUI.ahk"...' -Description " " "https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/Miscellaneous/BlurGUI.ahk" "$env:APPDATA\Microsoft\Windows\SendTo\BlurGUI.ahk"
cls
# CTT's Blur Installer
irm https://github.com/couleur-tweak-tips/utils/raw/main/Installers/blur.ps1 | iex
}
2{
cls
Remove-Item "$env:APPDATA\BlurConfig" -Force -Recurse
if (!(Test-Path "C:\Program Files\AutoHotkey")){
Write-Output "Installing AutoHotkey..."
Start-BitsTransfer -DisplayName "Downloading AutoHotkey" -Description " " "https://www.autohotkey.com/download/ahk-install.exe" "$env:TEMP\AutoHotkey.exe"
Start-Process "$env:TEMP\AutoHotkey.exe" -Wait
}
Start-BitsTransfer -DisplayName 'Downloading "BlurGUI.ahk"...' -Description " " "https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/Miscellaneous/BlurGUI.ahk" "$env:APPDATA\Microsoft\Windows\SendTo\BlurGUI.ahk"
Write-Output '"BlurGUI.ahk" installed.'
pause
}
}
