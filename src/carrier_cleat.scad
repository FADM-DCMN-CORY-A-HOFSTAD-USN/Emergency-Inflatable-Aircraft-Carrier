// =========================================================================
// GRUMMAN-STYLED INFLATABLE CARRIER - INTEGRATED MOORING CLEAT ASSEMBLY
// MANUFACTURER: HUNTINGTON INGALLS / NEWPORT NEWS SHIPBUILDING
// MATERIAL SPECIFICATION: TITANIUM GRADE 5 PARALLEL RIGGING ANCHORS
// =========================================================================

module titanium_mooring_cleat(base_l=600, base_w=200, horn_l=1200, horn_h=300) {
    // Solid-state cast anchor mounting directly to the plate side wall margins
    union() {
        // Base Anchor Pillar
        translate([0, 0, horn_h/4])
            cube([base_l, base_w, horn_h/2], center=true);
            
        // Flared Cleat Horns (Accepts heavy rope, steel cable, or trailing lines)
        translate([0, 0, horn_h/2 + horn_h/4])
            cube([horn_l, base_w - 50, horn_h/2], center=true);
            
        // Smooth radiused fillets at the tie-down horns to minimize line chafing
        translate([-horn_l/2, 0, horn_h/2 + horn_h/4])
            rotate([90, 0, 0]) cylinder(h=base_w - 50, r=horn_h/4, center=true, $fn=32);
        translate([horn_l/2, 0, horn_h/2 + horn_h/4])
            rotate([90, 0, 0]) cylinder(h=base_w - 50, r=horn_h/4, center=true, $fn=32);
    }
}

module carrier_plate_with_rigging() {
    // Reference base plate from solid_state_harness.scad
    difference() {
        cube([30000, 18000, 1500], center=true);
        // Core internal conduit cuts for the solid-state framework electrical harness
        translate([0, 0, 1500/2 - 100]) cube([30020, 150, 200], center=true);
    }
    
    // Distribute mooring cleats symmetrically along left and right titanium hull margins
    translate([-10000, -18000/2 - 100, 0]) titanium_mooring_cleat();
    translate([10000, -18000/2 - 100, 0])  titanium_mooring_cleat();
    translate([-10000, 18000/2 + 100, 0])  rotate([0, 0, 180]) titanium_mooring_cleat();
    translate([10000, 18000/2 + 100, 0])   rotate([0, 0, 180]) titanium_mooring_cleat();
}

// Instantiate fully rigged plate segment
carrier_plate_with_rigging();
