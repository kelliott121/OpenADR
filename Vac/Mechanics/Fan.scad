$fn = 72;

//fan();

difference()
{
    union()
    {
        translate([10, -3, -17])
        cube([75, 110, 1], center=true);
        
        translate([55, -28.5, -7.5])
        cube([20, 40, 20], center=true);
    }
    fan_mask();
}

OuterDiameter = 90;

module fan(diameter=50, depth=15)
{
    difference()
    {
        cylinder(d=OuterDiameter, h=35, center=true);
        cylinder(d=60, h=35.5, center=true);
    }
    
    translate([(OuterDiameter/2)/2, -((OuterDiameter/2) - (33/2)), 0])
    rotate([0, 90, 0])
    difference()
    {
        cylinder(d=33, h=(OuterDiameter/2), center=true);
        cylinder(d=28, h=(OuterDiameter/2 + .5), center=true);
    }
    
    // Mounting Holes
    translate([10, 46, 0])
    difference()
    {
        cylinder(d=7, h=35, center=true);
        cylinder(d=4.25, h=35.5, center=true);
    }
    
    translate([-18, -52, 0])
    difference()
    {
        cylinder(d=7, h=35, center=true);
        cylinder(d=4.25, h=35.5, center=true);
    }
    
    translate([30, -52, 0])
    difference()
    {
        cylinder(d=7, h=35, center=true);
        cylinder(d=4.25, h=35.5, center=true);
    }
}

module fan_mask()
{
    // Mounting Holes
    translate([10, 46, 0])
    cylinder(d=3.5, h=35.5, center=true);
    
    translate([-18, -52, 0])
    cylinder(d=3.5, h=35.5, center=true);
    
    translate([30, -52, 0])
    cylinder(d=3.5, h=35.5, center=true);
    
    // Inlet
    translate([0, 0, 5])
    cylinder(d=65, h=40, center=true);
    
    // Outlet
    translate([(OuterDiameter/2)/2 + 5, -((OuterDiameter/2) - (33/2)), 0])
    rotate([0, 90, 0])
    cylinder(d=33, h=(OuterDiameter/2) + 40, center=true);
}

module fan_mount(width=75, height=62.5, thickness=2.5, mounted=false)
{
    
}

module fan_mount(width=75, height=75, thickness=2.5, mounted=false)
{
    
}

