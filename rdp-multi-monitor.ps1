#########################################################################################
# This script will modify downloaded RDP files to launch sessions on multiple monitors. #
# IMPORTANT: only run this script AFTER you download the RDP file!                      #
#########################################################################################

$ErrorActionPreference = "Stop"

# CD into downloads folder to capture correct file
Set-Location "C:\Users\$env:UserName\Downloads"
Get-ChildItem -Path .\* -Include LaunchRDPMultiMonitor.rdp -Recurse | 
Remove-Item -Force
$newest = (Get-ChildItem -Attributes !Directory *.rdp |
    Sort-Object -Descending -Property LastWriteTime |
    Select-Object -First 1)
Rename-Item -Path $newest.Name -NewName "LaunchRDPMultiMonitor.rdp"
Add-Content -Path LaunchRDPMultiMonitor.rdp -Value "`nuse multimon:i:1"

# Uncomment next line to enable microphone
#Add-Content -Path LaunchRDPMultiMonitor.rdp -Value "`naudiocapturemode:i:1"

# Uncomment next line to select only specified monitors for the RDP session
Add-Content -Path LaunchRDPMultiMonitor.rdp -Value "`nselectedmonitors:s:1,2"

Write-Host "RDP file successfully updated to support multiple monitors..."
Start-Sleep -Seconds 2
Clear-Host
Write-Host "Opening RDP session..."
Invoke-Item .\LaunchRDPMultiMonitor.rdp
Start-Sleep -Seconds 2
