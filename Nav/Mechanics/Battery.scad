battery();

module battery(width=138.5, height=47.5, depth=24.5)
{
    color("black")
    translate([0,0,height/2])
    cube([width, depth, height], center=true);
}