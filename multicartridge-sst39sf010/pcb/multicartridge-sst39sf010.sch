EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "P2000T Multirom Cartridge"
Date "2021-08-14"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 3750 2150 0    50   Input ~ 0
A12C
Text GLabel 2850 1700 2    50   Input ~ 0
D0
Text GLabel 2850 1900 2    50   Input ~ 0
D2
Text GLabel 2850 2100 2    50   Input ~ 0
D4
Text GLabel 2850 2300 2    50   Input ~ 0
D6
Text GLabel 2850 1800 2    50   Input ~ 0
D1
Text GLabel 2850 2000 2    50   Input ~ 0
D3
Text GLabel 2850 2200 2    50   Input ~ 0
D5
Text GLabel 2850 2400 2    50   Input ~ 0
D7
$Comp
L power:GND #PWR08
U 1 1 60F95D08
P 2250 4100
F 0 "#PWR08" H 2250 3850 50  0001 C CNN
F 1 "GND" H 2255 3927 50  0000 C CNN
F 2 "" H 2250 4100 50  0001 C CNN
F 3 "" H 2250 4100 50  0001 C CNN
	1    2250 4100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR07
U 1 1 60F96777
P 2250 1600
F 0 "#PWR07" H 2250 1450 50  0001 C CNN
F 1 "+5V" V 2265 1728 50  0000 L CNN
F 2 "" H 2250 1600 50  0001 C CNN
F 3 "" H 2250 1600 50  0001 C CNN
	1    2250 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 60FAC7F9
P 2250 1150
F 0 "C2" V 1998 1150 50  0000 C CNN
F 1 "0.1uF" V 2089 1150 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P5.00mm" H 2288 1000 50  0001 C CNN
F 3 "~" H 2250 1150 50  0001 C CNN
	1    2250 1150
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR06
U 1 1 60FAC7FF
P 2100 1150
F 0 "#PWR06" H 2100 900 50  0001 C CNN
F 1 "GND" V 2105 1022 50  0000 R CNN
F 2 "" H 2100 1150 50  0001 C CNN
F 3 "" H 2100 1150 50  0001 C CNN
	1    2100 1150
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR011
U 1 1 60FAC805
P 2400 1150
F 0 "#PWR011" H 2400 1000 50  0001 C CNN
F 1 "+5V" V 2415 1278 50  0000 L CNN
F 2 "" H 2400 1150 50  0001 C CNN
F 3 "" H 2400 1150 50  0001 C CNN
	1    2400 1150
	0    1    1    0   
$EndComp
Text GLabel 1650 1700 0    50   Input ~ 0
A0
Text GLabel 1650 1900 0    50   Input ~ 0
A2
Text GLabel 1650 2100 0    50   Input ~ 0
A4
Text GLabel 1650 2300 0    50   Input ~ 0
A6
Text GLabel 1650 2500 0    50   Input ~ 0
A8
Text GLabel 1650 2700 0    50   Input ~ 0
A10
Text GLabel 1650 2400 0    50   Input ~ 0
A7
Text GLabel 1650 2200 0    50   Input ~ 0
A5
Text GLabel 1650 2000 0    50   Input ~ 0
A3
Text GLabel 1650 1800 0    50   Input ~ 0
A1
Text GLabel 1650 2600 0    50   Input ~ 0
A9
Text GLabel 1650 2800 0    50   Input ~ 0
A11
Text GLabel 1450 3900 0    50   Input ~ 0
~CS
$Comp
L power:PWR_FLAG #FLG01
U 1 1 60FB66E2
P 10200 5800
F 0 "#FLG01" H 10200 5875 50  0001 C CNN
F 1 "PWR_FLAG" H 10200 5973 50  0000 C CNN
F 2 "" H 10200 5800 50  0001 C CNN
F 3 "~" H 10200 5800 50  0001 C CNN
	1    10200 5800
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR030
U 1 1 60FB72A7
P 10200 5800
F 0 "#PWR030" H 10200 5650 50  0001 C CNN
F 1 "+5V" H 10215 5973 50  0000 C CNN
F 2 "" H 10200 5800 50  0001 C CNN
F 3 "" H 10200 5800 50  0001 C CNN
	1    10200 5800
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR031
U 1 1 60FB8224
P 10650 5800
F 0 "#PWR031" H 10650 5550 50  0001 C CNN
F 1 "GND" H 10655 5627 50  0000 C CNN
F 2 "" H 10650 5800 50  0001 C CNN
F 3 "" H 10650 5800 50  0001 C CNN
	1    10650 5800
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 60FB8E2D
P 10650 5800
F 0 "#FLG02" H 10650 5875 50  0001 C CNN
F 1 "PWR_FLAG" H 10650 5973 50  0000 C CNN
F 2 "" H 10650 5800 50  0001 C CNN
F 3 "~" H 10650 5800 50  0001 C CNN
	1    10650 5800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U3
