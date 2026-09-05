param([string]$Port = '')
. "$PSScriptRoot\..\serial-common.ps1"
if (-not $Port) { $Port = Find-CartridgePort }
if (-not $Port) { throw 'No cartridge.' }
$s = Open-CartridgePort $Port
function Block0 {
    Send-Command $s 'RDBK0000'; Read-Status $s
    $data = Read-Bytes $s 256; $crc = Read-Bytes $s 2
    if ([P2000Bytes]::Crc($data) -ne (256*[int]$crc[0]+$crc[1])) { throw 'Read CRC failed' }
    return ,$data
}
try {
    $before = Block0
    $payload = New-Object byte[] 258
    for ($i=0;$i -lt 256;$i++) { $payload[$i]=255 }
    $crc = [P2000Bytes]::Crc([byte[]]$payload[0..255])
    $payload[256]=$crc -shr 8; $payload[257]=($crc -band 255) -bxor 1
    Send-Command $s 'WRBK0000'; Read-Status $s
    $s.Write($payload,0,258)
    if ((Read-Bytes $s 1)[0] -ne 1) { throw 'Bad CRC not rejected' }
    Send-Command $s 'WRBK0400'
    if ((Read-Bytes $s 1)[0] -ne 2) { throw 'Invalid address not rejected' }
    Send-Command $s 'WRBK0000'; Read-Status $s
    $s.Write($payload,0,50)
    Start-Sleep -Milliseconds 2200
    if ((Read-Bytes $s 1)[0] -ne 7) { throw 'Incomplete payload did not time out' }
    $s.Write('ERASEALL') # must be ignored while stream is poisoned
    Start-Sleep -Milliseconds 100
    if ($s.BytesToRead -ne 0) { throw 'Poisoned stream accepted a command' }
    $s.DtrEnable=$false; Start-Sleep -Milliseconds 100
    $s.DtrEnable=$true; Start-Sleep -Milliseconds 100
    $after = Block0
    if ([P2000Bytes]::Difference($before,$after) -ne -1) { throw 'Rejected write modified block 0' }
    # With the test pattern installed this requests forbidden zero-to-one changes.
    $payload[257]=$crc -band 255
    Send-Command $s 'WRBK0000'; Read-Status $s
    $s.Write($payload,0,258)
    if ((Read-Bytes $s 1)[0] -ne 6) { throw 'Zero-to-one write was not rejected' }
    $after = Block0
    if ([P2000Bytes]::Difference($before,$after) -ne -1) { throw 'Rejected zero-to-one write modified flash' }
    Write-Host 'PASS: CRC, bounds, payload timeout/isolation, and erase-precondition checks; block unchanged.'
} finally { $s.Close(); $s.Dispose() }
