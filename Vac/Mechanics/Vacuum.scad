use <DustBin.scad>;
use <Filter.scad>;
use <Fan.scad>;

dust_bin();

translate([0,0,50])
filter();

translate([0,0,55])
fan_mounts(mounted=true);