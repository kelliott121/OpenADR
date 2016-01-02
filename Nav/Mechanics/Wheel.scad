use <Motor.scad>;

wheel();

module wheel(diameter=65, width=26)
{
    rotate([0,90,0])
    
    color("black")
    difference()
    {
        cylinder(d=diameter, h=width, center=true);
        shaft();
    }
}

module wheel_well(height=70, width=30)
{
    cube([width, height, height], center=true);
}