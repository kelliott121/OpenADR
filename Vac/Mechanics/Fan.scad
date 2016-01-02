$fn = 72;

fan_mounts(mounted=true);

module fan(diameter=50, depth=15)
{
    difference()
    {
        union()
        {
            cylinder(d=diameter, h=depth);
            cube([diameter/2, diameter/2 + 5, depth]);
        }
        translate([0,0,depth/2])
        cylinder(d=diameter/2, h=depth/2);
    }
}

module fan_mounts(width=75, height=62.5, thickness=2.5, mounted=false)
{
    translate([width/2, height/2, 0])
    fan_mount(width=width, height=height, mounted=mounted);
    translate([-width/2, height/2, 0])
    fan_mount(width=width, height=height, mounted=mounted);
    translate([width/2, -height/2, 0])
    fan_mount(width=width, height=height, mounted=mounted);
    translate([-width/2, -height/2, 0])
    fan_mount(width=width, height=height, mounted=mounted);
}

module fan_mount(width=75, height=75, thickness=2.5, mounted=false)
{
    difference()
    {
        translate([-width/2, -height/2, 0])
        cube([width,height,thickness]);
        
        // Holes
        union()
        {
            cylinder(d=40,h=10);
            
            translate([20, 20, 0])
            cylinder(d=4.25, h=10);

            translate([-20, -20, 0])
            cylinder(d=4.25, h=10);
        }
    }
    
    if (mounted)
    {
        color("gray")
        translate([0,0,2.5])
        fan();
    }
}
