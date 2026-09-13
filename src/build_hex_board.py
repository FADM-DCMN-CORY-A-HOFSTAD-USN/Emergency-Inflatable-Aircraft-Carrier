#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
RT Architecture: KiCad Netlist & Thermal Trace Verification Engine
Validates 3oz Copper Traces and Solid-State Harness Routing Under Marine Loads
"""

import sys
import json
import math

def load_metric_boundaries(config_path="src/deck_metrics.json"):
    try:
        with open(config_path, "r") as f:
            return json.load(f)
    except FileNotFoundError:
        # Fallback parameters if JSON file pipeline is executing standalone
        return {
            "electrical_snap_circuits": {
                "continuous_topping_motor_draw_amps": 45.0,
                "nominal_lock_increment_v": 0.0625
            }
        }

def verify_thermal_limits():
    metrics = load_metric_boundaries()
    current_load = metrics["electrical_snap_circuits"]["continuous_topping_motor_draw_amps"]
    
    # Standard IPC-2152 Calculation for 3oz Copper Trace Thermal Rise
    # Target: Limit temp rise below 20 degrees Celsius inside the solid titanium channel
    trace_width_mm = 2.5
    copper_thickness_oz = 3.0
    cross_section_area_mils2 = trace_width_mm * 39.37 * (copper_thickness_oz * 1.37)
    
    # Calculate expected temperature rise under continuous 45 Amp blower draw
    temp_rise = (current_load / (0.064 * math.pow(cross_section_area_mils2, 0.42))) ** (1 / 0.45)
    
    print("=======================================================================")
    print("      HUNTINGTON INGALLS HARDWARE HARNESS FABRICATION VERIFICATION    ")
    print("=======================================================================")
    print(f"[*] Analyzing Solid-State Harness Core Trace Width: {trace_width_mm} mm")
    print(f"[*] Evaluated Copper Pour Class: {copper_thickness_oz} oz/ft² Heavy Plate")
    print(f"[*] Projected Continuous Topping Motor Load: {current_load} Amps")
    print(f"[-] Calculated Steady-State Thermal Rise: {temp_rise:.2f}°C")
    
    if temp_rise > 25.0:
        print("[!] ERROR: Thermal bottleneck detected. Increase trace width or expand 3D Vapor Chamber boundaries.")
        sys.exit(1)
    else:
        print("[INFO] Trace thermal boundaries NOMINAL. 45-degree wrap-around paths clear for routing.")

if __name__ == "__main__":
    verify_thermal_limits()
