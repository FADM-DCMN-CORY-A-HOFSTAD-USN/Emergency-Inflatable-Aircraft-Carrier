// =========================================================================
// GRUMMAN-STYLED INFLATABLE CARRIER - SURFACE-MOUNT EDDY-TAPE PROFILE
// MANUFACTURER: HUNTINGTON INGALLS / NEWPORT NEWS SHIPBUILDING
// MATERIAL PROFILE: GRADE 5 TITANIUM SHIELDED SURFACE ARRANGEMENT
// =========================================================================

module surface_mount_eddy_tape(strip_length=30000, tape_width=2000, total_thickness=50) {
    // Applied directly on horizontal surfaces without cutting a recess channel
    union() {
        // Core Induction Layer (The active Eddy-Tape core)
        translate([0, 0, total_thickness/2])
            cube([strip_length, tape_width, total_thickness], center=true);
            
        // Left Tapered Transition Safety Ramp (15-degree tire clearance slope)
        translate([0, -tape_width/2 - 100, total_thickness/4])
            rotate([0, 15, 0])
                cube([strip_length, 200, total_thickness/2], center=true);
                
        // Right Tapered Transition Safety Ramp (15-degree tire clearance slope)
        translate([0, tape_width/2 + 100, total_thickness/4])
            rotate([0, -15, 0])
                cube([strip_length, 200, total_thickness/2], center=true);
    }
}

module non_recessed_flight_deck() {
    // Solid flatbed deck panel with NO subtractive recess channels
    cube([30000, 18000, 1500], center=true);
    
    // Apply the surface-mount modular induction tape straight onto the horizontal surface
    translate([0, 0, 1500/2])
        surface_mount_eddy_tape();
}

// Render complete un-recessed surface applied arrangement
non_recessed_flight_deck();
