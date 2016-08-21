use <Motor.scad>;
use <Wheel.scad>;
use <Encoder.scad>;
use <Battery.scad>;
use <HC_SR04.scad>;
use <Caster.scad>;
use <Microswitch.scad>;
use <Color_Sensor.scad>;
use <Gear.scad>;
use <Tracks.scad>;

$fn = 72;

mount_all=true;
side_wall=true;

diameter = 300;
height = 75;
thickness = 2;

left_plate(mounted=mount_all);
left_side_wall();

right_plate(mounted=mount_all);
right_side_wall();

front_plate(mounted=mount_all);
front_side_wall();

module base_plate()
{
    difference()
    {
        cylinder(d=diameter, h=thickness);
        
        sideLength = 150;
        cube([sideLength, sideLength, height*2], center=true);
    }
}


module side_wall()
{
    wall_height = (height - thickness*2);
    wall_offset = wall_height/2 + thickness;
    sideLength  = 150;
    backwall_offset = -sqrt(2 * pow(sideLength, 2))/2;
    backwall_width  = (diameter / 2) + backwall_offset;
    
    translate([0,0,wall_offset])
    difference()
    {
        cylinder(d=diameter, h=wall_height, center=true);
        cylinder(d=(diameter - thickness*2), h=height, center=true);
    }
    
    translate([0,0,wall_offset])
    difference()
    {
        cube([sideLength + thickness*4, sideLength + thickness*2, wall_height], center=true);
        cube([sideLength, sideLength, height*2], center=true);
    }
    
    rotate([0,0,45])
    translate([backwall_offset - backwall_width/2,0,wall_offset])
    cube([backwall_width, thickness*2, wall_height], center=true);
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
            
                // Component masks
                union()
                {
                    left_side_wall_mask(front=front, back=back);
                    
                    translate([-(100 + 31.5), 0, thickness + 3])
                    wheel_well();
                    
