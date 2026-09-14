// =========================================================================
// GRUMMAN-STYLED INFLATABLE CARRIER - TITANIUM LID WITH STORAGE LATCHES
// MANUFACTURER: HUNTINGTON INGALLS / NEWPORT NEWS SHIPBUILDING
// MATERIAL PROFILE: GRADE 5 TITANIUM ENCLOSURE WITH MECHANICAL HOOKS
// =========================================================================

include <carrier_deck.scad>

// Standard Titanium Lid Dimensions
length = 30000;
width = 18000;
thickness = 250; 

module titanium_carrier_top_lid_v2(l=length, w=width, t=thickness) {
    difference() {
        // Main Protective Shell Plane (Ti-6Al-4V)
        cube([l + 100, w + 100, t], center=true);
        
        // Internal Pocket Clearance for Vacuum-Flattened Accordion Plates
        translate([0, 0, -30])
            cube([l, w, t], center=true);
            
        // Parametric Cutouts for Internal Vacuum Storage Latch Mounts
        for (y_offset = [-w/3 : w/3 : w/3]) {
            translate([-l/2 + 50, y_offset, -t/2 + 50]) cube([300, 400, 200], center=true);
            translate([l/2 - 50, y_offset, -t/2 + 50])  cube([300, 400, 200], center=true);
        }
    }
    
    // Add Solid Titanium Latch Hooks inside the Mount Wells
    for (y_offset = [-w/3 : w/3 : w/3]) {
        translate([-l/2 + 50, y_offset, -t/2 + 100]) storage_latch_hook();
        translate([l/2 - 50, y_offset, -t/2 + 100])  rotate([0, 0, 180]) storage_latch_hook();
    }
}

module storage_latch_hook(hook_w=300, hook_h=150) {
    // Rigid wedge profiles that drop lock over the edges of the flattened plates
    union() {
        cube([100, hook_w, hook_h], center=true);
        translate([100, 0, hook_h/2 - 25]) cube([200, hook_w, 50], center=true);
    }
}

// Instantiate upgraded Titanium Top Lid
titanium_carrier_top_lid_v2();
