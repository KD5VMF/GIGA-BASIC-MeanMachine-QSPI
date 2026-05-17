$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$src = Join-Path $repoRoot "Arduino\GigaBasic_MeanMachine_QSPI_REV11"
$arduinoDir = Join-Path $env:USERPROFILE "Documents\Arduino"
$dst = Join-Path $arduinoDir "GigaBasic_MeanMachine_QSPI_REV11"

if (!(Test-Path $src)) {
    throw "Source sketch folder not found: $src"
}

New-Item -ItemType Directory -Force -Path $arduinoDir | Out-Null

if (Test-Path $dst) {
    Write-Host "Removing old sketch folder: $dst"
    Remove-Item $dst -Recurse -Force
}

Write-Host "Copying REV11 sketch to Arduino sketchbook..."
Copy-Item $src $dst -Recurse

Write-Host ""
Write-Host "DONE. Open this exact file in Arduino IDE:"
Write-Host "  $dst\GigaBasic_MeanMachine_QSPI_REV11.ino"
Write-Host ""
Write-Host "Expected boot after upload:"
Write-Host "  IO: 0 1 16"
Write-Host "  GIGA BASIC MEAN MACHINE REV11 - onboard flash build"
Write-Host ""
Write-Host "Remember: run Arduino's STM32H747_System -> QSPIFormat first and choose LittleFS for the user-data partition."