U 1 1 61041DA7
P 4300 2150
F 0 "U3" H 4300 2475 50  0000 C CNN
F 1 "74HC00" H 4300 2384 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4300 2150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 4300 2150 50  0001 C CNN
	1    4300 2150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U3
U 2 1 61043DCF
P 4300 2700
F 0 "U3" H 4300 3025 50  0000 C CNN
F 1 "74HC00" H 4300 2934 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4300 2700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 4300 2700 50  0001 C CNN
	2    4300 2700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U3
U 4 1 61046A23
P 4300 1550
F 0 "U3" H 4300 1875 50  0000 C CNN
F 1 "74HC00" H 4300 1784 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4300 1550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 4300 1550 50  0001 C CNN
	4    4300 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 2700 3850 2700
Wire Wire Line
	3850 2700 3850 2600
Wire Wire Line
	3850 2600 4000 2600
Wire Wire Line
	3850 2700 3850 2800
Wire Wire Line
	3850 2800 4000 2800
Connection ~ 3850 2700
Wire Wire Line
	3850 1450 4000 1450
Wire Wire Line
	3850 1650 4000 1650
Wire Wire Line
	3750 2150 3850 2150
Wire Wire Line
	3850 2150 3850 2050
Wire Wire Line
	3850 2050 4000 2050
Wire Wire Line
	3850 2150 3850 2250
Wire Wire Line
	3850 2250 4000 2250
Connection ~ 3850 2150
$Comp
L 74xx:74HC00 U3
U 5 1 61068544
P 4650 3400
F 0 "U3" V 4550 3400 50  0000 C CNN
F 1 "74HC00" V 4750 3400 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 4650 3400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 4650 3400 50  0001 C CNN
	5    4650 3400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR017
U 1 1 6106A3F4
P 4150 3400
F 0 "#PWR017" H 4150 3150 50  0001 C CNN
F 1 "GND" V 4155 3272 50  0000 R CNN
F 2 "" H 4150 3400 50  0001 C CNN
F 3 "" H 4150 3400 50  0001 C CNN
	1    4150 3400
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR021
U 1 1 6106B04C
P 5150 3400
F 0 "#PWR021" H 5150 3250 50  0001 C CNN
F 1 "+5V" V 5165 3528 50  0000 L CNN
F 2 "" H 5150 3400 50  0001 C CNN
F 3 "" H 5150 3400 50  0001 C CNN
	1    5150 3400
	0    1    1    0   
$EndComp
$Comp
L Device:C C5
U 1 1 6106CB1F
P 4650 3950
F 0 "C5" V 4398 3950 50  0000 C CNN
F 1 "C" V 4489 3950 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P5.00mm" H 4688 3800 50  0001 C CNN
F 3 "~" H 4650 3950 50  0001 C CNN
	1    4650 3950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR018
