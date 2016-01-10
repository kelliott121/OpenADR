use <Motor.scad>;

$fn=72;

wheel();
//tire();
//hub();

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
        
        scale([1.05,1.05,1])
        shaft();
        
    }
}

module tire(diameter=50, width=10, thickness=5)
{
    tread_angle = 10;
    tread_fraction = .25;
    
    color("white")
    union()
    {
        tube(d=(diameter-2*thickness*tread_fraction), h=width, t=(thickness - thickness*tread_fraction), center=true);
        
        intersection()
        {
            tube(d=diameter, h=width, t=thickness*tread_fraction, center=true);
            
            for (rot_angle = [0:(tread_angle*2):(360-tread_angle)])
            {
                rotate([0,0,rot_angle])
                slice(angle=tread_angle);
            }
        }
    }
}

module tube(d, h, t, center=false)
{
    difference()
    {
        cylinder(d=d, h=h, center=center);
        cylinder(d=(d-(t*2)), h=h*2, center=center);
    }
}

module slice(angle)
{
    translate([0,0,-50])
    rotate([0,0,-angle/2])
    difference()
    {
        intersection()
        {
            cube([100, 100, 100]);
            cylinder(d=200, h=100);
        }
        
        translate([0,0,-50])
        rotate([0,0,angle])
        cube([100, 100, 200]);
    }
}