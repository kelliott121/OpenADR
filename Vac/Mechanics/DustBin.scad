dust_bin();

module dust_bin(width=145, length=125, depth=50, thickness=2.5)
{
    difference()
    {
        translate([0,0,depth/2])
        difference()
        {
            cube([width, length, depth], center=true);
            
            negative_width = width - thickness*2;
            negative_length = length - thickness*2;
            negative_depth = depth - thickness;
            
            translate([0,0,thickness/2])
            cube([negative_width, negative_length, negative_depth], center=true);
        }
        
        aperture(width=width, thickness=thickness, y_offset=length/2);
    }
}

module aperture(width=150, height=5, open_ratio=.75, num_openings=16, thickness=2.5, y_offset=62.5)
{
    hole_width = (width * open_ratio) / num_openings;
    spacing = width / (num_openings + 1);
    
    for (x = [1:num_openings])
    {
        translate([-width/2 + x*spacing,y_offset - thickness/2,height/2 + thickness])
        cube([hole_width, thickness*4, height], center=true);
    }
}