U 1 1 6106DCC5
P 4500 3950
F 0 "#PWR018" H 4500 3700 50  0001 C CNN
F 1 "GND" V 4505 3822 50  0000 R CNN
F 2 "" H 4500 3950 50  0001 C CNN
F 3 "" H 4500 3950 50  0001 C CNN
	1    4500 3950
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR020
U 1 1 6106E0C5
P 4800 3950
F 0 "#PWR020" H 4800 3800 50  0001 C CNN
F 1 "+5V" V 4815 4078 50  0000 L CNN
F 2 "" H 4800 3950 50  0001 C CNN
F 3 "" H 4800 3950 50  0001 C CNN
	1    4800 3950
	0    1    1    0   
$EndComp
$Comp
L Memory_Flash:SST39SF040 U1
U 1 1 60FFAD49
P 2250 2900
F 0 "U1" H 2250 3000 50  0000 C CNN
F 1 "SST39SF040" H 2300 2900 50  0000 C CNN
F 2 "Package_LCC:PLCC-32_THT-Socket" H 2250 3200 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/25022B.pdf" H 2250 3200 50  0001 C CNN
	1    2250 2900
	1    0    0    -1  
$EndComp
Text GLabel 1650 2900 0    50   Input ~ 0
A12
Text GLabel 1650 3000 0    50   Input ~ 0
A13
Text GLabel 1650 3100 0    50   Input ~ 0
A14
Text GLabel 1650 3200 0    50   Input ~ 0
A15
Text GLabel 1650 3300 0    50   Input ~ 0
A16
Text GLabel 1650 3400 0    50   Input ~ 0
A17
Text GLabel 850  3500 0    50   Input ~ 0
A18
Wire Wire Line
	1450 3900 1650 3900
$Comp
L 74xx:74HC00 U3
U 3 1 61017C77
P 5100 1550
F 0 "U3" H 5100 1875 50  0000 C CNN
F 1 "74HC00" H 5100 1784 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket" H 5100 1550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 5100 1550 50  0001 C CNN
	3    5100 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 1550 4700 1550
Wire Wire Line
	4700 1550 4700 1450
Wire Wire Line
	4700 1450 4800 1450
Wire Wire Line
	4700 1550 4700 1650
Wire Wire Line
	4700 1650 4800 1650
Connection ~ 4700 1550
Text GLabel 10700 2450 2    50   Input ~ 0
A14
Text GLabel 10700 2550 2    50   Input ~ 0
A15
Text GLabel 10700 2650 2    50   Input ~ 0
A16
Text GLabel 10700 2750 2    50   Input ~ 0
A17
Text GLabel 10700 2850 2    50   Input ~ 0
A18
$Comp
L power:GND #PWR029
U 1 1 61086E27
P 9550 1800
F 0 "#PWR029" H 9550 1550 50  0001 C CNN
F 1 "GND" H 9555 1627 50  0000 C CNN
F 2 "" H 9550 1800 50  0001 C CNN
F 3 "" H 9550 1800 50  0001 C CNN
	1    9550 1800
	1    0    0    1   
$EndComp
Text GLabel 3850 1450 0    50   Input ~ 0
~CARSEL1
Text GLabel 3850 1650 0    50   Input ~ 0
~CARSEL2
$Comp
L power:GND #PWR02
U 1 1 61088C27
P 1250 4000
F 0 "#PWR02" H 1250 3750 50  0001 C CNN
F 1 "GND" H 1255 3827 50  0000 C CNN
F 2 "" H 1250 4000 50  0001 C CNN
F 3 "" H 1250 4000 50  0001 C CNN
	1    1250 4000
	0    1    1    0   
$EndComp
Text GLabel 3750 2700 0    50   Input ~ 0
~CARSEL2
Text Notes 3450 800  0    50   ~ 0
Adress line decoding
Wire Wire Line
	7700 2800 7700 3050
Wire Wire Line
	7600 2300 7600 2100
