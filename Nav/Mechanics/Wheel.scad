use <Motor.scad>;

$fn=72;

wheel();

module wheel(diameter=65, width=20)
{
    rotate([0,90,0])
    
    union()
    {
        difference()
        {
            color("black")
            hub();
            scale([1.05,1.05,1])
            shaft();
        }
        
        color("white")
        tire();
    }
}

module wheel_well(height=50, width=20)
{
    cube([width, height, height], center=true);
}


module hub(diameter=40, width=10, thickness=5)
{
    tube(d=diameter, h=width, t=thickness, center=true);
    
    for (angle = [0:45:135])
    {
        rotate([0,0,angle])
        cube([diameter-thickness, thickness, width], center=true);
    }
    
    translate([0,0,width/2 + width/4])
    cylinder(d=thickness*2, h=width/2, center=true);
}

module tire(diameter=50, width=10, thickness=5)
{
    tube(d=diameter, h=width, t=thickness, center=true);
}

module tube(d, h, t, center=false)
{
    difference()
    {
        cylinder(d=d, h=h, center=center);
        cylinder(d=(d-(t*2)), h=h*2, center=center);
    }
}