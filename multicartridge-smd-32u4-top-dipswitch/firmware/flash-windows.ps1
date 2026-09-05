param(
    [string]$Port = '',
    [string]$BootPort = '',
    [string]$Image = '',
    [string]$Avrdude = "$env:LOCALAPPDATA\Arduino15\packages\arduino\tools\avrdude\8.0.0-arduino1\bin\avrdude.exe",
    [string]$Config = ''
)
. "$PSScriptRoot\serial-common.ps1"
if (-not $Image) { $Image = Join-Path $PSScriptRoot 'build\cartridge.hex' }
if (-not $Config) { $Config = Join-Path (Split-Path (Split-Path $Avrdude)) 'etc\avrdude.conf' }
foreach ($file in @($Image,$Avrdude,$Config)) { if (-not (Test-Path $file)) { throw "Missing $file" } }
Assert-ApplicationHex $Image
if (-not $BootPort) { $BootPort = Find-CartridgePort '204A' }
if (-not $BootPort) {
    if (-not $Port) { $Port = Find-CartridgePort }
    if (-not $Port) { throw 'No application port. Reset/reconnect for the boot window, or specify -BootPort.' }
    $s = Open-CartridgePort $Port
    try { Send-Command $s 'BOOTLOAD'; Read-Status $s } finally { $s.Close(); $s.Dispose() }
    $timer = [Diagnostics.Stopwatch]::StartNew()
    while (-not $BootPort -and $timer.ElapsedMilliseconds -lt 15000) {
        Start-Sleep -Milliseconds 250
        $BootPort = Find-CartridgePort '204A'
    }
}
if (-not $BootPort) { throw 'Bootloader did not enumerate.' }
Write-Host "Uploading via USB bootloader on $BootPort"
# Erase only application flash; bootloader enforces its own address boundary.
& $Avrdude -C $Config -p atmega32u4 -c avr109 -P $BootPort -b 57600 -e -U "flash:w:${Image}:i"
if ($LASTEXITCODE -ne 0) { throw "USB firmware update failed ($LASTEXITCODE). Bootloader remains available for recovery." }
$timer = [Diagnostics.Stopwatch]::StartNew(); $app = $null
while (-not $app -and $timer.ElapsedMilliseconds -lt 15000) {
    Start-Sleep -Milliseconds 250
    $app = Find-CartridgePort
}
if (-not $app) { throw 'Flash verified, but application did not enumerate.' }
$s = Open-CartridgePort $app
try {
    Send-Command $s 'READINFO'
    Write-Host ([Text.Encoding]::ASCII.GetString((Read-Bytes $s 16)))
} finally { $s.Close(); $s.Dispose() }
Write-Host "USB update verified; application is on $app"
