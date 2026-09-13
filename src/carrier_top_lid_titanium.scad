// =========================================================================
// GRUMMAN-STYLED INFLATABLE CARRIER - TITANIUM ENCLOSURE BLUEPRINT
// MANUFACTURER: HUNTINGTON INGALLS / NEWPORT NEWS SHIPBUILDING
// MATERIAL PROFILE: GRADE 5 TITANIUM (Ti-6Al-4V) SPECIFICATION
// =========================================================================

include <carrier_deck.scad>

// Optimized Titanium Geometry Metrics (Reduced thickness due to high tensile strength)
length = 30000;
width = 18000;
thickness = 250; // Thinned from 400mm to optimize SWaP-C with Titanium Strength

module titanium_carrier_top_lid(l=length, w=width, t=thickness) {
    difference() {
        // Solid Titanium Protection Shell Matrix (Ti-6Al-4V)
        cube([l + 100, w + 100, t], center=true);
        
        // Internal Pocket Clearance for Vacuum-Flattened Accordion Plates
        translate([0, 0, -30])
            cube([l, w, t], center=true);
    }
    
    // Titanium-Reinforced Mounting Bosses for SNAP-CIRCUITS Power Blocks
    translate([-l/4, -w/4, -t/2 + 30]) titanium_circuit_boss();
    translate([l/4, -w/4, -t/2 + 30])  titanium_circuit_boss();
    translate([-l/4, w/4, -t/2 + 30])  titanium_circuit_boss();
    translate([l/4, w/4, -t/2 + 30])   titanium_circuit_boss();
}

module titanium_circuit_boss(boss_radius=120, boss_height=80) {
    // Threaded titanium bosses with integrated analog Guard Ring isolation barriers
    difference() {
        cylinder(h=boss_height, r=boss_radius, center=true, $fn=64);
        cylinder(h=boss_height + 10, r=boss_radius - 40, center=true, $fn=64);
    }
}

// Render upgraded Titanium Flatbed Top Lid
titanium_carrier_top_lid();
