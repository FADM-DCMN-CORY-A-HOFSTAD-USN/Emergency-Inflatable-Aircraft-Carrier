// =========================================================================
// GRUMMAN-STYLED INFLATABLE CARRIER - PARAMETRIC TOP-LID MODULE
// MANUFACTURER: HUNTINGTON INGALLS / NEWPORT NEWS SHIPBUILDING
// WEATHERPROOF FRAMEWORK CONFIGURATION FOR FLATBED ENCLOSURE
// =========================================================================

include <carrier_deck.scad>

// Drive dimensions via external JSON configuration pipeline
length = 30000;
width = 18000;
thickness = 400; 

module carrier_top_lid_enclosure(l=length, w=width, t=thickness) {
    difference() {
        // Main Weatherproof Protective Shell
        cube([l + 100, w + 100, t], center=true);
        
        // Main Cavity Clearance for Folded Accordion Plates
        translate([0, 0, -50])
            cube([l, w, t], center=true);
    }
    
    // Internal Mounting Bosses for SNAP-CIRCUITS Power Boards
    translate([-l/4, -w/4, -t/2 + 50]) snap_circuit_boss();
    translate([l/4, -w/4, -t/2 + 50])  snap_circuit_boss();
    translate([-l/4, w/4, -t/2 + 50])  snap_circuit_boss();
    translate([l/4, w/4, -t/2 + 50])   snap_circuit_boss();
}

module snap_circuit_boss(boss_radius=150, boss_height=100) {
    // Heavy-duty mounting bosses with individual component Guard Ring spacing
    difference() {
        cylinder(h=boss_height, r=boss_radius, center=true, $fn=32);
        cylinder(h=boss_height + 10, r=boss_radius - 50, center=true, $fn=32);
    }
}

// Instantiate complementary top-lid module
carrier_top_lid_enclosure();
