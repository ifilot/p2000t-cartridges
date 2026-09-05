param(
    [Parameter(Mandatory = $true)][string]$Port,
    [int]$Count = 3,
    [switch]$SelfTest
)
$ErrorActionPreference = 'Stop'
if ($Count -lt 1) { throw 'Count must be positive.' }
$serial = New-Object System.IO.Ports.SerialPort $Port, 115200, None, 8, One
$serial.DtrEnable = $true
$serial.ReadTimeout = 2000
$serial.WriteTimeout = 2000

function Read-Exact([int]$Length) {
    $buffer = New-Object byte[] $Length
    $offset = 0
    $timer = [Diagnostics.Stopwatch]::StartNew()
    while ($offset -lt $Length) {
        if ($timer.ElapsedMilliseconds -ge 3000) { throw "Incomplete reply: $offset/$Length bytes" }
        $offset += $serial.Read($buffer, $offset, $Length - $offset)
    }
    return ,$buffer
}

function Receive-Reply([string]$Command, [int]$PayloadLength) {
    $echo = [Text.Encoding]::ASCII.GetString((Read-Exact 8))
    if ($echo -cne $Command) { throw "Command echo mismatch: expected $Command, received $echo" }
    return ,(Read-Exact $PayloadLength)
}

function Request([string]$Command, [int]$PayloadLength) {
    # Write, not WriteLine: the protocol is eight bytes, without a terminator.
    $serial.Write($Command)
    return ,(Receive-Reply $Command $PayloadLength)
}

function Check-ID([byte[]]$ID) {
    $value = '{0:X2} {1:X2}' -f $ID[0], $ID[1]
    if ($ID[0] -ne 0xbf -or $ID[1] -ne 0xb6) {
        throw "Unexpected ID $value; expected BF B6 (SST39SF020). Check chip, power selection and wiring."
    }
    Write-Host "SST39SF020: manufacturer BF, device B6"
}

try {
    $serial.Open()
    Start-Sleep -Milliseconds 100 # allow the host's DTR control transfer to settle
    $info = Request 'READINFO' 16
    $boardInfo = [Text.Encoding]::ASCII.GetString($info)
    if ($boardInfo -cne 'P2000T-32U4 V003') { throw "Unexpected board/version reply: $boardInfo" }
    Write-Host $boardInfo
    for ($i = 0; $i -lt $Count; ++$i) {
        Check-ID (Request 'DEVIDSST' 2)
    }
    if ($SelfTest) {
        # An unsupported command must be rejected without touching the flash.
        $errorReply = [Text.Encoding]::ASCII.GetString((Request 'BADCMAND' 8))
        if ($errorReply -cne 'ERRORCMD') { throw 'Unknown-command response failed.' }
        $serial.Write('DEVI')
        Start-Sleep -Milliseconds 50
        $serial.Write('DSST')
        Check-ID (Receive-Reply 'DEVIDSST' 2)
        $serial.Write('DEVI')
        Start-Sleep -Milliseconds 1200
        Check-ID (Request 'DEVIDSST' 2)
        $serial.Write('DEVIDSSTDEVIDSST')
        Check-ID (Receive-Reply 'DEVIDSST' 2)
        Check-ID (Receive-Reply 'DEVIDSST' 2)
        $serial.Write('DEVI')
        Start-Sleep -Milliseconds 50
        $serial.DtrEnable = $false
        Start-Sleep -Milliseconds 100
        $serial.DtrEnable = $true
        Start-Sleep -Milliseconds 100
        Check-ID (Request 'DEVIDSST' 2)
        Write-Host 'Hardware protocol tests passed.'
    }
} finally {
    if ($serial.IsOpen) { $serial.Close() }
    $serial.Dispose()
}
