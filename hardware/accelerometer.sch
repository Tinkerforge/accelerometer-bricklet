EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:tinkerforge
LIBS:accelerometer-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Accelerometer Bricklet"
Date "24 Feb 2015"
Rev "1.0"
Comp "Tinkerforge GmbH"
Comment1 "Licensed under CERN OHL v.1.1"
Comment2 "Copyright (©) 2015, B.Nordmeyer <bastian@tinkerforge.com>"
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 600  7700 0    40   ~ 0
Copyright Tinkerforge GmbH 2015.\nThis documentation describes Open Hardware and is licensed under the\nCERN OHL v. 1.1.\nYou may redistribute and modify this documentation under the terms of the\nCERN OHL v.1.1. (http://ohwr.org/cernohl). This documentation is distributed\nWITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF\nMERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A\nPARTICULAR PURPOSE. Please see the CERN OHL v.1.1 for applicable\nconditions\n
NoConn ~ 4000 3100
Wire Wire Line
	4150 3050 4150 3300
Wire Wire Line
	4150 3300 4000 3300
Wire Wire Line
	5150 4650 5150 4550
Wire Wire Line
	5150 4850 5600 4850
Wire Wire Line
	4000 3500 4350 3500
Connection ~ 4250 4950
Wire Wire Line
	4250 4750 4350 4750
Wire Wire Line
	4350 4850 4150 4850
Wire Wire Line
	4150 4850 4150 3600
Wire Wire Line
	4000 3600 6650 3600
Wire Wire Line
	3550 4250 3550 4150
Wire Wire Line
	4250 4950 4350 4950
Wire Wire Line
	4250 5050 4250 4650
Wire Wire Line
	4250 4650 4350 4650
Connection ~ 4250 4750
Wire Wire Line
	4000 3400 4350 3400
Wire Wire Line
	5150 4950 5600 4950
Wire Wire Line
	5600 4550 5600 4650
Wire Wire Line
	5150 4550 5200 4550
Connection ~ 5150 4550
Wire Wire Line
	4000 3200 4250 3200
Wire Wire Line
	4250 3200 4250 3350
NoConn ~ 5150 4750
$Comp
L GND #PWR01
U 1 1 4CE147DC
P 5600 4650
F 0 "#PWR01" H 5600 4650 30  0001 C CNN
F 1 "GND" H 5600 4580 30  0001 C CNN
F 2 "" H 5600 4650 60  0001 C CNN
F 3 "" H 5600 4650 60  0001 C CNN
	1    5600 4650
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4CE147C5
P 5400 4550
F 0 "C1" V 5200 4550 50  0000 L CNN
F 1 "100nF" V 5550 4550 50  0000 L CNN
F 2 "tinkerforge:0603" H 5400 4550 60  0001 C CNN
F 3 "" H 5400 4550 60  0001 C CNN
	1    5400 4550
	0    1    1    0   
$EndComp
$Comp
L DRILL U4
U 1 1 4C692B9B
P 10650 6250
F 0 "U4" H 10700 6300 60  0001 C CNN
F 1 "DRILL" H 10650 6250 60  0000 C CNN
F 2 "tinkerforge:DRILL_NP" H 10650 6250 60  0001 C CNN
F 3 "" H 10650 6250 60  0001 C CNN
	1    10650 6250
	1    0    0    -1  
$EndComp
$Comp
L DRILL U3
U 1 1 4C692B9A
P 10650 6050
F 0 "U3" H 10700 6100 60  0001 C CNN
F 1 "DRILL" H 10650 6050 60  0000 C CNN
F 2 "tinkerforge:DRILL_NP" H 10650 6050 60  0001 C CNN
F 3 "" H 10650 6050 60  0001 C CNN
	1    10650 6050
	1    0    0    -1  
$EndComp
$Comp
L DRILL U5
U 1 1 4C692B98
P 10950 6050
F 0 "U5" H 11000 6100 60  0001 C CNN
F 1 "DRILL" H 10950 6050 60  0000 C CNN
F 2 "tinkerforge:DRILL_NP" H 10950 6050 60  0001 C CNN
F 3 "" H 10950 6050 60  0001 C CNN
	1    10950 6050
	1    0    0    -1  
$EndComp
$Comp
L DRILL U6
U 1 1 4C692B94
P 10950 6250
F 0 "U6" H 11000 6300 60  0001 C CNN
F 1 "DRILL" H 10950 6250 60  0000 C CNN
F 2 "tinkerforge:DRILL_NP" H 10950 6250 60  0001 C CNN
F 3 "" H 10950 6250 60  0001 C CNN
	1    10950 6250
	1    0    0    -1  
$EndComp
Text GLabel 5600 4950 2    60   Input ~ 0
SDA
Text GLabel 5600 4850 2    60   Input ~ 0
SCL
Text GLabel 4350 3500 2    60   Output ~ 0
SDA
Text GLabel 4350 3400 2    60   Output ~ 0
SCL
$Comp
L VCC #PWR02
U 1 1 4C5FD35E
P 5150 4550
F 0 "#PWR02" H 5150 4650 30  0001 C CNN
F 1 "VCC" H 5150 4650 30  0000 C CNN
F 2 "" H 5150 4550 60  0001 C CNN
F 3 "" H 5150 4550 60  0001 C CNN
	1    5150 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 4C5FD34E
P 4250 5050
F 0 "#PWR03" H 4250 5050 30  0001 C CNN
F 1 "GND" H 4250 4980 30  0001 C CNN
F 2 "" H 4250 5050 60  0001 C CNN
F 3 "" H 4250 5050 60  0001 C CNN
	1    4250 5050
	1    0    0    -1  
$EndComp
$Comp
L CAT24C U1
U 1 1 4C5FD337
P 4750 5050
F 0 "U1" H 4600 5550 60  0000 C CNN
F 1 "M24C64" H 4750 5050 60  0000 C CNN
F 2 "tinkerforge:TSSOP8" H 4750 5050 60  0001 C CNN
F 3 "" H 4750 5050 60  0001 C CNN
	1    4750 5050
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR04
U 1 1 4C5FCFB4
P 4150 3050
F 0 "#PWR04" H 4150 3150 30  0001 C CNN
F 1 "VCC" H 4150 3150 30  0000 C CNN
F 2 "" H 4150 3050 60  0001 C CNN
F 3 "" H 4150 3050 60  0001 C CNN
	1    4150 3050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 4C5FCF5E
P 4250 3350
F 0 "#PWR05" H 4250 3350 30  0001 C CNN
F 1 "GND" H 4250 3280 30  0001 C CNN
F 2 "" H 4250 3350 60  0001 C CNN
F 3 "" H 4250 3350 60  0001 C CNN
	1    4250 3350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 4C5FCF4F
P 3550 4250
F 0 "#PWR06" H 3550 4250 30  0001 C CNN
F 1 "GND" H 3550 4180 30  0001 C CNN
F 2 "" H 3550 4250 60  0001 C CNN
F 3 "" H 3550 4250 60  0001 C CNN
	1    3550 4250
	1    0    0    -1  
$EndComp
$Comp
L LIS3DSH U2
U 1 1 5417FCED
P 7150 3650
F 0 "U2" H 6750 4550 60  0000 C CNN
F 1 "LIS3DSH" H 7550 2850 60  0000 C CNN
F 2 "kicad-libraries:LGA-16-3x3" H 7100 3500 60  0001 C CNN
F 3 "" H 7100 3500 60  0000 C CNN
	1    7150 3650
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 5417FD86
P 7200 2050
F 0 "C3" V 7000 2050 50  0000 L CNN
F 1 "100nF" V 7350 2050 50  0000 L CNN
F 2 "tinkerforge:0603" H 7200 2050 60  0001 C CNN
F 3 "" H 7200 2050 60  0001 C CNN
	1    7200 2050
	0    1    1    0   
$EndComp
$Comp
L C C4
U 1 1 5417FE67
P 7600 2450
F 0 "C4" V 7400 2450 50  0000 L CNN
F 1 "100nF" V 7750 2450 50  0000 L CNN
F 2 "tinkerforge:0603" H 7600 2450 60  0001 C CNN
F 3 "" H 7600 2450 60  0001 C CNN
	1    7600 2450
	0    1    1    0   
$EndComp
$Comp
L GND #PWR07
U 1 1 5417FF41
P 7850 2700
F 0 "#PWR07" H 7850 2700 30  0001 C CNN
F 1 "GND" H 7850 2630 30  0001 C CNN
F 2 "" H 7850 2700 60  0001 C CNN
F 3 "" H 7850 2700 60  0001 C CNN
	1    7850 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 2050 7850 2050
Wire Wire Line
	7850 1600 7850 2700
Wire Wire Line
	7800 2450 7850 2450
Connection ~ 7850 2450
Wire Wire Line
	7300 2750 7300 2450
Wire Wire Line
	7000 2450 7400 2450
Wire Wire Line
	7000 1500 7000 2750
$Comp
L VCC #PWR08
U 1 1 5418004D
P 7000 1500
F 0 "#PWR08" H 7000 1600 30  0001 C CNN
F 1 "VCC" H 7000 1600 30  0000 C CNN
F 2 "" H 7000 1500 60  0001 C CNN
F 3 "" H 7000 1500 60  0001 C CNN
	1    7000 1500
	1    0    0    -1  
$EndComp
Connection ~ 7000 2050
Connection ~ 7000 2450
Connection ~ 7300 2450
NoConn ~ 7650 4000
NoConn ~ 7650 4100
$Comp
L GND #PWR09
U 1 1 5418013C
P 7150 4650
F 0 "#PWR09" H 7150 4650 30  0001 C CNN
F 1 "GND" H 7150 4580 30  0001 C CNN
F 2 "" H 7150 4650 60  0001 C CNN
F 3 "" H 7150 4650 60  0001 C CNN
	1    7150 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 4550 7300 4550
Wire Wire Line
	7150 4550 7150 4650
Connection ~ 7150 4550
Connection ~ 7200 4550
Connection ~ 7100 4550
$Comp
L C C2
U 1 1 541803AE
P 7200 1600
F 0 "C2" V 7000 1600 50  0000 L CNN
F 1 "10µF" V 7350 1600 50  0000 L CNN
F 2 "tinkerforge:0805" H 7200 1600 60  0001 C CNN
F 3 "" H 7200 1600 60  0001 C CNN
	1    7200 1600
	0    1    1    0   
$EndComp
Wire Wire Line
	7400 1600 7850 1600
Connection ~ 7850 2050
Connection ~ 7000 1600
Text GLabel 6450 3400 0    60   Input ~ 0
SCL
Text GLabel 6450 3500 0    60   Input ~ 0
SDA
Connection ~ 4150 3600
Wire Wire Line
	6450 3400 6650 3400
Wire Wire Line
	6650 3500 6450 3500
$Comp
L VCC #PWR010
U 1 1 541961C7
P 6450 3700
F 0 "#PWR010" H 6450 3800 30  0001 C CNN
F 1 "VCC" H 6450 3800 30  0000 C CNN
F 2 "" H 6450 3700 60  0001 C CNN
F 3 "" H 6450 3700 60  0001 C CNN
	1    6450 3700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6450 3700 6650 3700
$Comp
L GND #PWR011
U 1 1 5419625A
P 6550 4650
F 0 "#PWR011" H 6550 4650 30  0001 C CNN
F 1 "GND" H 6550 4580 30  0001 C CNN
F 2 "" H 6550 4650 60  0001 C CNN
F 3 "" H 6550 4650 60  0001 C CNN
	1    6550 4650
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR012
U 1 1 5419628F
P 6450 4100
F 0 "#PWR012" H 6450 4200 30  0001 C CNN
F 1 "VCC" H 6450 4200 30  0000 C CNN
F 2 "" H 6450 4100 60  0001 C CNN
F 3 "" H 6450 4100 60  0001 C CNN
	1    6450 4100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6450 4100 6650 4100
Wire Wire Line
	6550 4650 6550 4000
Wire Wire Line
	6550 4000 6650 4000
NoConn ~ 4000 3700
$Comp
L LED D1
U 1 1 55116821
P 5150 4150
F 0 "D1" H 5150 4250 50  0000 C CNN
F 1 "LED" H 5150 4050 50  0000 C CNN
F 2 "tinkerforge:D0603" H 5150 4150 60  0001 C CNN
F 3 "" H 5150 4150 60  0000 C CNN
	1    5150 4150
	-1   0    0    1   
$EndComp
$Comp
L R R1
U 1 1 55116948
P 4600 4150
F 0 "R1" V 4680 4150 50  0000 C CNN
F 1 "1k" V 4600 4150 50  0000 C CNN
F 2 "tinkerforge:0603" H 4600 4150 60  0001 C CNN
F 3 "" H 4600 4150 60  0000 C CNN
	1    4600 4150
	0    1    1    0   
$EndComp
$Comp
L CON-SENSOR P1
U 1 1 4C5FCF27
P 3550 3550
F 0 "P1" H 3300 4100 60  0000 C CNN
F 1 "CON-SENSOR" V 3700 3550 60  0000 C CNN
F 2 "tinkerforge:CON-SENSOR" H 3550 3550 60  0001 C CNN
F 3 "" H 3550 3550 60  0001 C CNN
	1    3550 3550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4350 4150 4050 4150
Wire Wire Line
	4050 4150 4050 4000
Wire Wire Line
	4050 4000 4000 4000
$Comp
L VCC #PWR013
U 1 1 55116B07
P 5400 4150
F 0 "#PWR013" H 5400 4250 30  0001 C CNN
F 1 "VCC" H 5400 4250 30  0000 C CNN
F 2 "" H 5400 4150 60  0001 C CNN
F 3 "" H 5400 4150 60  0001 C CNN
	1    5400 4150
	0    1    1    0   
$EndComp
Wire Wire Line
	5350 4150 5400 4150
Wire Wire Line
	4850 4150 4950 4150
Wire Wire Line
	6650 3800 6250 3800
Wire Wire Line
	6250 3800 6250 3900
Wire Wire Line
	6250 3900 4000 3900
Wire Wire Line
	6650 3900 6500 3900
Wire Wire Line
	6500 3900 6500 3850
Wire Wire Line
	6500 3850 5900 3850
Wire Wire Line
	5900 3850 5900 3800
Wire Wire Line
	5900 3800 4000 3800
$EndSCHEMATC
