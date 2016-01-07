$fn = 72;

microswitch();

module microswitch()
{
    // Main Body
    difference()
    {
        cube([6.4, 19.5, 10.6], center=true);
        
        // Mounting Holes
        union()
        {
            for (y_offset = [-9.5/2, 9.5/2])
            {
                translate([0,y_offset,-10.6/2 + 2.9])
                rotate([0,90,0])
                cylinder(d=3, h=10, center=true);
            }
        }
    }
    
    // Button
    translate([0,-9.5/2 + 7.5,3.2/2 + 10.6/2])
    cube([3.2,3.2,3.2], center=true);
}