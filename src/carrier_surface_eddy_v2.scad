// =========================================================================
// GRUMMAN-STYLED INFLATABLE CARRIER - SURFACE-MOUNT EDDY-TAPE PROFILE
// MANUFACTURER: HUNTINGTON INGALLS / NEWPORT NEWS SHIPBUILDING
// MATERIAL PROFILE: GRADE 5 TITANIUM SHIELDED SURFACE ARRANGEMENT
// =========================================================================

module surface_mount_eddy_tape(strip_length=30000, tape_width=2000, total_thickness=50) {
    union() {
        // Core Induction Layer (Active Eddy-Tape Core Engine)
        translate([0, 0, total_thickness/2])
            cube([strip_length, tape_width, total_thickness], center=true);
            
        // Left Tapered Transition Safety Ramp (15-Degree Clearance Slope)
        translate([0, -tape_width/2 - 100, total_thickness/4])
            rotate([15, 0, 0])
                cube([strip_length, 200, total_thickness/2], center=true);
                
        // Right Tapered Transition Safety Ramp (15-Degree Clearance Slope)
        translate([0, tape_width/2 + 100, total_thickness/4])
            rotate([-15, 0, 0])
                cube([strip_length, 200, total_thickness/2], center=true);
    }
}

module non_recessed_flight_deck(length=30000, width=18000, thickness=1500) {
    difference() {
        // Solid Flatbed Deck Base
        cube([length, width, thickness], center=true);
        
        // Passive Edge Drainage Scuppers (Retained for Water Management)
        for (x_offset = [-length/3 : length/6 : length/3]) {
            translate([x_offset, -width/2 + 200, 0]) cube([800, 400, thickness + 20], center=true);
            translate([x_offset, width/2 - 200, 0])  cube([800, 400, thickness + 20], center=true);
        }
    }
    
    // Apply Maglev Tape directly onto the raw horizontal surface plane
    translate([0, 0, thickness/2])
        surface_mount_eddy_tape();
}

// Render complete un-recessed plate array
non_recessed_flight_deck();
