$ErrorActionPreference = "Stop"
$src = Join-Path $PSScriptRoot "Arduino\GigaBasic_MeanMachine_QSPI_REV11"
$dstRoot = Join-Path $env:USERPROFILE "Documents\Arduino"
$dst = Join-Path $dstRoot "GigaBasic_MeanMachine_QSPI_REV11"
New-Item -ItemType Directory -Force -Path $dstRoot | Out-Null
if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
Copy-Item $src $dst -Recurse
Write-Host "Installed REV11 sketch to: $dst" -ForegroundColor Green
Write-Host "Open this in Arduino IDE:" -ForegroundColor Cyan
Write-Host "  $dst\GigaBasic_MeanMachine_QSPI_REV11.ino"
