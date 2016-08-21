use <Motor.scad>;
use <Pump.scad>;

$fn = 72;

thickness = 2;

scrubber_mount(mounted=true);
//top_disc();
//bottom_disc();


module scrubber_mount(mounted=false, pumpRotation=0)
{    
    if (mounted)
    {
        translate([0, 0, 11.5])
        rotate([0, 90, 0])
        motor();
        
        translate([0, 0, -4])
        scrubber();
        
        rotate([0, 0, pumpRotation])
        translate([0, 0, 21.5])
        import("pump2.stl");
    }
    
    for (scaleFactor = [-1, 1])
    {
        scale([scaleFactor, 1, 1])
        rotate([0, 90, 0])
        //translate([11.5, 0, 0])
        motor_mount(supports=false);
    }
    
    rotate([0, 0, pumpRotation])
    for (xOffset = [-22.5, 22.5])
    {
        translate([xOffset, -31.2, 0])
        difference()
        {
            translate([0, 0, 22.5])
            cube([15, 2, 45.5], center=true);
            
            translate([0, 0, 34])
            rotate([90, 0, 0])
            cylinder(d=3, h=10, center=true);
        }
    }
}

module scrubber()
{
    top_disc();
    bottom_disc();
}

module top_disc()
{
    difference()
    {
        cylinder(d=50, h=2, center=true);
        
        union()
        {
            shaft();
            
            // Bolt holes
            for (xOffset = [-20, 20])
            {
                translate([xOffset, 0, 0])
                cylinder(d=3.1, h=5, center=true);
            }
            
            for (yOffset = [-20, 20])
            {
                translate([0, yOffset, 0])
                cylinder(d=3.1, h=5, center=true);
            }
        }
    }
}

module bottom_disc()
{
    difference()
    {
        union()
        {
            translate([0, 0, -3.5])
            cylinder(d=50, h=2, center=true);
            
            // Bolt holes
            for (xOffset = [-20, 20])
            {
                translate([xOffset, 0, -1])
                cylinder(d=3, h=4, center=true);
            }
            
            for (yOffset = [-20, 20])
            {
                translate([0, yOffset, -1])
                cylinder(d=3, h=4, center=true);
            }
        }
        
        union()
        {
            shaft();
        }
    }
}

module scrubber_mask()
{
    translate([0, -7.5, 0])
    cube([30, 35, 5], center=true);
}