NoConn ~ 7700 2300
NoConn ~ 7800 2300
NoConn ~ 7800 2800
Text GLabel 7700 3050 3    50   Input ~ 0
~CARSEL1
Text GLabel 7600 2100 1    50   Input ~ 0
~CARSEL2
Text GLabel 7600 2800 3    50   Input ~ 0
A12C
Text GLabel 7500 2300 1    50   Input ~ 0
A11
Text GLabel 7400 2300 1    50   Input ~ 0
A9
Text GLabel 7500 2800 3    50   Input ~ 0
A10
Text GLabel 7400 2800 3    50   Input ~ 0
A8
Text GLabel 7300 2800 3    50   Input ~ 0
A6
Text GLabel 7200 2800 3    50   Input ~ 0
A4
Text GLabel 7100 2800 3    50   Input ~ 0
A2
Text GLabel 7000 2800 3    50   Input ~ 0
A0
Text GLabel 7000 2300 1    50   Input ~ 0
A1
Text GLabel 7100 2300 1    50   Input ~ 0
A3
Text GLabel 7200 2300 1    50   Input ~ 0
A5
Text GLabel 7300 2300 1    50   Input ~ 0
A7
$Comp
L power:GND #PWR023
U 1 1 60F90929
P 7900 2300
F 0 "#PWR023" H 7900 2050 50  0001 C CNN
F 1 "GND" H 7905 2127 50  0000 C CNN
F 2 "" H 7900 2300 50  0001 C CNN
F 3 "" H 7900 2300 50  0001 C CNN
	1    7900 2300
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR024
U 1 1 60F8FBE5
P 7900 2800
F 0 "#PWR024" H 7900 2550 50  0001 C CNN
F 1 "GND" H 7905 2627 50  0000 C CNN
F 2 "" H 7900 2800 50  0001 C CNN
F 3 "" H 7900 2800 50  0001 C CNN
	1    7900 2800
	-1   0    0    -1  
$EndComp
$Comp
L power:+5V #PWR022
U 1 1 60F8EF95
P 6500 2300
F 0 "#PWR022" H 6500 2150 50  0001 C CNN
F 1 "+5V" H 6515 2473 50  0000 C CNN
F 2 "" H 6500 2300 50  0001 C CNN
F 3 "" H 6500 2300 50  0001 C CNN
	1    6500 2300
	-1   0    0    -1  
$EndComp
Text GLabel 6900 2300 1    50   Input ~ 0
D7
Text GLabel 6800 2300 1    50   Input ~ 0
D5
Text GLabel 6700 2300 1    50   Input ~ 0
D3
Text GLabel 6900 2800 3    50   Input ~ 0
D6
Text GLabel 6800 2800 3    50   Input ~ 0
D4
Text GLabel 6700 2800 3    50   Input ~ 0
D2
Text GLabel 6600 2300 1    50   Input ~ 0
D1
Text GLabel 6600 2800 3    50   Input ~ 0
D0
$Comp
L Connector_Generic:Conn_02x15_Row_Letter_Last J1
U 1 1 60F53D0E
P 7200 2600
F 0 "J1" V 7250 3300 50  0000 R CNN
F 1 "P2000T_cartridge_edge" V 7250 3050 50  0000 R CNN
F 2 "p2000t_cartridge:p2000t_cartridge_edge" H 7200 2600 50  0001 C CNN
F 3 "~" H 7200 2600 50  0001 C CNN
	1    7200 2600
	0    -1   -1   0   
$EndComp
Wire Notes Line
	600  650  11050 650 
Text Notes 6150 800  0    50   ~ 0
Cartridge edge connection
Text Notes 750  800  0    50   ~ 0
Flash chip
Text Notes 8550 800  0    50   ~ 0
Address selection
Wire Wire Line
	1250 4000 1650 4000
Text GLabel 4600 2700 2    50   Input ~ 0
A13
Text GLabel 4600 2150 2    50   Input ~ 0
A12
Text GLabel 5400 1550 2    50   Input ~ 0
~CS
Wire Notes Line
	8300 4450 8300 650 
Wire Notes Line
	11050 650  11050 4450
Wire Notes Line
	600  4450 11050 4450
