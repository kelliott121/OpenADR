$fn = 72;

hc_sr04(view=true);
hc_sr04_mount();

module hc_sr04(view=false)
{
    pcb_width = 45;
    pcb_height = 20.5;
    pcb_depth = 2.5;
    
    sensor_diameter = 16;
    sensor_depth = 12.5;
    
    sensor_offset0 = 9;
    sensor_offset1 = 36;
    
    hole_inset = 1.5;
    hole_diameter = 2;

    rotate([-90,90,90])
    translate([-pcb_width/2, -pcb_height/2, -pcb_depth/2])
    
    difference()
    {
        union()
        {
            color("blue")
            cube([pcb_width, pcb_height, pcb_depth]);
            
            translate([0,10,pcb_depth])
            
            union()
            {
                // Sensor 0
                color("gray")
                translate([sensor_offset0,0,0])
                cylinder(d=sensor_diameter, h=sensor_depth);
                
                // Sensor 1
                color("gray")
                translate([sensor_offset1,0,0])
                cylinder(d=sensor_diameter, h=sensor_depth);
                
                if (view)
                {
                    distance_min = 20;
                    distance_max = 400;
                    distance_range = distance_max - distance_min;
                    distance_start = pcb_depth + sensor_depth + distance_min;
                    
                    sense_angle = 30;
                    sense_radius_start = distance_min * tan(sense_angle/2);
                    sense_radius_end = distance_max * tan(sense_angle/2);
                    
                    color("red")
                    translate([pcb_width/2, 0, distance_start])
                    cylinder(r1=sense_radius_start, r2=sense_radius_end, h=distance_range);
                }
            }
        }
        
        union()
        {
            translate([hole_inset, hole_inset, 0])
            cylinder(d=hole_diameter, h=pcb_depth*4, center=true);
            
            translate([pcb_width - hole_inset, hole_inset, 0])
            cylinder(d=hole_diameter, h=pcb_depth*4, center=true);
            
            translate([hole_inset, pcb_height - hole_inset, 0])
            cylinder(d=hole_diameter, h=pcb_depth*4, center=true);
            
            translate([pcb_width - hole_inset, pcb_height - hole_inset, 0])
            cylinder(d=hole_diameter, h=pcb_depth*4, center=true);
        }
    }
}

module hc_sr04_mount(thickness = 8)
{
    pcb_width = 45;
    pcb_height = 20.5;
    pcb_depth = 2.75;
    
    sensor_diameter = 10;
    sensor_depth = 12.5;
    
    sensor_offset0 = 10;
    sensor_offset1 = 35;
    
    hole_inset = 1.5;
    hole_diameter = 2;

    difference()
    {
        union()
        {
            translate([0,-pcb_height/2,-(pcb_width/2 + thickness/2 + 1)])
            cube([thickness, thickness, thickness*2 + 2], center=true);
            
            translate([0,pcb_height/2,-(pcb_width/2 + thickness/2 + 1)])
            cube([thickness, thickness, thickness*2 + 2], center=true);
            
            translate([0,0,-(pcb_width/2 + thickness/2 + 3)])
            cube([thickness, thickness*2, thickness*2 - 2], center=true);
        }

        
        rotate([-90,90,90])
        translate([-pcb_width/2, -pcb_height/2, -pcb_depth/2])
        union()
        {
            cube([pcb_width + .25, pcb_height + .25, pcb_depth + .25]);
            
            translate([hole_inset, hole_inset, 0])
            cylinder(d=hole_diameter, h=pcb_depth*100, center=true);
            
            translate([pcb_width - hole_inset, hole_inset, 0])
            cylinder(d=hole_diameter, h=pcb_depth*100, center=true);
            
            translate([hole_inset, pcb_height - hole_inset, 0])
            cylinder(d=hole_diameter, h=pcb_depth*100, center=true);
            
            translate([pcb_width - hole_inset, pcb_height - hole_inset, 0])
            cylinder(d=hole_diameter, h=pcb_depth*100, center=true);
        }
    }
}