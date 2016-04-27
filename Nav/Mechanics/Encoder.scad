use <Motor.scad>;
use <OH090U.scad>;
use <Pin_Header.scad>;

$fn = 72;

encoder();
hall_sensors();
hall_sensors_mount();

module encoder(encoder_diameter=20, magnet_diameter=6.4, magnet_height=3.1)
{
    rotate([0,90,0])
    difference()
    {
        encoder_height = magnet_diameter*.7;
        
        cylinder(d=encoder_diameter, h=encoder_height, center=true);
        
        union()
        {
            shaft();
            
            magnet_offset = encoder_diameter/2 - magnet_height;
            
            translate([0,-magnet_offset,0])
            rotate([90,0,0])
            cylinder(d=magnet_diameter, h=magnet_height);
            
            translate([0,magnet_offset,0])
            rotate([-90,0,0])
            cylinder(d=magnet_diameter, h=magnet_height);
            
            translate([magnet_offset,0,0])
            rotate([0,90,0])
            cylinder(d=magnet_diameter, h=magnet_height);
            
            translate([-magnet_offset,0,0])
            rotate([0,-90,0])
            cylinder(d=magnet_diameter, h=magnet_height);
        }
    }
}

module hall_sensors(diameter=30, height=1.9, sensor_diameter=25, sensor_offset=4.5)
{
    translate([0,0,diameter/2])
    rotate([180,0,0])
    rotate([0,-90,0])
    difference()
    {
        union()
        {
            color("purple")
            cylinder(d=diameter, h=height, center=true);
            
            // Hall Sensors
            for (angle=[-22.5, 22.5])
            {
                color("black")
                rotate([0,0,angle])
                translate([sensor_diameter/2,0,height/2 + sensor_offset])
                OH090U();
            }

            // Headers
            scale([1,1,-1])
            union()
            {
                // Power
                rotate([0,0,-45])
                translate([5.98, 2, 0])
                pin_header(rows=1, columns=2);
                
                // Encoders
                rotate([0,0,-45])
                translate([2, 5.98, 0])
                pin_header(rows=2, columns=1);
            }
        }
        
        union()
        {
            translate([-diameter/2, 0, 0])
            cube([diameter, diameter, height*2], center=true);
            
            rotate([0,0,45])
            translate([-diameter/2, 0, 0])
            cube([diameter, diameter, height*2], center=true);
            
            rotate([0,0,-45])
            translate([-diameter/2, 0, 0])
            cube([diameter, diameter, height*2], center=true);
        }
    }
}

module hall_sensors_mount(diameter=30, thickness=5)
{
    difference()
    {
        translate([0,0,diameter/2])
        rotate([180,0,0])
        rotate([0,-90,0])
        difference()
        {
            union()
            {
                cylinder(d=diameter, h=thickness, center=true);
                
                translate([diameter/2 - 1.25,0,0])
                cube([2 + 4.39340, diameter*(sqrt(2)/2), thickness], center=true);
            }
            
            
            union()
            {
                translate([-diameter/2, 0, 0])
                cube([diameter, diameter, thickness*2], center=true);
                
                rotate([0,0,45])
                translate([-diameter/2, 0, 0])
                cube([diameter, diameter, thickness*2], center=true);
                
                rotate([0,0,-45])
                translate([-diameter/2, 0, 0])
                cube([diameter, diameter, thickness*2], center=true);
                
                cylinder(d=diameter-2.5, h=100, center=true);
            }
        }
            
        hall_sensors();
    }
}