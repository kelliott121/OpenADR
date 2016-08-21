$fn = 72;

use <Motor.scad>;

//gear(num_teeth=32);

//translate([0, 0, 10])
//gear(num_teeth=16);

//translate([0, 0, 20])
difference()
{
    rotate([0, 0, 22.5])
    scale([-.5, .5, .5])
    gear(num_teeth=8);
    
    scale([1.05, 1.05, 1]);
    shaft();
}


module gear(num_teeth)
{
    num_slices = 20;
    //rotate_angle = ((360 / num_teeth) / 2);
    rotate_angle = 0;
    union()
    {
        for (zScale = [-1, 1])
        {
            scale([1, 1, zScale])
            linear_extrude(height=5, center=false, convexity=10, twist=rotate_angle, slices=(num_slices / 2))
            {
                import (file = str("Gear_", num_teeth, ".dxf"), layer = "", origin = 0);
            }
        }
    }
}