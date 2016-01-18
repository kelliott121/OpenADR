$fn = 72;

color_sensor(view=true);
color_sensor_mount();
//color_sensor_mask();

module color_sensor(view=false)
{
    // Main PCB
    color("blue")
    translate([0,0,1.25])
    cube([30.5, 24.5, 2.5], center=true);
    
    // LEDs
    color("white")
    for (xOffset = [-8, 8])
    {
        for (yOffset = [-8, 8])
        {
            translate([xOffset, yOffset, 2.5])
            cylinder(d=6, h=9);
        }
    }
    
    if (view)
    {
        color("red")
        translate([0,0, 2.5 + 10])
        cylinder(d1=10, d2=30, h=20);
    }
}

module color_sensor_mount()
{
    height = 12;
    
    translate([0,0,1.25])
    difference()
    {
        cube([35, 30, 2.5], center=true);
        
        cube([31, 25, 100], center=true);
    }
    
    translate([0,0,2.5 + height/2])
    difference()
    {
        cube([35, 30, height], center=true);
        
        cube([25, 25, 100], center=true);
    }
}

module color_sensor_mask()
{
    cube([25, 25, 100], center=true);
}