$Comp
L power:+5V #PWR04
U 1 1 611AC6AD
P 1650 3700
F 0 "#PWR04" H 1650 3550 50  0001 C CNN
F 1 "+5V" V 1665 3828 50  0000 L CNN
F 2 "" H 1650 3700 50  0001 C CNN
F 3 "" H 1650 3700 50  0001 C CNN
	1    1650 3700
	0    -1   -1   0   
$EndComp
$Comp
L Device:Jumper JP1
U 1 1 61167090
P 1150 3500
F 0 "JP1" H 1150 3764 50  0000 C CNN
F 1 "Jumper" H 1150 3673 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm" H 1150 3500 50  0001 C CNN
F 3 "~" H 1150 3500 50  0001 C CNN
	1    1150 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 3500 1650 3500
Wire Wire Line
	6500 2950 6500 2800
Text GLabel 6500 2950 3    50   Input ~ 0
~NMI
$Comp
L 74xx:74HC123 U2
U 1 1 6118E298
P 2850 5700
F 0 "U2" H 2850 6167 50  0000 C CNN
F 1 "74HC123" H 2850 6076 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 2850 5700 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT123.pdf" H 2850 5700 50  0001 C CNN
	1    2850 5700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC123 U2
U 3 1 6118FEAC
P 2850 6800
F 0 "U2" V 2483 6800 50  0000 C CNN
F 1 "74HC123" V 2574 6800 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 2850 6800 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT123.pdf" H 2850 6800 50  0001 C CNN
	3    2850 6800
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR014
U 1 1 61199B07
P 3350 6800
F 0 "#PWR014" H 3350 6650 50  0001 C CNN
F 1 "+5V" V 3365 6928 50  0000 L CNN
F 2 "" H 3350 6800 50  0001 C CNN
F 3 "" H 3350 6800 50  0001 C CNN
	1    3350 6800
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR010
U 1 1 6119AEDF
P 2350 6800
F 0 "#PWR010" H 2350 6550 50  0001 C CNN
F 1 "GND" H 2355 6627 50  0000 C CNN
F 2 "" H 2350 6800 50  0001 C CNN
F 3 "" H 2350 6800 50  0001 C CNN
	1    2350 6800
	0    1    1    0   
$EndComp
$Comp
L Device:C C3
U 1 1 6119C8BB
P 2850 7350
F 0 "C3" V 2598 7350 50  0000 C CNN
F 1 "0.1uF" V 2689 7350 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P5.00mm" H 2888 7200 50  0001 C CNN
F 3 "~" H 2850 7350 50  0001 C CNN
	1    2850 7350
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR012
U 1 1 6119C8C1
P 2700 7350
F 0 "#PWR012" H 2700 7100 50  0001 C CNN
F 1 "GND" V 2705 7222 50  0000 R CNN
F 2 "" H 2700 7350 50  0001 C CNN
F 3 "" H 2700 7350 50  0001 C CNN
	1    2700 7350
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR013
U 1 1 6119C8C7
P 3000 7350
F 0 "#PWR013" H 3000 7200 50  0001 C CNN
F 1 "+5V" V 3015 7478 50  0000 L CNN
F 2 "" H 3000 7350 50  0001 C CNN
F 3 "" H 3000 7350 50  0001 C CNN
	1    3000 7350
	0    1    1    0   
$EndComp
Text GLabel 5150 5900 2    50   Input ~ 0
~NMI
$Comp
L Switch:SW_Push SW1
U 1 1 611A4732
P 1300 5800
F 0 "SW1" H 1300 6085 50  0000 C CNN
F 1 "Soft Reset" H 1300 5994 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 1300 6000 50  0001 C CNN
F 3 "~" H 1300 6000 50  0001 C CNN
	1    1300 5800
	1    0    0    -1  
$EndComp
Wire Notes Line
	600  650  600  7600
