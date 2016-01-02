$fn = 72;

pin_header();

module straight_pin()
{
    union()
    {
        // Plastic
        color("black")
        translate([0,0,1.25])
        cube([2.54, 2.54, 2.5], center=true);
        
        // Connection Pin
        color("gold")
        translate([0,0,2.5])
        cylinder(d=.65, h=6);
        
        // Soldering pin
        color("gold")
        translate([0,0,-3])
        cylinder(d=.65, h=3);
    }
}

module pin_header(rows=1, columns=1)
{
    translate([-(columns - 1) * 1.27, -(rows - 1) * 1.27,0])
    for (r = [0:(rows-1)])
    {
        for (c = [0:(columns-1)])
        {
            translate([c*2.54,r*2.54,0])
            straight_pin();
        }
    }
}
