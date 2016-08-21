$fn = 72;

rotate([180, 0, 0])
caster_mount();

//rotate([0, 90, 0])
//caster_wheel();
//caster_axle();
//caster_mask();

caster_width = 16;

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
                circle(r=10);
                
                translate([-50,-25,0])
                square([50,50]);
            }
            
            union()
            {
                translate([0,0,-(50 + (caster_width / 2))])
                cube([100, 100, 100], center=true);
                
                translate([0,0,(50 + (caster_width / 2))])
                cube([100, 100, 100], center=true);
                
                cylinder(d=2.75, h=100, center=true);
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
            for (xOffset = [-1, 1])
            {
                difference()
                {
                    union()
                    {
                        difference()
                        {
                            for (yScale = [-1, 1])
                            {
                                rotate([30 * yScale, 0, 0])
                                translate([xOffset * ((caster_width / 2) + 1.75 + 1), -yScale, 3])
                                cube([3.5, 4, 12.25], center=true);
                            }
                            
                            translate([0, 0, -(5 + 1.25 + 1)])
                            cube([200, 200, 10], center=true);
                        }
                    }
                    
                    translate([xOffset * 9, 0, 0])
                    rotate([0, xOffset * 90, 0])
                    cylinder(d=2.5, h=2);
                }
            
                translate([xOffset * ((caster_width / 2) + 1.25 + 1 + 2.25 + 4 - 1.75), 0, (-1.25 + 8.5)])
                difference()
                {
                    cube([11.5, 14.5, 2.5], center=true);
                    
                    for (yOffset = [-4, 4])
                    {
                        translate([xOffset * 1.75, yOffset, 0])
                        cylinder(d=3.5, h=10, center=true);
                    }
                }
            }
        }
    }
}

module caster_mask()
{    
    for (xOffset = [-1, 1])
    {    
        translate([xOffset * ((caster_width / 2) + 1.25 + 1 + 2.25 + 4), 0, (-1.25 + 7.5)])
        for (yOffset = [-4, 4])
        {
            translate([0, yOffset, 0])
            cylinder(d=3.5, h=10, center=true);
        }
    }
}

module caster_axle()
{
    rotate([0,90,0])
    cylinder(d=2, h=(caster_width + 2 * (1 + 1.25)), center=true);
}

module tube(d, h, t, center=false)
{
    difference()
    {
        cylinder(d=d, h=h, center=center);
        
        cylinder(d=(d-t), h=h, center=center);
    }
}
