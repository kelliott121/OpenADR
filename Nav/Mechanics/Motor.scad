$fn = 36;

motor();

translate([11,0,0])
motor_mount();

//translate([-11,0,0])
//motor_mount();

module motor()
{
    translate([0,-7.5,0])
    rotate([90,0,90])
    difference()
    {
        union()
        {
            color("yellow")
            cube([37, 22.5, 19], center=true);
            
            color("yellow")
            translate([18.5 + 2.5,0,0])
            cube([5, 5, 3], center=true);
            
            color("grey")
            translate([-(18.5 + 14), 0, ])
            rotate([0,90,0])
            intersection()
            {
                cylinder(d=22.5, h=28, center=true);
                cube([19,22.5, 28], center=true);
            }
            
            color("white")
            translate([18.5 - 11,0,0])
            shaft();
        }
        
        rotate([0,90,-90])
        mounting_holes();
    }
}

module shaft(keyed=true)
{
    intersection()
    {
        cylinder(d=5.6, h=37, center=true);
        
        if (keyed)
        {
            cube([3.8, 5.5, 37], center=true);
        }
    }
}

module mounting_holes()
{
    rotate([90,0,90])
    union()
    {
        translate([-(18.5 - 5), 17.5/2, 0])
        cylinder(d=3.5, h=19*2, center=true);
        
        translate([-(18.5 - 5), -17.5/2, 0])
        cylinder(d=3.5, h=19*2, center=true);
    }
}

module motor_mount(thickness=3)
{
    translate([0,-7.5,0])
    
    union()
    {
        difference()
        {
            translate([0,0,-6.125])
            cube([thickness, 40, 37.5], center=true);
            
            union()
            {
                mounting_holes();
                
                translate([0, 18.5 - 11,0])
                rotate([0,90,0])
                cylinder(d=7.5, h=37, center=true);
            }
        }
    
        /*
        translate([0,0,-6.125 - 37.5/2])
        difference()
        {
            rotate([0,45,0])
            cube([thickness*2, 40, thickness*2], center=true);
            
            translate([0,0,-thickness*2])
            cube([thickness*4, 40, thickness*4], center=true);
        }
        */
        
        difference()
        {
            union()
            {
                for (y_offset = [-15, 7.5])
                {
                    translate([-10.5,y_offset,-(22.5/2 + (37.5/2 - 6.125)/2) - .75])
                    cube([18,4,37.5/2 - 6.125 + .5], center=true);
                }
            }
            
            for (x_offset = [-15.5, -5.5])
            {
                for (y_offset = [-15, -22])
                {
                    translate([x_offset,0,y_offset])
                    union()
                    {
                        rotate([90,0,0])
                        cylinder(d=3.5,h=40, center=true); 
                    }
                }
            }
        }
    }
}