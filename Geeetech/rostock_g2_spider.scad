//
// Copyright (C) 2015, Jason S. McMullan <jason.mcmullan@gmail.com>
// All right reserved.
//
// Licensed under the MIT License:
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//

module geeetech_rostock_g2_spider_leg()
{
  translate([14, 19, 0]) {
    cube([9, 11, 8]);
    cube([9, 15, 3]);
  }
  translate([14, 34, 6])
    rotate([0, 90, 0]) {
        difference() {
            cylinder(d=12, h=9, $fn=16);
            translate([0, 0, -0.1])
            cylinder(d=6, h=9.2, $fn=16);
        }
    }
}

module geeetech_rostock_g2_spider_bracket()
{
    geeetech_rostock_g2_spider_leg();
    mirror([1, 0, 0]) geeetech_rostock_g2_spider_leg();
}


module geeetech_rostock_g2_spider_zprobe()
{
    translate([-10, 26, 0])
        cube([20, 4, 8]);
    translate([-6, 20, 0])
        cube([12, 10, 19.2]);
}

module geeetech_rostock_g2_spider_blank(zprobe = true)
{
    difference() {
        union() {
            cylinder(r=30, h=8, $fn=24);

            for (i = [0:2]) {
                rotate([0, 0, i*120]) geeetech_rostock_g2_spider_bracket();
            }
    
            if (zprobe)
                geeetech_rostock_g2_spider_zprobe();
        }
                // Z-probe drills
        if (zprobe) {
           translate([-4.7, 30.1, 5.5])
                rotate([90, 0, 0])
                    cylinder(d=3-0.2, h=8.2, $fn=12);
           translate([4.7, 30.1, 5.5])
                rotate([90, 0, 0])
                    cylinder(d=3-0.2, h=8.2, $fn=12);
            translate([0, 23.5, -0.1])
                cylinder(d=3+0.5, h=20, $fn=12);
            translate([-1.5, 24, 8])
                cube([3, 8, 18]);
            translate([0, 22-0.5, 17])
                rotate([0, 0, 15]) cube([8, 3, 3]);
        }
    }
}

module geeetech_rostock_g2_spider(zprobe = true)
{
    difference() {
        geeetech_rostock_g2_spider_blank(zprobe);
        
        // Drills for Geetech J-Head and fan mounts
        for (i = [1:5]) {
            rotate([0, 0, i*60]) translate([0, 25, -0.1])
                cylinder(d=4, h=10, $fn=10);
        }
        
        // Central mounting hole for Geeetech J-Head mount
        translate([0, 0, -0.1])
            cylinder(d=40, h=10, $fn=32);

    }
}

// Debug interference model:
if (false) {
    color([1,0,0]) translate([-46.2, -40, 0])
            import("RKMA-B02-platform.STL", convexity=5);
    geeetech_rostock_g2_spider(zprobe=true);
}

// vim: set shiftwidth=4 expandtab: //
