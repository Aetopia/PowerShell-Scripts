cls
$Host.UI.RawUI.WindowTitle = "Lunar Client Lite Installer - Aetopia"
Import-Module BitsTransfer
$ErrorActionPreference = 'SilentlyContinue'
Write-Output "Installation Options"
Write-Output ""
Write-Output "
---LCL Flavors---

1. Install/Update LCLPy (CLI Based Launcher made in Python.)
2. Install/Update LCL (GUI Based Launcher made in AHK.)

---JRE---

3. Install LCLPy + GraalVM (Recommended)
4. Install LCL + GraalVM

---Uninstall---

5. LCLPy
6. LCL
7. GraalVM"
CHOICE /C 1234567 /N
# LCLPy
switch ($LASTEXITCODE){
1{
cls
Write-Output "Installing LCLPy..."
Write-Output ""
Start-BitsTransfer -DisplayName "Downloading LCLPy..." -Description " " "https://github.com/Aetopia/LCLPy/releases/latest/download/LCLPy.exe" "$env:LOCALAPPDATA\Microsoft\WindowsApps\LCLPy.exe"
Write-Output "LCLPy Installed."
Write-Output ""
cmd /c lclpy.exe -h
pause
}
# LCL
2{
cls
irm raw.githubusercontent.com/couleur-tweak-tips/utils/main/Installers/LunarClientLite.ps1|iex
}

# LCLPy + GraalVM
3{
cls
if (!(Test-Path -LiteralPath "$env:ProgramData\GraalVM")){
Write-Output "Installing GraalVM..."
Start-BitsTransfer -DisplayName "Downloading GraalVM..." -Description " " "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java16-windows-amd64-21.2.0.zip" "$env:TEMP\GraalVM.zip"
Write-Output "Extracting GraalVM..."
Expand-Archive -Path "$env:TEMP\GraalVM.zip" -DestinationPath "$env:ProgramData" -Force
Rename-Item "$env:ProgramData\graalvm-ce-java16-21.2.0" "$env:ProgramData\GraalVM"
Write-Output "GraalVM Installed!"
}
else {
Write-Output "GraalVM is already installed..."
}
Write-Output "Installing LCLPy..."
Start-BitsTransfer -DisplayName "Downloading LCLPy..." -Description " " "https://github.com/Aetopia/LCLPy/releases/latest/download/LCLPy.exe" "$env:LOCALAPPDATA\Microsoft\WindowsApps\LCLPy.exe"
Write-Output 'Setting up "Options.ini"...'
Remove-Item "$env:LOCALAPPDATA\Microsoft\WindowsApps\Options.ini" -Force
"[Minecraft]
1.7 directory = $env:APPDATA\.minecraft
1.8 directory = $env:APPDATA\.minecraft
1.12 directory = $env:APPDATA\.minecraft
1.16 directory = $env:APPDATA\.minecraft
1.17 directory = $env:APPDATA\.minecraft
1.18 directory = $env:APPDATA\.minecraft

[Java]
arguments = -Xms3G -Xmx3G -Xmn1G -XX:+DisableAttachMechanism -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+EagerJVMCI -Djvmci.Compiler=graal
1.7 java = $env:ProgramData\GraalVM\bin\javaw.exe
1.8 java = $env:ProgramData\GraalVM\bin\javaw.exe
1.12 java = $home\.lunarclient\jre\zulu16.30.15-ca-fx-jre16.0.1-win_x64\bin\javaw.exe
1.16 java = $home\.lunarclient\jre\zulu16.30.15-ca-fx-jre16.0.1-win_x64\bin\javaw.exe
1.17 java = $home\.lunarclient\jre\zulu16.30.15-ca-fx-jre16.0.1-win_x64\bin\javaw.exe
1.18 java = $home\.lunarclient\jre\zulu16.30.15-ca-fx-jre16.0.1-win_x64\bin\javaw.exe

[Optimizations]
lc cosmetics = Off" | Set-Content "$home\Options.ini"
Write-Output "LCLPy + GraalVM Installed."
Write-Output ""
cmd /c lclpy.exe -h
Remove-Item "Options.ini" -Force
pause
}

# LCL + GraalVM
4{
cls
irm https://github.com/couleur-tweak-tips/utils/raw/main/Installers/GraalVM.ps1 | iex
}

# Uninstall
5{
cls
Write-Output "Removing LCLPy..."
Remove-Item "$env:LOCALAPPDATA\Microsoft\WindowsApps\LCLPy.exe" -Force
Remove-Item "$home\Options.ini" -Force
Write-Output "Finished."
pause
}
6{
cls
Write-Output "Removing LCL..."
Remove-Item "$env:ProgramData\GraalVM" -Force -Recurse
Remove-Item "$env:LOCALAPPDATA\Microsoft\WindowsApps\LCL.exe" -Force
Remove-Item "$env:LOCALAPPDATA\Microsoft\WindowsApps\Config.ini" -Force
Remove-Item "$env:LOCALAPPDATA\Microsoft\WindowsApps\Resources" -Force -Recurse
Write-Output "Finished."
pause
}
7{
cls
Write-Output "Removing GraalVM..."
Remove-Item "$env:ProgramData\GraalVM" -Force -Recurse
Write-Output "Finished."
pause
}
}