Text Notes 700  4600 0    50   ~ 0
Soft reset
$Comp
L 74xx:74HC123 U2
U 2 1 611FFB80
P 4650 5700
F 0 "U2" H 4650 6167 50  0000 C CNN
F 1 "74HC123" H 4650 6076 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 4650 5700 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT123.pdf" H 4650 5700 50  0001 C CNN
	2    4650 5700
	1    0    0    -1  
$EndComp
NoConn ~ 3350 5900
NoConn ~ 5150 5500
Wire Wire Line
	1500 5800 1600 5800
$Comp
L power:+5V #PWR03
U 1 1 61213E8C
P 1350 5300
F 0 "#PWR03" H 1350 5150 50  0001 C CNN
F 1 "+5V" V 1365 5428 50  0000 L CNN
F 2 "" H 1350 5300 50  0001 C CNN
F 3 "" H 1350 5300 50  0001 C CNN
	1    1350 5300
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 61215637
P 1600 5450
F 0 "R1" H 1670 5496 50  0000 L CNN
F 1 "10k" H 1670 5405 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 1530 5450 50  0001 C CNN
F 3 "~" H 1600 5450 50  0001 C CNN
	1    1600 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 5600 1600 5800
Connection ~ 1600 5800
$Comp
L power:GND #PWR01
U 1 1 6121ACA2
P 1100 5800
F 0 "#PWR01" H 1100 5550 50  0001 C CNN
F 1 "GND" H 1105 5627 50  0000 C CNN
F 2 "" H 1100 5800 50  0001 C CNN
F 3 "" H 1100 5800 50  0001 C CNN
	1    1100 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	1350 5300 1600 5300
$Comp
L power:+5V #PWR05
U 1 1 6121E2CB
P 1950 5900
F 0 "#PWR05" H 1950 5750 50  0001 C CNN
F 1 "+5V" V 1965 6028 50  0000 L CNN
F 2 "" H 1950 5900 50  0001 C CNN
F 3 "" H 1950 5900 50  0001 C CNN
	1    1950 5900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2300 5900 2300 6200
Wire Wire Line
	2300 6200 2850 6200
Connection ~ 2300 5900
Wire Wire Line
	2300 5900 2350 5900
$Comp
L Device:R R2
U 1 1 612240C0
P 2300 5100
F 0 "R2" H 2370 5146 50  0000 L CNN
F 1 "47k" H 2370 5055 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 2230 5100 50  0001 C CNN
F 3 "~" H 2300 5100 50  0001 C CNN
	1    2300 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 5900 2300 5900
$Comp
L Device:CP C1
U 1 1 6122DA6C
P 1950 5550
F 0 "C1" H 2068 5596 50  0000 L CNN
F 1 "100uF" H 2068 5505 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 1988 5400 50  0001 C CNN
F 3 "~" H 1950 5550 50  0001 C CNN
	1    1950 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 5500 2350 5400
Wire Wire Line
	2350 5400 2300 5400
Wire Wire Line
	2350 5700 2350 5600
Wire Wire Line
	1600 5800 2350 5800
$Comp
L power:+5V #PWR09
U 1 1 6123AB7E
P 2300 4950
F 0 "#PWR09" H 2300 4800 50  0001 C CNN
F 1 "+5V" V 2315 5078 50  0000 L CNN
F 2 "" H 2300 4950 50  0001 C CNN
F 3 "" H 2300 4950 50  0001 C CNN
	1    2300 4950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2300 5250 2300 5400
$Comp
L power:GND #PWR016
U 1 1 6124C95B
P 4100 6050
F 0 "#PWR016" H 4100 5800 50  0001 C CNN
F 1 "GND" H 4105 5877 50  0000 C CNN
F 2 "" H 4100 6050 50  0001 C CNN
F 3 "" H 4100 6050 50  0001 C CNN
	1    4100 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 6050 4100 5800
Wire Wire Line
	4100 5800 4150 5800
