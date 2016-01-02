filter();

module filter()
{
    width=150;
    length=125;
    depth=5;
    thickness=10;
    
    translate([0,0,depth/2])
    difference()
    {
        cube([width, length, depth], center=true);
        
        union()
        {
            union()
            {
                negative_width = width/2 - thickness*2;
                negative_length = length/2 - thickness*2;
                
                x_offset = negative_width/2 + thickness;
                y_offset = negative_length/2 + thickness;
                
                translate([x_offset, y_offset, 0])
                cube([negative_width, negative_length, depth], center=true);
                
                translate([-x_offset, y_offset, 0])
                cube([negative_width, negative_length, depth], center=true);
                
                translate([x_offset, -y_offset, 0])
                cube([negative_width, negative_length, depth], center=true);
                
                translate([-x_offset, -y_offset, 0])
                cube([negative_width, negative_length, depth], center=true);
            }
            
            union()
            {
                negative_width = width/2 - thickness;
                negative_length = length/2 - thickness;
                
                x_offset = negative_width/2 + thickness/2;
                y_offset = negative_length/2 + thickness/2;
                
                translate([x_offset, y_offset, depth/4])
                cube([negative_width, negative_length, depth/2], center=true);
                
                translate([-x_offset, y_offset, depth/4])
                cube([negative_width, negative_length, depth/2], center=true);
                
                translate([x_offset, -y_offset, depth/4])
                cube([negative_width, negative_length, depth/2], center=true);
                
                translate([-x_offset, -y_offset, depth/4])
                cube([negative_width, negative_length, depth/2], center=true);
            }
        }
    }
}