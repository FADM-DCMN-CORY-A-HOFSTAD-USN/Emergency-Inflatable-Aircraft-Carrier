// =========================================================================
// GRUMMAN-STYLED INFLATABLE CARRIER - STRUCTURAL HINGE PIN INTERLINK
// MANUFACTURER: HUNTINGTON INGALLS / NEWPORT NEWS SHIPBUILDING
// MATERIAL SPECIFICATION: TITANIUM GRADE 5 INTERLOCKING DECK LINKAGES
// =========================================================================

module titanium_hinge_pin(pin_radius=150, pin_length=17800, collar_radius=250) {
    // High-tensile structural core pin connecting sequential flatbed segments
    union() {
        // Main Linkage Shaft (Spans the entire width of the plate joint)
        cylinder(h=pin_length, r=pin_radius, center=true, $fn=64);
        
        // Forward Retaining Collar Cap
        translate([0, 0, pin_length/2])
            cylinder(h=100, r=collar_radius, center=true, $fn=64);
            
        // Aft Retaining Collar Cap
        translate([0, 0, -pin_length/2])
            cylinder(h=100, r=collar_radius, center=true, $fn=64);
            
        // Hollow Core Conduit Cutout for Solid-State Power Ribbon Routing
        // Allows high-draw power lines to pass through the rotating center axis
        cylinder(h=pin_length + 250, r=pin_radius - 50, center=true, $fn=64);
    }
}

module interlocking_hinge_joint_assembly() {
    // Render parallel mating knuckles with integrated pass-through clear paths
    difference() {
        union() {
            translate([0, 0, -4500]) cylinder(h=4000, r=300, center=true, $fn=64);
            translate([0, 0, 4500])  cylinder(h=4000, r=300, center=true, $fn=64);
        }
        // Center Pin Bore Clearance
        cylinder(h=18000, r=160, center=true, $fn=64);
    }
    
    // Seat the active high-tensile titanium hinge pin into the core assembly well
    color("Silver") titanium_hinge_pin();
}

// Instantiate structural interlink joint
interlocking_hinge_joint_assembly();
