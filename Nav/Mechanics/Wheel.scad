use <Motor.scad>;
use <Gear.scad>;

$fn=72;

//wheel();
//wheel_mount();
//wheel_well();
//hub();
tire();


module wheel()
{
    rotate([0,90,0])
    
    union()
    {
        hub();
        tire();
    }
}


module wheel_mount()
{
    difference()
    {
        union()
        {
            translate([-7, 0, 0])
            cube([2, 10, 10], center=true);
            
            translate([14.5, 0, 0])
            cube([2, 10, 8], center=true);
        }
        
        rotate([0, 90, 0])
        cylinder(d=2.5, h=100, center=true);
    }
}


module wheel_well()
{
    rotate([0, 90, 0])
    cylinder(d=42.5, h=12, center=true);
    
    translate([3.75 + 6, 0, 0])
    rotate([0, 90, 0])
    cylinder(d=26, h=7.5, center=true);
}


module hub(diameter=30, width=10, thickness=2.5)
{
    difference()
    {
        union()
        {
            color("black")
            cylinder(d=diameter, h=width, center=true);
            
            translate([0, 0, (width / 2) + (width / 8)])
            cylinder(d=23.5, h=(width / 4), center=true);
            
            color("grey")
            translate([0, 0, (width / 2) + (width / 4) + (width / 4)])
            scale([.5, .5, .5])
            gear(num_teeth=16);
        }
        
        cylinder(d=2.5, h=width*4, center=true);        
    }
}

module tire(diameter=40, width=10, thickness=5)
{
    tread_angle = 15;
    tread_fraction = .2;
    
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