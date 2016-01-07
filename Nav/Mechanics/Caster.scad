$fn = 72;

caster();

module caster()
{
    ball();
    holder();
}

module ball()
{
    diameter = (3/8) * 25.4;
    offset = diameter/2 + ((.4*25.4) - diameter);
    
    translate([0,0,-offset])
    sphere(d=diameter);
}

module holder()
{
    length = .75 * 25.4;
    width = (3/8) * 25.4;
    scale_factor = (.75/(3/8));
    hole_offset = (.53 * 25.4)/2;
    hole_diameter = .09*25.4;
    
    difference()
    {
        scale([scale_factor,1,1])
        translate([0,0,-2.5])
        cylinder(d=width, h=2.5);
        
        for (y_offset = [-hole_offset, hole_offset])
        {
            translate([y_offset,0,0])
            cylinder(d=hole_diameter, h=10, center=true);
        }
    }
}

module caster_mask()
{
    length = (3/8) * 25.4;
    width = (3/8) * 25.4;
    
    scale([1.1, 1.1, 1])
    cube([length, width, 100], center=true);
}