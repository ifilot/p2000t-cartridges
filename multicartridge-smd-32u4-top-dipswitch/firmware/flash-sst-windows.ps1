param(
    [string]$Port = '',
    [string]$Image = '',
    [switch]$TestPattern,
    [switch]$VerifyOnly,
    [string]$Readback = ''
)
. "$PSScriptRoot\serial-common.ps1"
if (([bool]$Image) -eq ([bool]$TestPattern)) { throw 'Specify exactly one of -Image or -TestPattern.' }
if ($TestPattern) { $expected = [P2000Bytes]::Pattern() }
else {
    $inputBytes = [IO.File]::ReadAllBytes((Resolve-Path $Image).Path)
    if ($inputBytes.Length -lt 1 -or $inputBytes.Length -gt 262144) { throw 'Image must contain 1..262144 bytes.' }
    $expected = New-Object byte[] 262144
    for ($i=0;$i -lt $expected.Length;$i++) { $expected[$i]=255 }
    [Array]::Copy($inputBytes,$expected,$inputBytes.Length)
}
if (-not $Port) { $Port = Find-CartridgePort }
if (-not $Port) { throw 'Cartridge serial port not found.' }
$s = Open-CartridgePort $Port
try {
    Send-Command $s 'READINFO'
    $info = [Text.Encoding]::ASCII.GetString((Read-Bytes $s 16))
    if ($info -cne 'P2000T-32U4 V003') { throw "Unsupported firmware: $info" }
    Send-Command $s 'DEVIDSST'; $id = Read-Bytes $s 2
    if ($id[0] -ne 0xbf -or $id[1] -ne 0xb6) { throw 'Expected SST39SF020 (BF B6).' }
    if (-not $VerifyOnly) {
        Write-Host 'Erasing SST39SF020...'
        Send-Command $s 'ERASEALL'; Read-Status $s
        for ($block=0;$block -lt 1024;$block++) {
            $chunk = New-Object byte[] 256
            [Array]::Copy($expected,$block*256,$chunk,0,256)
            $crc = [P2000Bytes]::Crc($chunk)
            $payload = New-Object byte[] 258
            [Array]::Copy($chunk,$payload,256)
            $payload[256] = $crc -shr 8; $payload[257] = $crc -band 255
            Send-Command $s ('WRBK{0:X4}' -f $block); Read-Status $s
            $s.Write($payload,0,258); Read-Status $s
            if (($block % 64) -eq 63) { Write-Host "Written $($block+1)/1024 blocks" }
        }
    }
    Write-Host 'Reading back all 262144 bytes...'
    $actual = New-Object byte[] 262144
    for ($block=0;$block -lt 1024;$block++) {
        Send-Command $s ('RDBK{0:X4}' -f $block); Read-Status $s
        $chunk = Read-Bytes $s 256; $wireCrc = Read-Bytes $s 2
        $crc = 256*[int]$wireCrc[0]+$wireCrc[1]
        if ([P2000Bytes]::Crc($chunk) -ne $crc) { throw "Read CRC mismatch at block $block" }
        [Array]::Copy($chunk,0,$actual,$block*256,256)
        if (($block % 128) -eq 127) { Write-Host "Read $($block+1)/1024 blocks" }
    }
    if ($Readback) { [IO.File]::WriteAllBytes($Readback,$actual) }
    $difference = [P2000Bytes]::Difference($expected,$actual)
    if ($difference -ge 0) { throw ('Read-back mismatch at 0x{0:X5}: expected {1:X2}, got {2:X2}' -f $difference,$expected[$difference],$actual[$difference]) }
    $sha = [Security.Cryptography.SHA256]::Create()
    try { $hash = [BitConverter]::ToString($sha.ComputeHash($actual)).Replace('-','').ToLowerInvariant() } finally { $sha.Dispose() }
    Write-Host "PASS: all 262144 bytes match. SHA256 $hash"
} finally { $s.Close(); $s.Dispose() }
