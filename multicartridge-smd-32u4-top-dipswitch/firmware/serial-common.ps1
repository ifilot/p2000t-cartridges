$ErrorActionPreference = 'Stop'
if (-not ('P2000Bytes' -as [type])) {
    Add-Type -TypeDefinition @'
using System;
public static class P2000Bytes {
    public static ushort Crc(byte[] b) {
        ushort c = 0;
        foreach (byte v in b) { c ^= (ushort)(v << 8); for (int i=0;i<8;i++) c=(ushort)((c & 0x8000)!=0 ? (c<<1)^0x1021 : c<<1); }
        return c;
    }
    public static byte[] Pattern() {
        var b=new byte[262144]; uint x=0x20003204;
        for(int i=0;i<b.Length;i++) { x^=x<<13; x^=x>>17; x^=x<<5; b[i]=(byte)x; }
        return b;
    }
    public static int Difference(byte[] a, byte[] b) {
        for(int i=0;i<a.Length;i++) if(a[i]!=b[i]) return i;
        return -1;
    }
}
'@
}
function Find-CartridgePort([string]$Product = '2044') {
    $devices = @(Get-PnpDevice -PresentOnly -Class Ports -ErrorAction SilentlyContinue |
        Where-Object { $_.InstanceId -match "VID_03EB&PID_$Product" })
    if ($devices.Count -gt 1) { throw "Multiple matching devices: specify a port." }
    if ($devices.Count -eq 1 -and $devices[0].FriendlyName -match '\((COM\d+)\)') { return $Matches[1] }
    return $null
}
function Open-CartridgePort([string]$Port) {
    $s = New-Object System.IO.Ports.SerialPort $Port, 115200, None, 8, One
    $s.DtrEnable = $true; $s.ReadTimeout = 5000; $s.WriteTimeout = 5000
    $s.Open()
    Start-Sleep -Milliseconds 100
    return $s
}
function Read-Bytes($Serial, [int]$Count) {
    $data = New-Object byte[] $Count
    $pos = 0
    $timer = [Diagnostics.Stopwatch]::StartNew()
    while ($pos -lt $Count) {
        if ($timer.ElapsedMilliseconds -gt 10000) { throw "Incomplete response ($pos/$Count)" }
        $pos += $Serial.Read($data, $pos, $Count - $pos)
    }
    return ,$data
}
function Send-Command($Serial, [string]$Command) {
    if ($Command.Length -ne 8) { throw 'Command must be exactly 8 ASCII bytes.' }
    $Serial.Write($Command)
    $echo = [Text.Encoding]::ASCII.GetString((Read-Bytes $Serial 8))
    if ($echo -cne $Command) { throw "Echo mismatch: $Command / $echo" }
}
function Read-Status($Serial) {
    $status = (Read-Bytes $Serial 1)[0]
    if ($status -ne 0) { throw "Device error $status (1=CRC, 2=address, 3=chip, 4=timeout, 5=verify, 6=needs erase, 7=payload timeout)" }
}
function Assert-ApplicationHex([string]$Path) {
    $base = 0; $bytes = 0; $ended = $false
    foreach ($line in [IO.File]::ReadAllLines($Path)) {
        if (-not $line) { continue }
        if ($ended -or -not $line.StartsWith(':') -or ($line.Length % 2) -ne 1) { throw 'Malformed HEX.' }
        $row = New-Object byte[] (($line.Length - 1) / 2)
        $sum = 0
        for ($i=0;$i -lt $row.Length;$i++) { $row[$i]=[Convert]::ToByte($line.Substring(1+2*$i,2),16); $sum+=$row[$i] }
        if ($row.Length -lt 5 -or $row.Length -ne $row[0]+5 -or ($sum -band 255)) { throw 'Bad HEX checksum/length.' }
        $address = 256 * [int]$row[1] + $row[2]
        switch ($row[3]) {
            0 { if ($base+$address+$row[0] -gt 0x7000) { throw 'Image overlaps bootloader or exceeds application flash.' }; $bytes += $row[0] }
            1 { $ended = $true }
            2 { if ($row[0] -ne 2) { throw 'Bad segment record.' }; $base = (256*[int]$row[4]+$row[5])*16 }
            4 { if ($row[0] -ne 2) { throw 'Bad linear record.' }; $base = (256*[long]$row[4]+$row[5])*65536 }
            3 { }
            5 { }
            default { throw 'Unsupported HEX record.' }
        }
    }
    if (-not $ended -or $bytes -eq 0) { throw 'Empty or incomplete HEX.' }
}
