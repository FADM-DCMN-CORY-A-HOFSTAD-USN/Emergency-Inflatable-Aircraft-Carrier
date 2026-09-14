EESchema Schematic File Version 4
LIBS:power
LIBS:device
LIBS:revolutionary_technology_company
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "FLAT-FOIL SURFACE INDUCTION COIL CONTROLLER"
Date "2026-09-13"
Rev "2.1.0-HI"
Comp "Huntington Ingalls / Newport News Shipbuilding & Revolutionary Technology Company"
Comment1 "Flat Ribbon Bus interface for Un-Recessed Surface Applications"
Comment2 "Native 16-State Hexadecimal Bus Logic (0.0V to 1.0V Increments)"
Comment3 "SNAP-CIRCUIT Surface Snap Contacts with Sealed Over-Mold Protection"
Comment4 "Low-Profile Tapered Enclosure Geometry Mapping"
$EndDescr
$Comp
L RT_Infrastructure:SNAP_CIRCUIT_SURFACE_CONTACT SNAP_SURF1
U 1 1 65E34C10
P 4500 3500
F 0 "SNAP_SURF1" H 4500 3750 60  0000 L CNN
F 1 "SNAP_CIRCUIT_SURFACE_SNAP_BLOCK" H 4500 3250 60  0000 L CNN
	1    4500 3500
	2    4700 3500
	3    4900 3500
$EndComp
$Comp
L RT_Infrastructure:SURFACE_EDDY_TAPE_SEGMENT TAPE_STRIP1
U 1 1 65E34D55
P 6500 3500
F 0 "TAPE_STRIP1" H 6500 3750 60  0000 L CNN
F 1 "SURFACE_MOUNT_EDDY_TAPE_COIL" H 6500 3250 60  0000 L CNN
	1    6500 3500
	2    6700 3500
$EndComp
Wire Connection Line
	4500 3500 6500 3500
Wire Connection Line
	4700 3500 4700 5000
Wire Connection Line
	4900 3500 4900 5500
Wire Connection Line
	6700 3500 4900 5500
Text Notes 3500 2200 0    120  0.0V-1.0V Surface Telemetry Line (Tapered Module Gate Control)
Text Notes 4700 5200 0    120  Low-Profile Flat Foil Power Input (Applied Across Deck Top Face)
Text Notes 4900 5700 0    120  Chassis Ground Reference (Isolated Flat Shield Layer)
$EndSCHEMATC
