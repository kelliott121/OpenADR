use <Motor.scad>;

$fn=72;

wheel();

module wheel(diameter=65, width=20)
{
    rotate([0,90,0])
    
    union()
    {
        hub();
        tire();
    }
}

module wheel_well(height=50, width=20)
{
    cube([width, height, height], center=true);
}


module hub(diameter=40, width=10, thickness=2.5)
{
    color("black")
    difference()
    {
        union()
        {
            tube(d=diameter, h=width, t=thickness, center=true);
            
            for (angle = [0:45:135])
            {
                rotate([0,0,angle])
                cube([diameter-thickness, thickness, width], center=true);
            }
            
            translate([0,0,width/4])
            cylinder(d=thickness*4, h=width*1.5, center=true);
        }
        
        scale([1.025,1.025,1])
        shaft();
        
    }
}

module tire(diameter=50, width=10, thickness=5)
{
    color("white")
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