use <Motor.scad>;

$fn = 72;

roller_shaft();
roller_sleeve();

module roller_shaft(diameter=10, width=70)
{
    rotate([0,90,0])
    
    difference()
    {
        union()
        {
            
            cylinder(d=diameter, h=width, center=true);
            
            translate([0,0,diameter/4])
            cylinder(d=diameter/2, h=width, center=true);
        }
        
        translate([0,0,-width/2])
        shaft();
    }
}

module roller_sleeve(diameter=25, width=70, shaft_diameter=10, num_bristles=8, thickness=2)
{
    rotate([0,90,0])
    difference()
    {
        union()
        {
            cylinder(d=shaft_diameter + thickness*2, h=width, center=true);
            
            for (a=[0:((num_bristles/2)-1)])
            {
                angle = a * (360 / num_bristles);
                
                rotate([0,0,angle])
                cube([thickness, diameter, width], center=true);
            }
        }
        
        cylinder(d=10, h=width, center=true);
    }
}