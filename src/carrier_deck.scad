// =========================================================================
// GRUMMAN-STYLED EMERGENCY INFLATABLE CARRIER - FLATBED FLUSH-DECK PLATFORM
// MANUFACTURER: HUNTINGTON INGALLS / NEWPORT NEWS SHIPBUILDING
// MECHANICAL BLUEPRINT SPECIFICATION: ACCORDION LANDING PLATFORM
// =========================================================================

module carrier_plate_module(length=30000, width=18000, thickness=1500) {
    difference() {
        // Main Flatbed Drop-Stitch Slab Core (No Tower, No Turret Obstructions)
        cube([length, width, thickness], center=true);
        
        // Passive Hinge Clearances for Accordion-Style Stacking
        translate([-length/2, 0, 0])
            cube([200, width+10, thickness+10], center=true);
        translate([length/2, 0, 0])
            cube([200, width+10, thickness+10], center=true);
            
        // Integrated Low-Profile Left/Right Sump Trenches for Bilge Collection
        translate([0, -width/2 + 500, thickness/2 - 100])
            cube([length - 1000, 400, 200], center=true);
        translate([0, width/2 - 500, thickness/2 - 100])
            cube([length - 1000, 400, 200], center=true);
    }
    
    // Huntington Ingalls Gravity-Drop Tongue-and-Groove Passive Interlocks
    translate([length/2 - 50, 0, 0])
        tongue_interlock_joint(width);
}

module tongue_interlock_joint(joint_width) {
    // Solid wedge joint profile that jams locked under gravity drop action
    rotate([0, 90, 0])
        cylinder(h=100, r=300, h=joint_width, center=true, $fn=6);
}

// Render primary operational flatbed segment
carrier_plate_module();
