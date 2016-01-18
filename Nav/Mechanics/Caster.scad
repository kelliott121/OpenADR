$fn = 72;

caster();
caster_mount();
//caster_wheel();
//caster_axle();

module caster()
{
    rotate([0,90,0])
    union()
    {
        caster_wheel();
        caster_axle();
    }
}

module caster_wheel()
{
    union()
    {
        difference()
        {
            rotate_extrude(angle=180)
            difference()
            {
                translate([-17.5, 0, 0])
                circle(r=25);
                
                translate([-50,-25,0])
                square([50,50]);
            }
            
            union()
            {
                translate([0,0,-(50 + 12.5)])
                cube([100, 100, 100], center=true);
                
                translate([0,0,(50 + 12.5)])
                cube([100, 100, 100], center=true);
                
                cylinder(r=3, h=100, center=true);
            }
        }
    }
}

module caster_mount()
{
    translate([0,0,1])
    difference()
    {
        union()
        {
            translate([-(36/2 - 1.25),0,0])
            cube([2.5, 12.5, 10], center=true);
            
            translate([(36/2 - 1.25),0,0])
            cube([2.5, 12.5, 10], center=true);
        }
        
        rotate([0,90,0])
        cylinder(d=5.5,h=100, center=true);
    }
}

module caster_mask()
{
    cube([27.5,17.5,50], center=true);
    
    rotate([0,90,0])
    cylinder(d=5.5,h=37.5, center=true);
}

module caster_axle()
{
    cylinder(r=2.5, h=35, center=true);
}

module tube(d, h, t, center=false)
{
    difference()
    {
        cylinder(d=d, h=h, center=center);
        
        cylinder(d=(d-t), h=h, center=center);
    }
}
