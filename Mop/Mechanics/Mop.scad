use <DustBin.scad>;
use <Scrubber.scad>;

$fn = 72;

diameter = 300;
height = 75;
thickness = 2;
sideLength = 150;

//navigation_module();

center_bin();
back_bin();;

module navigation_module()
{
    difference()
    {
        cylinder(d=diameter, h=height);
        union()
        {
            back_mask();
            
            translate([0, -1, height/2])
            cube([150, 150, height + 1], center=true);
        }
    }

    // Module track
    trackSize = 3.7;

    for (scaleFactor = [-1, 1])
    {
        scale([scaleFactor, 1, 1])
        for (zOffset = [height / 4, 2 * height / 4, 3 * height / 4])
        {
            translate([-sideLength/2, 0, zOffset])
            difference()
            {
                rotate([0, 45, 0])
                cube([trackSize, sideLength, trackSize], center=true);
                
                translate([-trackSize / 2, 0, 0])
                cube([trackSize, sideLength, trackSize], center=true);
            }
        }
    }
}


module connection_mount()
{
    translate([0,0,3.5+thickness])
    difference()
    {
        cube([7, 1.5, 7], center=true);
        
        rotate([90,0,0])
        cylinder(d=3.5, h=20, center=true);
    }
}

module front_mask()
{
    rotate([0,0,45])
    translate([0,0,-thickness])
    cube([diameter*10, diameter*10, thickness*40]);
}

module left_mask()
{
    rotate([0,0,135])
    translate([0,0,-thickness])
    cube([diameter*10, diameter*10, thickness*40]);
}

module right_mask()
{
    rotate([0,0,-45])
    translate([0,0,-thickness])
    cube([diameter*10, diameter*10, thickness*40]);
}

module back_mask()
{
    //union()
    {
        rotate([0,0, -135])
        translate([0,0,-thickness])
        cube([diameter*10, diameter*10, thickness*40]);
    }
}

module quadrant_I_mask()
{
    translate([0,0,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module quadrant_II_mask()
{
    translate([-diameter*10,0,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module quadrant_III_mask()
{
    translate([-diameter*10,-diameter*10,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module quadrant_IV_mask()
{
    translate([0,-diameter*10,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}