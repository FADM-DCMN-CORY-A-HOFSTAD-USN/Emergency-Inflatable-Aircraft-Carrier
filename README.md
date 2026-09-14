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
│   ├── power_backplane.sch      # KiCad Eeschema electronic wiring schematic
│   └── tow_interface.net        # 600A external power umbilical terminal block netlist
├── src/
│   ├── chips/
│   │   ├── HarnessIO.cs         # C# native 16-state step memory-mapped register driver
│   │   ├── harness_bridge.py    # Python-to-C# unmanaged memory interop bridge layer
│   │   └── telemetry_processor.py # Numba-accelerated parallel telemetry processing node
│   ├── carrier_cleat.scad       # Parametric titanium exterior side rigging mooring cleats
│   ├── carrier_cooling.scad     # Sub-surface 3D vapor chamber phase-change thermal housing
│   ├── carrier_top_lid.scad     # Upgraded top lid assembly with integrated vacuum storage hooks
│   ├── carrier_vacuum_port.scad # Internal non-return flush vacuum evacuation suction valves
│   ├── deck_metrics.json        # Centralized programmatic JSON parameter metric engine
│   ├── build_hex_board.py       # IPC-2152 compliant trace temperature audit validator
│   └── main.py                  # Root virtual motherboard UEFI-HX secure boot firmware
```

## System Compilation & Boot Execution

1. **Hardware Verification Mode:** Run the IPC-2152 thermal audit engine to validate trace parameters before fabrication:
   ```bash
   python3 src/build_hex_board.py
   ```

2. **Boot the Virtual Motherboard Firmware:** Execute the secure UEFI-HX boot sequence to run folder scanning loops and check active silicon loops:
   ```bash
   python3 src/main.py
   ```

3. **Export Production Geometries:** Plot the physical layers out into factory Gerber vector formats:
   ```bash
   python3 hardware/generate_gerbers.py
   ```
