use <Scrubber.scad>;
use <peristaltic.scad>;
use <pump.scad>;
use <Mop.scad>;

$fn = 72;

diameter = 300;
height = 75;
thickness = 2;
sideLength = 150;

//dust_bin();

navigation_module();

translate([0, -20, 0])
union()
{
    center_bin(mounted=true);
    back_bin(mounted=true);
}

module center_bin(mounted=true, left=false, right=false)
{
    depth = 148;
    
    difference()
    {
        union()
        {
            difference()
            {
                translate([0, -(150 - depth)/2 - .25, height/2])
                cube([148, depth + .5, height], center=true);
                
                union()
                {
                    // Main bit of negative space
                    translate([0, -(150 - depth)/2 - thickness, height/2 + thickness])
                    cube([(148 - thickness*4), (depth - thickness), height], center=true);
                
                    // Module track
                    trackSize = 3.7;

                    // Tracks
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
            }
            
            // Connections to back bin
            for (xOffset = [-45, -15, 15, 45])
            {
                translate([xOffset, .75 - 75 - .5, 0])
                connection_mount();
            }
            
            // Connection between center bin halves
            for (yOffset = [0, 28.75, 57.5, 86.25])
            {
                translate([.75, 40 - yOffset, 0])
                rotate([0, 0, 90])
                connection_mount();
                translate([-.75, 40 - yOffset, 0])
                rotate([0, 0, 90])
                connection_mount();
            }
        }
        
        union()
        {
            if (left)
            {
                quadrant_I_mask();
                quadrant_IV_mask();
            }
            
            if (right)
            {
                quadrant_II_mask();
                quadrant_III_mask();
            }
        }
    }
}


module back_bin(left=false, right=false)
{
    difference()
    {
        union()
        {
            difference()
            {
                module_back();
                
                union()
                {
                    translate([0, 0, thickness])
                    scale([.94, .98, 1])
                    module_back();
                }
            }
            
            // Connections to center bin
            for (xOffset = [-45, -15, 15, 45])
            {
                translate([xOffset, .75 - 75 - .5 - 1.5, 0])
                connection_mount();
            }
            
            // Connection between back bin halves
            for (yOffset = [25, 50, 68.5])
            {
                translate([.75, -75 - yOffset, 0])
                rotate([0, 0, 90])
                connection_mount();
                translate([-.75, -75 - yOffset, 0])
                rotate([0, 0, 90])
                connection_mount();
            }
        }
        
        union()
        {
            if (left)
            {
                quadrant_IV_mask();
            }
            
            if (right)
            {
                quadrant_III_mask();
            }
        }
    }
}

module module_back()
{
    difference()
    {
        cylinder(d=diameter, h=height);
        union()
        {
            front_mask();
            left_mask();
            right_mask();
            
            translate([0, -1, height/2 + .25])
            cube([148, 149, height + .5], center=true);
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