$fn = 72;

height = 75;
sideLength = 150;

tracks();

module tracks()
{
    for (scaleFactor = [-1, 1])
    {
        scale([scaleFactor, 1, 1])
        for (zOffset = [height / 4, 2 * height / 4, 3 * height / 4])
        {
            translate([-sideLength/2, 0, zOffset])
            track_shape();
        }
    }
}

module track_mask()
{
    // Tracks
    for (scaleFactor = [-1, 1])
    {
        scale([scaleFactor, 1, 1])
        for (zOffset = [height / 4, 2 * height / 4, 3 * height / 4])
        {
            translate([-sideLength/2, 0, zOffset])
            track_shape(trackSize=6.2, channelSize=3.8);
        }
    }
}

module track_shape(trackSize=6, channelSize=4)
{
    // Module track
    roofWidth = sqrt(pow(trackSize, 2) / 2);

    difference()
    {
        union()
        {
            cube([trackSize, sideLength, trackSize], center=true);
            
            translate([0, 0, trackSize/2])
            rotate([0, 45, 0])
            cube([roofWidth, sideLength, roofWidth], center=true);
        }
            
        union()
        {
            translate([0, 0, -(1*trackSize/8)])
            cube([channelSize, sideLength+2, channelSize*1.75], center=true);
        }
    }
}