                    // Sonar masks
                    // Left
                    rotate([0,0,-45])
                    translate([-136, 0, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                    
                    // Far Left
                    translate([0,20,0])
                    rotate([0,0,0])
                    translate([-120, 30, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                }
            }

            // Inter-plate connectors
            union()
            {
                // Left to front connectors
                // Inner
                rotate([0, 0, -45])
                translate([-113, 0, 0])
                connection_mount();
                
                // Outer
                rotate([0, 0, -45])
                translate([-143.5, 0, 0])
                connection_mount();
                
                // Inter-Left connectors
                // Outer
                rotate([0, 0, 0])
                translate([-143.5, 0, 0])
                connection_mount();
                
                // Inner
                rotate([0,0,0])
                translate([-82.5, 0, 0])
                connection_mount();
            }
    
            translate([-100, 0, thickness + 3])
            motor_assembly(mounted=mounted);
            
            translate([0,20,0])
            rotate([0,0,0])
            translate([-129, 30, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
            
            rotate([0,0,-45])
            translate([-136, 0, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
            
            if (mounted)
            {                
                //translate([-82, 40, 35 + thickness])
                //Sparkfun_PRT_13856();
                //translate([-90, 40, 35 + thickness])
                //Sparkfun_PRT_13856();
                //translate([-98, 40, 35 + thickness])
                //Sparkfun_PRT_13856();
                
                translate([-88, 52.5, (19 / 2) + thickness + 15])
                rotate([0, 0, 90])
                Holder_18650();
                translate([-88, 52.5, (19 / 2) + thickness + 35])
                rotate([0, 0, 90])
                Holder_18650();
            }
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
    // they're symmetric
    scale([-1,1,1])
    left_plate(mounted=mounted, front=front, back=back);
}

module front_plate(mounted=false, left=false, right=false)
{
    caster_offset_x = 40;
    caster_offset_y = 115;
    caster_offset_z = -8.5;
    
    color_sensor_offset_y = 120;
    
    difference()
    {
        union()
        {
            difference()
            {
                base_plate();
                
                union()
                {
                    front_side_wall_mask(left=left, right=right);
                    
                    translate([-caster_offset_x, caster_offset_y, caster_offset_z])
                    caster_mask();
                    
                    translate([caster_offset_x, caster_offset_y, caster_offset_z])
                    caster_mask();
                    
                    translate([0,color_sensor_offset_y,0])
                    color_sensor_mask();
                    
                    // Sonar masks
                    // Left
                    rotate([0,0,-45])
                    translate([-136, 0, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                    
                    // Right
                    rotate([0,0,-135])
                    translate([-136, 0, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                    
                    // Center
                    rotate([0,0,-90])
                    translate([-136, 0, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                }
            }

            // Inter-plate connectors
            union()
            {
                // Front to left connectors
                // Inner
                rotate([0,0,-45])
                translate([-113,0,0])
                connection_mount();
                
                // Outer
                rotate([0,0,-45])
                translate([-143.5,0,0])
                connection_mount();
                
                // Inter-Front connectors
                // Outer
                rotate([0,0,-90])
                translate([-143.5,0,0])
                connection_mount();
                
                // Inner
                rotate([0,0,-90])
                translate([-91.5,0,0])
                connection_mount();
                
                // Front to right connectors
                // Inner
                rotate([0,0,-135])
                translate([-113,0,0])
                connection_mount();
                
                // Outer
                rotate([0,0,-135])
                translate([-143.5,0,0])
                connection_mount();
            }
            
            // Casters
            translate([-caster_offset_x, caster_offset_y, caster_offset_z])
            caster_assembly(mounted);
            
            translate([caster_offset_x, caster_offset_y, caster_offset_z])
            caster_assembly(mounted);
            
            // Color Sensor
            translate([0,color_sensor_offset_y,15])
            color_sensor_assembly(mounted);
            
            // Sonar
            // Left
            rotate([0,0,-45])
            translate([-136, 0, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
            
            // Right
            rotate([0,0,-135])
            translate([-136, 0, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
            
            // Center
            rotate([0,0,-90])
            translate([-136, 0, 22.5 + thickness])
            sonar_assembly(mounted=mounted);
            
            if (mounted)
            {
                for (xOffset = [60, 32, -30, -60])
                {
                    for (yOffset = [90, 118])
                    {
                        translate([xOffset, yOffset, thickness + 2])
                        rotate([0, 0, 0])
                        LFP_26650_3300();
                    }
                }
            }
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

module left_side_wall(mounted=false, front=false, back=false)
{
    sideLength = 150;
    
    difference()
    {
        union()
        {
            difference()
            {
                side_wall();
            
                union()
                {                    
                    // Sonar masks
                    // Left
                    rotate([0,0,-45])
                    translate([-136, 0, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                    
                    // Far Left
                    translate([0,20,0])
                    rotate([0,0,0])
                    translate([-120, 30, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                }
            }

            // Inter-plate connectors
            union()
            {
                // Outer
                rotate([0, 0, 40])
                translate([-144.5, 0, 0])
                connection_mount_vertical();
                
                rotate([0, 0, 15])
                translate([-144.5, 0, 0])
                connection_mount_vertical();
                
                rotate([0, 0, -15])
                translate([-144.5, 0, 0])
                connection_mount_vertical();
                
                rotate([0, 0, -40])
                translate([-144.5, 0, 0])
                connection_mount_vertical();
                
                // Inner
                translate([-82.5, -70, 0])
                connection_mount_vertical();
                
                translate([-82.5, -25, 0])
                connection_mount_vertical();
                
                translate([-82.5, 25, 0])
                connection_mount_vertical();
                
                translate([-82.5, 70, 0])
                connection_mount_vertical();
            }
            
            // Module track
            /*trackSize = 3.5;
            
            for (zOffset = [height / 4, 2 * height / 4, 3 * height / 4])
            {
                translate([-sideLength/2, 0, zOffset])
                difference()
                {
                    rotate([0, 45, 0])
                    cube([trackSize, sideLength, trackSize], center=true);
                    
                    translate([-trackSize / 2, 0, 0])
                    cube([trackSize, sideLength, trackSize], center=true);
                }
            }
            */
            if (mounted)
            {
                tracks();
            }
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
            
            track_mask();
        }
    }
}


module right_side_wall(mounted=false, front=false, back=false)
{
    // Right now we're just mirroring the left place because
    // they're symmetric
    scale([-1,1,1])
    left_side_wall(front=front, back=back);
}


module front_side_wall(mounted=false, left=false, right=false)
{
    difference()
    {
        union()
        {
            difference()
            {
                side_wall();
                
                union()
                {                    
                    // Sonar masks
                    // Left
                    rotate([0,0,-45])
                    translate([-136, 0, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                    
                    // Right
                    rotate([0,0,-135])
                    translate([-136, 0, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                    
                    // Center
                    rotate([0,0,-90])
                    translate([-136, 0, 22.5 + thickness + 12.5])
                    hc_sr04_mask();
                }
            }

            // Inter-plate connectors
            union()
            {
                // Outer
                rotate([0, 0, -50])
                translate([-144.5, 0, 0])
                connection_mount_vertical();
                
                rotate([0, 0, -75])
                translate([-144.5, 0, 0])
                connection_mount_vertical();
                
                rotate([0, 0, -105])
                translate([-144.5, 0, 0])
                connection_mount_vertical();
                
                rotate([0, 0, -130])
                translate([-144.5, 0, 0])
                connection_mount_vertical();
                
                // Inner
                translate([-70, 80.5, 0])
                connection_mount_vertical();
                
                translate([-25, 80.5, 0])
                connection_mount_vertical();
                
                translate([25, 80.5, 0])
                connection_mount_vertical();
                
                translate([70, 80.5, 0])
                connection_mount_vertical();
            }
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


module left_side_wall_mask(front=false, back=false)
{
    color("blue")
    
    difference()
    {
        union()
        {
            // Outer
            rotate([0, 0, 40])
            translate([-144.5, 0, 0])
            cylinder(d=3.5, h=20, center=true);
            
            rotate([0, 0, 15])
            translate([-144.5, 0, 0])
            cylinder(d=3.5, h=20, center=true);
            
            rotate([0, 0, -15])
            translate([-144.5, 0, 0])
            cylinder(d=3.5, h=20, center=true);
            
            rotate([0, 0, -40])
            translate([-144.5, 0, 0])
            cylinder(d=3.5, h=20, center=true);
            
            // Inner
            translate([-82.5, -70, 0])
            cylinder(d=3.5, h=20, center=true);
            
            translate([-82.5, -25, 0])
            cylinder(d=3.5, h=20, center=true);
            
            translate([-82.5, 25, 0])
            cylinder(d=3.5, h=20, center=true);
            
            translate([-82.5, 70, 0])
            cylinder(d=3.5, h=20, center=true);
        }
        
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


module right_side_wall_mask(front=false, back=false)
{
    // Right now we're just mirroring the left place because
    // they're symmetric
    scale([-1,1,1])
    left_side_wall_mask(front=front, back=back);
}


module front_side_wall_mask(front=false, back=false)
{
    color("blue")
    
    difference()
    {
        union()
        {
            // Outer
            rotate([0, 0, -50])
            translate([-144.5, 0, 0])
            cylinder(d=3.5, h=20, center=true);
            
            rotate([0, 0, -75])
            translate([-144.5, 0, 0])
            cylinder(d=3.5, h=20, center=true);
            
            rotate([0, 0, -105])
            translate([-144.5, 0, 0])
            cylinder(d=3.5, h=20, center=true);
            
            rotate([0, 0, -130])
            translate([-144.5, 0, 0])
            cylinder(d=3.5, h=20, center=true);
            
            // Inner
            translate([-70, 80.5, 0])
            cylinder(d=3.5, h=20, center=true);
            
            translate([-25, 80.5, 0])
            cylinder(d=3.5, h=20, center=true);
            
            translate([25, 80.5, 0])
            cylinder(d=3.5, h=20, center=true);
            
            translate([70, 80.5, 0])
            cylinder(d=3.5, h=20, center=true);
        }
            
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


module motor_assembly(mounted=false, left=false, right=false)
{
    union()
    {
        //motorOffset = sqrt(pow(15.5, 2) / 2);
        motorOffset = 15.5;
        
        translate([6, 0, motorOffset])
        motor_mount();
        
        //translate([12.5, 0, -15])
        //hall_sensors_mount();
        
        translate([-31.5,0,0])
        wheel_mount();
        
        if (mounted)
        {
            translate([-5.5, 0, motorOffset])
            motor();
        
            
            translate([-31.5,0,0])
            wheel();
            
            translate([-21.5, 0, motorOffset])
            rotate([0, 90, 0])
            difference()
            {
                rotate([0, 0, 22.5])
                scale([-.5, .5, .5])
                gear(num_teeth=8);
                
                scale([1.05, 1.05, 1]);
                shaft();
            }
            
            
            //translate([14.25, 0, motorOffset])
            //encoder();
            
            //translate([22.5, 0, 0])
            //hall_sensors();
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
            hc_sr04(view=false);
        }
        
        hc_sr04_mount();
    }
}

module caster_assembly(mounted=false)
{
    if (mounted)
    {
        caster();
    
        caster_mount();
    }
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


module connection_mount_vertical()
{
    translate([0,0,1.5+thickness])
    difference()
    {
        cube([7, 7, 3], center=true);
        
        //rotate([90,0,0])
        cylinder(d=3.5, h=20, center=true);
    }
}


module front_mask()
{
    rotate([0,0,45])
    translate([0,0,-thickness])
    cube([diameter*10, diameter*10, thickness*40]);
}

module left_mask()
{
    rotate([0,0,135])
    translate([0,0,-thickness])
    cube([diameter*10, diameter*10, thickness*40]);
}

module right_mask()
{
    rotate([0,0,-45])
    translate([0,0,-thickness])
    cube([diameter*10, diameter*10, thickness*40]);
}

module back_mask()
{
    //union()
    {
        rotate([0,0, -135])
        translate([0,0,-thickness])
        cube([diameter*10, diameter*10, thickness*40]);
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