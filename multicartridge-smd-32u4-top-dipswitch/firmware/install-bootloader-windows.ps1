param(
    [string]$Avrdude = "$env:LOCALAPPDATA\Arduino15\packages\arduino\tools\avrdude\8.0.0-arduino1\bin\avrdude.exe",
    [string]$Config = ""
)
$ErrorActionPreference = 'Stop'
if (-not $Config) { $Config = Join-Path (Split-Path (Split-Path $Avrdude)) 'etc\avrdude.conf' }
$hex = Join-Path $PSScriptRoot 'build\combined.hex'
foreach ($path in @($Avrdude, $Config, $hex)) {
    if (-not (Test-Path $path)) { throw "Missing file: $path" }
}
$common = @('-C', $Config, '-c', 'usbasp', '-p', 'atmega32u4')
function Invoke-Avrdude([string[]]$Operations) {
    & $Avrdude @common @Operations
    if ($LASTEXITCODE -ne 0) { throw "AVRDUDE failed (exit $LASTEXITCODE)" }
}

$backup = Join-Path $PSScriptRoot ('backups\' + (Get-Date -Format 'yyyyMMdd-HHmmss-fff'))
New-Item -ItemType Directory -Path $backup | Out-Null
# Keep complete dumps, including trailing FF bytes. Locked dumps are NOT backups.
Invoke-Avrdude -Operations @('-n', '-A', '-U', "flash:r:$backup\flash.bin:r",
    '-U', "eeprom:r:$backup\eeprom.bin:r", '-U', "lfuse:r:$backup\lfuse.txt:h",
    '-U', "hfuse:r:$backup\hfuse.txt:h", '-U', "efuse:r:$backup\efuse.txt:h",
    '-U', "lock:r:$backup\lock.txt:h")
function Read-Setting([string]$Name) {
    return [Convert]::ToInt32((Get-Content (Join-Path $backup "$Name.txt") -Raw).Trim(), 16)
}
$low = Read-Setting 'lfuse'
$high = Read-Setting 'hfuse'
$extended = Read-Setting 'efuse'
$lock = Read-Setting 'lock'
# This script is for the inspected board, with the 16 MHz crystal and app reset vector.
if ($low -ne 0x5e -or ($high -notin @(0x99, 0x98)) -or (($extended -band 0x0f) -notin @(3, 11))) {
    throw 'Unexpected fuse settings. Inspect the saved readings before adapting this script.'
}
if (($lock -band 3) -ne 3) {
    'Device was locked: memory dumps may not contain the original contents.' |
        Set-Content (Join-Path $backup 'LOCKED-NOT-A-RESTORABLE-BACKUP.txt')
    Write-Warning 'Existing memory is locked; installing firmware erases it and clears the locks.'
}
# Chip erase also erases internal EEPROM with the current EESAVE fuse.
# Boot at 0x7000: BOOTRST enabled (99 -> 98), HWBE disabled, ISP unchanged.
# AVRDUDE automatically verifies flash and the fuse write; never use -V or -F here.
Invoke-Avrdude -Operations @('-e', '-U', "flash:w:${hex}:i", '-U', 'efuse:w:0xfb:m', '-U', 'hfuse:w:0x98:m')
Invoke-Avrdude -Operations @('-n', '-U', "lfuse:r:$backup\after-lfuse.txt:h",
    '-U', "hfuse:r:$backup\after-hfuse.txt:h", '-U', "efuse:r:$backup\after-efuse.txt:h",
    '-U', "lock:r:$backup\after-lock.txt:h")
if ((Read-Setting 'after-lfuse') -ne $low -or
    (Read-Setting 'after-hfuse') -ne 0x98 -or
    (((Read-Setting 'after-efuse') -band 0x0f) -ne 0x0b) -or
    (((Read-Setting 'after-lock') -band 0x3f) -ne 0x3f)) {
    throw 'Post-flash fuse/lock check failed; inspect the saved readings.'
}
Write-Host "Flash and fuse verified. Readings saved in $backup"
