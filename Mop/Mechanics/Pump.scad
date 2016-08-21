$fn = 72;

use <Motor.scad>;

pump_assembly();

module pump_assembly(mounted=true)
{
    if (mounted)
    {
        translate([26, 0, 0])
        pump();
        
        //translate([-26, 0, 0])
        //pump();
    }
    
    translate([0, 0, 30])
    union()
    {
        translate([11.5, 0, 0])
        motor_mount(supports=false);
        
        //translate([-11.5, 0, 0])
        //motor_mount(supports=false);
        
        if (mounted)
        {
            motor();
        }
    }
        
    translate([0, -7.5, 6])
    cube([26, 40, 12], center=true);
}

module pump()
{
    translate([-12.5, 0, 30])
    rotate([90, 0, 90])
    import("pump2.stl");
}


module pump_mask()
{
    translate([0, 37.5, 0])
    cylinder(d=3, h=10, center=true);
    
    translate([0, -37.5, 0])
    cylinder(d=3, h=10, center=true);
}