# Grumman-Styled Emergency Inflatable Aircraft Carrier Standalone Platform

## Project Metadata
- **Manufacturer:** Huntington Ingalls / Newport News Shipbuilding
- **Material Profile:** Grade 5 Titanium (Ti-6Al-4V) Core Panels
- **Avionics Weatherproofing Standard:** F-14F-Hyper-Tomcat-Avionics-Class
- **Architecture:** Towerless, Flatbed Passive Accordion-Unfolding Deck Matrix

## Repository Structure & Mapping

```text
├── hardware/
│   ├── generate_gerbers.py      # Automated manufacturing Gerber layer exporter
│   ├── harness_backplane.kicad_pcb # 3oz copper physical trace board routing file
│   ├── junction_box.kicad_pcb   # Enclosure internal interconnect routing board layout
│   ├── power_backplane.sch      # KiCad Eeschema electronic wiring schematic
│   ├── ribbon_connector.sch     # Weatherproof inter-plate ribbon connector pin map
│   ├── surface_power.gbr        # Raw front copper (F.Cu) photoplotter aperture vectors
│   ├── surface_power_mask.gbr   # Raw top solder mask (F.Mask) negative vector overlays
│   ├── surface_power.kicad_pcb  # Ultra-thin 0.5mm flat-foil deck surface routing file
│   ├── surface_power.sch        # Low-profile flat-foil ribbon connector schematic
│   └── tow_interface.net        # 600A external power umbilical terminal block netlist
├── src/
│   ├── chips/
│   │   ├── HarnessIO.cs         # C# native 16-state step memory-mapped register driver
│   │   ├── arresting_simulator.py # Reverse-polarity maglev aircraft braking recovery tool
│   │   ├── catapult_simulator.py # Multi-phase surface coil induction catapult launch engine
│   │   ├── fault_logger.py      # Real-time register error sniffer & mitigation trap
│   │   ├── harness_bridge.py    # Python-to-C# unmanaged memory interop bridge layer
│   │   └── telemetry_processor.py # Numba-accelerated parallel telemetry processing node
│   ├── carrier_cleat.scad       # Parametric titanium exterior side rigging mooring cleats
│   ├── carrier_cooling.scad     # Sub-surface 3D vapor chamber phase-change thermal housing
│   ├── carrier_hinge_pin.scad   # High-tensile structural interlink titanium pins and tracks
│   ├── carrier_junction_box.scad # Grade 5 Titanium terminal box protective enclosure shield
│   ├── carrier_surface_eddy.scad # Un-recessed landing deck plate with tapered safety profiles
│   ├── carrier_top_lid.scad     # Upgraded top lid assembly with integrated vacuum storage hooks
│   ├── carrier_vacuum_port.scad # Internal non-return flush vacuum evacuation suction valves
│   ├── build_fluid_check.py     # Hydraulic fluid film surface drainage runoff validator
│   ├── build_hex_board.py       # IPC-2152 compliant trace temperature audit validator
│   ├── build_stress_tester.py   # Lifecycle sortie surge simulation & stress loop engine
│   └── main.py                  # Root virtual motherboard UEFI-HX secure boot firmware
```

## System Compilation & Boot Execution

1. **Hardware Verification Mode:** Run the IPC-2152 thermal audit engine and hydraulic fluid runoff checker to validate trace and drainage parameters before fabrication:
   ```bash
   python3 src/build_hex_board.py
   python3 src/build_fluid_check.py
   ```

2. **Boot the Virtual Motherboard Firmware:** Execute the secure UEFI-HX boot sequence to run folder scanning loops and check active silicon loops:
   ```bash
   python3 src/main.py
   ```

3. **Run Flight Simulation Engines:** Verify takeoff catapult and recovery landing induction array metrics dynamically:
   ```bash
   python3 src/chips/catapult_simulator.py
   ```
   ```bash
   python3 src/chips/arresting_simulator.py
   ```
