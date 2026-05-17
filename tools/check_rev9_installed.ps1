$sketch = Join-Path $env:USERPROFILE "Documents\Arduino\GigaBasic_MeanMachine_QSPI_REV11\GigaBasic_MeanMachine_QSPI_REV11.ino"
$hardware = Join-Path $env:USERPROFILE "Documents\Arduino\GigaBasic_MeanMachine_QSPI_REV11\hardware.h"

Write-Host "Checking installed REV11 sketch..."
Write-Host "Sketch: $sketch"

if (!(Test-Path $sketch)) {
    Write-Host "NOT FOUND. Run install_to_arduino_sketchbook_REV11.ps1 first." -ForegroundColor Red
    exit 1
}

Select-String $sketch -Pattern "GIGA BASIC MEAN MACHINE REV11" | ForEach-Object { $_.Line }
Select-String $hardware -Pattern "GIGA_BASIC_MEANMACHINE_REV11|GIGAQSPIFS" | ForEach-Object { $_.Line }

Write-Host "If you see REV11 and GIGAQSPIFS above, the correct sketch is installed." -ForegroundColor Green
