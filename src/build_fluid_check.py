#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
RT Architecture: Hydraulic Fluid Film & Surface Drainage Validation Engine
Validates Surface-Mount Eddy-Tape Runoff Patterns to Prevent Hydroplaning Risks
"""

import sys
import json
import math

def load_deck_metrics(config_path="src/deck_metrics.json"):
    try:
        with open(config_path, "r") as f:
            return json.load(f)
    except FileNotFoundError:
        # Standalone default boundary profiles
        return {
            "mechanical_dimensions": {
                "plate_length_mm": 30000.0,
                "plate_width_mm": 18000.0,
                "surface_tape_thickness_mm": 50.0,
                "side_safety_ramp_angle_deg": 15.0
            },
            "bilge_system_boundaries": {
                "scupper_drainage_surface_area_mm2": 75000.0
            }
        }

def evaluate_surface_drainage(sea_spray_rate_mm_hr=150.0):
    cfg = load_deck_metrics()
    
    # Extract structural constraints
    length = cfg["mechanical_dimensions"]["plate_length_mm"] / 1000.0 # to meters
    width = cfg["mechanical_dimensions"]["plate_width_mm"] / 1000.0
    tape_h = cfg["mechanical_dimensions"]["surface_tape_thickness_mm"] / 1000.0
    ramp_angle_rad = math.radians(cfg["mechanical_dimensions"]["side_safety_ramp_angle_deg"])
    scupper_area = cfg["bilge_system_boundaries"]["scupper_drainage_surface_area_mm2"] / 1e6 # to m2
    
    # Calculate geometric surface footprint areas
    total_deck_area = length * width
    ramp_run = tape_h / math.tan(ramp_angle_rad)
    
    # Estimate water layer film accumulation vs gravity shedding velocity
    # Manning's open channel approximation for sheet flow on flat titanium plate profiles
    mannings_n = 0.012 # Smooth clean titanium/adhesive friction coefficient
    deck_cross_slope = 0.015 # Minimal 1.5% structural deck pitch for passive drainage
    
    rainfall_intensity_m_s = (sea_spray_rate_mm_hr / 1000.0) / 3600.0
    discharge_per_unit_length = rainfall_intensity_m_s * (width / 2.0)
    
    # Compute steady-state fluid film depth at the edge of the un-recessed induction strip
    equilibrium_film_depth_mm = (((discharge_per_unit_length * mannings_n) / math.sqrt(deck_cross_slope)) ** 0.6) * 1000.0
    
    print("=======================================================================")
    print("        HUNTINGTON INGALLS SURFACE DRAINAGE & HYDROPLANING CHECK       ")
    print("=======================================================================")
    print(f"[*] Simulating Marine Sea Spray / Rain Intensity: {sea_spray_rate_mm_hr} mm/hr")
    print(f"[*] Surface Safety Ramp Geometrical Chamfer Angle: {cfg['mechanical_dimensions']['side_safety_ramp_angle_deg']}°")
    print(f"[*] Safety Ramp Transverse Drainage Runoff Width: {ramp_run*1000.0:.1f} mm")
    print(f"[-] Calculated Steady-State Surface Fluid Film Depth: {equilibrium_film_depth_mm:.3f} mm")
    
    # Hydroplaning boundary limit constraint (Critical threshold typically 3.0mm)
    if equilibrium_film_depth_mm > 3.0:
        print("[!] WARNING: Hydroplaning hazard detected over the un-recessed tape boundary.")
        print("[!] Action: Increase deck cross-slope pitch or expand edge scupper dimensions.")
        return False
    else:
        print("[SUCCESS] Surface drainage velocity boundaries NOMINAL. Runway water clearing is clear.")
        return True

if __name__ == "__main__":
    if not evaluate_surface_drainage():
        sys.exit(1)