$Comp
L power:+5V #PWR019
U 1 1 61253EE5
P 4650 6200
F 0 "#PWR019" H 4650 6050 50  0001 C CNN
F 1 "+5V" V 4665 6328 50  0000 L CNN
F 2 "" H 4650 6200 50  0001 C CNN
F 3 "" H 4650 6200 50  0001 C CNN
	1    4650 6200
	-1   0    0    1   
$EndComp
Wire Wire Line
	3500 5900 3500 5500
Wire Wire Line
	3500 5500 3350 5500
Wire Wire Line
	3500 5900 3800 5900
Wire Wire Line
	4150 5700 4150 5600
Wire Wire Line
	4150 5500 4150 5400
Wire Wire Line
	4150 5400 3850 5400
$Comp
L Device:R R3
U 1 1 612685E8
P 3600 5300
F 0 "R3" H 3530 5254 50  0000 R CNN
F 1 "10k" H 3530 5345 50  0000 R CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3530 5300 50  0001 C CNN
F 3 "~" H 3600 5300 50  0001 C CNN
	1    3600 5300
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR015
U 1 1 6126A49A
P 3600 5150
F 0 "#PWR015" H 3600 5000 50  0001 C CNN
F 1 "+5V" V 3615 5278 50  0000 L CNN
F 2 "" H 3600 5150 50  0001 C CNN
F 3 "" H 3600 5150 50  0001 C CNN
	1    3600 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 5700 4000 5700
Wire Wire Line
	4000 5700 4000 5800
Connection ~ 4000 5700
Wire Wire Line
	4000 5700 4150 5700
Wire Wire Line
	1950 5700 2350 5700
Wire Wire Line
	1950 5400 2300 5400
Connection ~ 2300 5400
Wire Notes Line
	5850 650  5850 7600
Wire Notes Line
	600  7600 5850 7600
Wire Wire Line
	3600 5450 3600 5800
Wire Wire Line
	3600 5800 4000 5800
Text Notes 4100 5100 0    50   ~ 0
10k resistor with 1uF cap gives\n0.45*RC = 0.45*0.01s = 0.0045s \nactive low pulse
Text Notes 1300 4850 0    50   ~ 0
47k resistor with 100uF cap gives\nt = 0.45RC = 0.45*4.7s= 2.115s delay between consecutive\nbutton presses
Wire Notes Line
	3250 650  3250 4450
Text Notes 6050 3600 0    39   ~ 0
Note that pins ~CS1~ and ~CS2~ are incorrectly\nplaced in the Field Support Manual. Also\nsee this link:\nhttps://www.circuitsonline.net/forum/view/message/2120842#2120842
Text Notes 700  1650 0    50   ~ 0
The SST39SF020 or SST39SF010\ncan also be used though at the\nexpense of fewer banks being\navailable.
$Comp
L Connector:TestPoint_Probe TP2
U 1 1 61327617
P 8400 5700
F 0 "TP2" H 8552 5801 50  0000 L CNN
F 1 "PB_GND" H 8552 5710 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 8600 5700 50  0001 C CNN
F 3 "~" H 8600 5700 50  0001 C CNN
	1    8400 5700
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Probe TP4
U 1 1 6132C376
P 9450 5700
F 0 "TP4" H 9603 5807 50  0000 L CNN
F 1 "PB_~NMI~" H 9603 5709 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 9650 5700 50  0001 C CNN
F 3 "~" H 9650 5700 50  0001 C CNN
	1    9450 5700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR025
U 1 1 61336ADD
P 8400 5700
F 0 "#PWR025" H 8400 5450 50  0001 C CNN
F 1 "GND" H 8405 5527 50  0000 C CNN
F 2 "" H 8400 5700 50  0001 C CNN
F 3 "" H 8400 5700 50  0001 C CNN
	1    8400 5700
	1    0    0    -1  
$EndComp
Text GLabel 9450 5800 3    50   Input ~ 0
~NMI
Wire Wire Line
	9450 5800 9450 5700
Wire Wire Line
	1600 5800 1600 6050
