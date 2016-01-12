$fn = 72;

microswitch();

module microswitch(pressed=false)
{    
    // Main Body
    difference()
    {
        color("black")
        cube([6.4, 19.5, 10.6], center=true);
        
        // Mounting Holes
        union()
        {
            for (y_offset = [-9.5/2, 9.5/2])
            {
                translate([0,y_offset,-10.6/2 + 2.9])
                rotate([0,90,0])
                cylinder(d=3.5, h=10, center=true);
            }
        }
    }
    
    // Button
    if (pressed)
    {
        color("red")
        translate([0,-9.5/2 + 7.5,.5/2 + 10.6/2])
        cube([3.75,2.5,.5], center=true);
    }
    else
    {
        color("red")
        translate([0,-9.5/2 + 7.5,1.5/2 + 10.6/2])
        cube([3.75,2.5,1.5], center=true);        
    }
}