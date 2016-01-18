use <Motor.scad>;
use <Wheel.scad>;
use <Encoder.scad>;
use <Battery.scad>;
use <HC_SR04.scad>;
use <Caster.scad>;
use <Microswitch.scad>;
use <Color_Sensor.scad>;

$fn=72;

mount_all=true;

diameter = 300;
height = 75;
thickness = 2.5;

left_plate(mounted=mount_all);
right_plate(mounted=mount_all);
front_plate(mounted=mount_all);

module base_plate()
{
    difference()
    {
        cylinder(d=diameter, h=thickness);
        
        sideLength = 150;
        cube([sideLength, sideLength, height*2], center=true);
    }
}

module left_plate(mounted=false, front=false, back=false)
{
    difference()
    {
        union()
        {
            difference()
            {
                base_plate();
            
                translate([-(100 + 30),0,12.5])
                wheel_well();
            }

            // Inter-plate connectors
            union()
            {
                rotate([0,0,-45])
                translate([-115,0,0])
                connection_mount();
                
                rotate([0,0,-45])
                translate([-140,0,0])
                connection_mount();
                
                rotate([0,0,0])
                translate([-146.25,0,0])
                connection_mount();
            }
    
            translate([-100,0,19 + thickness])
            motor_assembly(mounted=mounted);
            
            translate([0,20,0])
            rotate([0,0,0])
            translate([-120, 30, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
            
            rotate([0,0,-45])
            translate([-130, 0, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
        }
        
        // Mask out values
        union()
        {
            front_mask();
            
            right_mask();
            
            back_mask();
            
            if (front)
            {
                quadrant_III_mask();
            }
            
            if (back)
            {
                quadrant_II_mask();
            }
        }
    }
}

module right_plate(mounted=false, front=false, back=false)
{
    // Right now we're just mirroring the left place because
    // they're currently symmetric
    scale([-1,1,1])
    left_plate(mounted=mounted, front=front, back=back);
}

module front_plate(mounted=false, left=false, right=false)
{
    caster_offset = 117;
    difference()
    {
        union()
        {
            difference()
            {
                base_plate();
                
                union()
                {
                    translate([-50,caster_offset,thickness + 1.5])
                    caster_mask();
                    
                    translate([50,caster_offset,thickness + 1.5])
                    caster_mask();
                    
                    translate([0,110,0])
                    color_sensor_mask();
                }
            }

            // Inter-plate connectors
            union()
            {
                rotate([0,0,-45])
                translate([-115,0,0])
                connection_mount();
                
                rotate([0,0,-45])
                translate([-140,0,0])
                connection_mount();
                
                rotate([0,0,-90])
                translate([-140,0,0])
                connection_mount();
                
                rotate([0,0,-90])
                translate([-90,0,0])
                connection_mount();
                
                rotate([0,0,-135])
                translate([-115,0,0])
                connection_mount();
                
                rotate([0,0,-135])
                translate([-140,0,0])
                connection_mount();
            }
            
            // Casters
            translate([-50,caster_offset,thickness + 1.5])
            caster_assembly(mounted);
            
            translate([50,caster_offset,thickness + 1.5])
            caster_assembly(mounted);
            
            // Color Sensor
            translate([0,110,15])
            color_sensor_assembly(mounted);
            
            // Sonar
            // Left
            rotate([0,0,-45])
            translate([-130, 0, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
            
            // Right
            rotate([0,0,-135])
            translate([-130, 0, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
            
            // Center
            rotate([0,0,-90])
            translate([-130, 0, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
        }
        
        union()
        {
            left_mask();
            
            right_mask();
            
            back_mask();
            
            if (left)
            {
                quadrant_I_mask();
            }
            
            if (right)
            {
                quadrant_II_mask();
            }
        }
    }
}

module motor_assembly(mounted=false, left=false, right=false)
{
    union()
    {
        motor_mount();
        
        translate([12.5, 0, -15])
        hall_sensors_mount();
        
        if (mounted)
        {
            translate([-11.5,0,0])
            motor();
        
            translate([-31.5,0,0])
            wheel();
            
            translate([5.25,0,0])
            encoder();
            
            translate([12.5,0,-15])
            hall_sensors();
        }
    }
}

module sonar_assembly(mounted=false)
{
    translate([0,0,12.5])
    union()
    {
        if (mounted)
        {
            hc_sr04(view=true);
        }
        
        hc_sr04_mount();
    }
}

module caster_assembly(mounted=false)
{
    if (mounted)
    {
        caster();
    }
    
    caster_mount();
}

module color_sensor_assembly(mounted=false)
{
    if (mounted)
    {
        rotate([180,0,0])
        color_sensor(view=mounted);
    }
    
    rotate([180,0,0])
    color_sensor_mount();
}

module connection_mount()
{
    translate([0,0,3.5+thickness])
    difference()
    {
        cube([7, 3, 7], center=true);
        
        rotate([90,0,0])
        cylinder(d=3.5, h=20, center=true);
    }
}

module front_mask()
{
    rotate([0,0,45])
    translate([0,0,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module left_mask()
{
    rotate([0,0,135])
    translate([0,0,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module right_mask()
{
    rotate([0,0,-45])
    translate([0,0,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module back_mask()
{
    //union()
    {
        rotate([0,0, -135])
        translate([0,0,-thickness*100])
        cube([diameter*10, diameter*10, thickness*200]);
    }
}

module quadrant_I_mask()
{
    translate([0,0,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module quadrant_II_mask()
{
    translate([-diameter*10,0,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module quadrant_III_mask()
{
    translate([-diameter*10,-diameter*10,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}

module quadrant_IV_mask()
{
    translate([0,-diameter*10,-thickness*100])
    cube([diameter*10, diameter*10, thickness*200]);
}