$Comp
L Connector:TestPoint_Probe TP1
U 1 1 6134649A
P 1600 6050
F 0 "TP1" H 1752 6151 50  0000 L CNN
F 1 "PB_RST" H 1752 6060 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 1800 6050 50  0001 C CNN
F 3 "~" H 1800 6050 50  0001 C CNN
	1    1600 6050
	-1   0    0    1   
$EndComp
Text Notes 3800 7500 0    50   ~ 0
Note: Actual measurement on the oscilloscope\nshows an ~NMI~ active low pulse width of 0.003s and\na minimum delay between subsequent pulses of at \nleast 1.36s by which the multiplier is around 0.3\nand not 0.45 as suggested by the datasheet.
$Comp
L Device:CP C4
U 1 1 61EB2F9D
P 3850 5550
F 0 "C4" H 3968 5596 50  0000 L CNN
F 1 "1uF" H 3968 5505 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 3888 5400 50  0001 C CNN
F 3 "~" H 3850 5550 50  0001 C CNN
	1    3850 5550
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR028
U 1 1 611CCA42
P 8850 2350
F 0 "#PWR028" H 8850 2200 50  0001 C CNN
F 1 "+5V" H 8865 2523 50  0000 C CNN
F 2 "" H 8850 2350 50  0001 C CNN
F 3 "" H 8850 2350 50  0001 C CNN
	1    8850 2350
	0    1    1    0   
$EndComp
$Comp
L Connector:Conn_01x06_Female J2
U 1 1 611CA66D
P 8650 2550
F 0 "J2" H 8678 2526 50  0000 L CNN
F 1 "DIPconn" V 8850 2400 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 8650 2550 50  0001 C CNN
F 3 "~" H 8650 2550 50  0001 C CNN
	1    8650 2550
	-1   0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Probe TP3
U 1 1 61EE64C3
P 3800 6100
F 0 "TP3" H 3952 6201 50  0000 L CNN
F 1 "PBQ" H 3952 6110 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 4000 6100 50  0001 C CNN
F 3 "~" H 4000 6100 50  0001 C CNN
	1    3800 6100
	-1   0    0    1   
$EndComp
Wire Wire Line
	3800 6100 3800 5900
Connection ~ 3800 5900
Wire Wire Line
	3800 5900 4150 5900
$Comp
L Device:R_Network08 RN1
U 1 1 61F10286
P 9950 2000
F 0 "RN1" H 10338 2046 50  0000 L CNN
F 1 "10k" H 10338 1955 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP9" V 10425 2000 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 9950 2000 50  0001 C CNN
	1    9950 2000
	1    0    0    -1  
$EndComp
Text Notes 8400 1350 0    50   ~ 0
The lower 12 bits are specified by the\nP2000T (and the decoder circuit), the\nupper 5 bits can be set by the user\nto select the rom.
Wire Wire Line
	8850 2450 10250 2450
Wire Wire Line
	8850 2550 10150 2550
Wire Wire Line
	8850 2650 10050 2650
Wire Wire Line
	8850 2750 9950 2750
Wire Wire Line
	8850 2850 9850 2850
Wire Wire Line
	10250 2200 10250 2450
Connection ~ 10250 2450
Wire Wire Line
	10250 2450 10700 2450
Wire Wire Line
	10150 2200 10150 2550
Connection ~ 10150 2550
Wire Wire Line
	10150 2550 10700 2550
Wire Wire Line
	10050 2200 10050 2650
Connection ~ 10050 2650
Wire Wire Line
	10050 2650 10700 2650
Wire Wire Line
	9950 2200 9950 2750
Connection ~ 9950 2750
Wire Wire Line
	9950 2750 10700 2750
Wire Wire Line
	9850 2200 9850 2850
Connection ~ 9850 2850
Wire Wire Line
	9850 2850 10700 2850
NoConn ~ 9750 2200
NoConn ~ 9650 2200
NoConn ~ 9550 2200
$EndSCHEMATC
