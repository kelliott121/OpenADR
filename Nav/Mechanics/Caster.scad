$fn = 72;

caster();
//caster_mount();
//caster_wheel();
//caster_axle();
//caster_mask();

module caster()
{
    //rotate([0,90,0])
    union()
    {
        caster_wheel();
        caster_axle();
    }
}

module caster_wheel()
{
    rotate([0,90,0])
    union()
    {
        difference()
        {
            rotate_extrude(angle=180)
            difference()
            {
                translate([-3.5, 0, 0])
                circle(r=15);
                
                translate([-50,-25,0])
                square([50,50]);
            }
            
            union()
            {
                translate([0,0,-(50 + 12.5)])
                cube([100, 100, 100], center=true);
                
                translate([0,0,(50 + 12.5)])
                cube([100, 100, 100], center=true);
                
                cylinder(d=2.2, h=100, center=true);
            }
        }
    }
}

module caster_mount()
{
    difference()
    {
        union()
        {
            translate([-(32.5/2 - 1.25),0,0])
            cube([2.5, 6, 6], center=true);
            
            translate([(32.5/2 - 1.25),0,0])
            cube([2.5, 6, 6], center=true);
        }
        
        rotate([0,90,0])
        cylinder(d=2.1,h=32.5, center=true);
    }
}

module caster_mask()
{
    //cube([27.5,17.5,50], center=true);
    scale([1.05, 1.1, 1.1])
    caster_wheel();
    
    cube([32.5 - 6.25, 2.5, 10], center=true);
    
    rotate([0,90,0])
    cylinder(d=2.1,h=35, center=true);
}

module caster_axle()
{
    rotate([0,90,0])
    cylinder(d=2, h=32.5, center=true);
}

module tube(d, h, t, center=false)
{
    difference()
    {
        cylinder(d=d, h=h, center=center);
        
        cylinder(d=(d-t), h=h, center=center);
    }
}
