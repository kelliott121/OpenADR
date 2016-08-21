use <Motor.scad>;

$fn = 72;

thickness = 2;

//roller_mount(mounted=true);
//scale([1, 1, -1])
rotate([0, -90, 0])
roller_shaft();
//roller_sleeve();

module roller_mount(mounted=false)
{    
    if (mounted)
    {
        rotate([-90, 0, 0])
        motor();
    
        translate([40.5, 0, 0])
        union()
        {
            roller_shaft();
            roller_sleeve();
        }
        
        translate([-40.5, 0, 0])
        scale([-1, 1, 1])
        union()
        {
            roller_shaft();
            roller_sleeve();
        }
    }
    
    for (scaleFactor = [-1, 1])
    {
        scale([scaleFactor, 1, 1])
        rotate([-90, 0, 0])
        translate([11.5, 0, 0])
        motor_mount(supports=false);
    }
    
    translate([70, 0, 0])
    difference()
    {
        translate([0, -5, -2.5])
        cube([thickness, 25, 20], center=true);
        
        rotate([0, 90, 0])
        cylinder(d=6, h=10, center=true);
    }
    
    translate([-70, 0, 0])
    difference()
    {
        translate([0, -5, -2.5])
        cube([thickness, 25, 20], center=true);
        
        rotate([0, 90, 0])
        cylinder(d=6, h=10, center=true);
    }
}

module roller_shaft(diameter=19.5, width=54)
{
    color("gray")
    rotate([0,90,0])
    difference()
    {
        union()
        {
            
            cylinder(d=diameter, h=width, center=true);
            
            translate([0,0,diameter/4])
            cylinder(d=diameter/4, h=width, center=true);
        }
        
        translate([0,0,-width/2])
        shaft();
    }
}

module roller_sleeve(diameter=32, width=54, shaft_diameter=20, num_bristles=8, thickness=2)
{
    color("white")
    rotate([0,90,0])
    difference()
    {
        linear_extrude(height=width, center=true, twist=120, slices=45)
        union()
        {
            circle(d=shaft_diameter + thickness*2, center=true);
            
            for (a=[0:((num_bristles/2)-1)])
            {
                angle = a * (360 / num_bristles);
                
                rotate([0,0,angle])
                square([thickness, diameter], center=true);
            }
        }
        
        cylinder(d=shaft_diameter, h=width, center=true);
    }
}