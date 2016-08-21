$fn = 72;

Adafruit_1781();

// Lithium Ion Cylindrical Battery - 3.7V 2200mAh
module Adafruit_1781()
{
    color("blue")
    cylinder(h=69, d=18);
}

// Polymer Lithium Ion Battery - 3.7V 6000mAh
module Sparkfun_PRT_13856()
{
    color("blue")
    cube([6, 50, 70], center=true);
}

// Turnigy 9XR Safety 3S LiPo Battery - 11.1V 2200mAh
module Turnigy_9XR()
{
    color("blue")
    cube([100, 33, 19], center=true);
}

// Zippy Flightmax 4S2P LiFePO4 Battery - 13.2V 4200mAh
module Zippy_Flightmax_4S2P()
{
    color("blue")
    cube([145, 52, 36], center=true);
}

// Nanotech 2S1P LiFePO4 Battery - 6.6V 2100mAh
module Nanotech_2S1P()
{
    color("blue")
    cube([80, 44, 16], center=true);
}

// Holder for 18650 Cell
module Holder_18650()
{
    color("blue")
    cube([74.5, 21.5, 17.7], center=true);
}

// Battery Space LFP-26650-3300 - 3.2V 3300mAh
module LFP_26650_3300()
{
    color("blue")
    cylinder(d=26.5, h=66);
}