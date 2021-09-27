pcb_thickness = 1.6;
pcb_inner_margin = 2;
pcb_outer_margin = 1;

battery_width = 30;
battery_height = 35;
battery_thickness = 5;

case_height = 11;
case_thickness = 1.5;
component_thickness = 2.5;
shell_margin = 3;

tilt_angle = 6;

mounting_hole_diameter = 2.5;
mounting_hole_locations = [
    [33.4, 8.7], [-33.3, 9],
    [52.6, -23.5], [-52.6, -23.6],
    [91.5, 21], [-91.8, 21.1],
    [120.8, 0.5], [-120.9, 0.4]
];

module dxf_layer(name) {
    translate([-148.739, 100, 0])
    import("osprette.dxf", layer=name, center=true);
}

module edge() dxf_layer("Edge");
module components() dxf_layer("BFab");
module holes() dxf_layer("FCrtYd");

module orient_to_top_of_case() {
    translate([0, 0, case_height])
    rotate([180 - tilt_angle, 0, 180])
    children();
}

module shell() {
    rotate([180 - tilt_angle, 0, 180])
    linear_extrude(case_height * 2, center=true)
    offset(delta=(pcb_outer_margin + shell_margin))
    edge();
}

module component_cutout() {
    orient_to_top_of_case()
    linear_extrude(2 * (pcb_thickness + component_thickness), center=true)
    offset(delta=-pcb_inner_margin)
    edge();
}

module battery_cutout() {
    translate([0, -15, case_thickness])
    linear_extrude(case_height * 2, center=false)
    square([battery_width, battery_height], center=true);
}

module usb_cutout() {
    width = 7.99 - pcb_outer_margin - shell_margin;

    orient_to_top_of_case()
    linear_extrude((pcb_thickness + 1.5) * 2, center=true)
    square([width * 2, 15], center=true);
}

module wire_cutout() {
    orient_to_top_of_case()
    translate([0, 3.7, 1])
    linear_extrude(pcb_thickness * 2, center=true)
    square([15, 1.5], center=true);
}

module power_switch_cutout() {
    width = 7.99 - pcb_outer_margin - shell_margin;

    rotate([tilt_angle, 0, 0])
    rotate([0, 90, 0])
    linear_extrude(width * 2, center=true)
    offset(delta=4, chamfer=true)
    translate([-11.5, 12, 0])
    square(4, center=true);
}

module pcb_tray() {
    orient_to_top_of_case()
    linear_extrude(2 * pcb_thickness, center=true)
    offset(delta=pcb_outer_margin)
    edge();
}

module mounting_hole_struts() {
    orient_to_top_of_case()
    translate([0, 0, pcb_thickness])
    linear_extrude(component_thickness, center=false)
    holes();
}

module mounting_drill_holes() {
    for (location = mounting_hole_locations) {
        translate([location[0], location[1], 1])
        orient_to_top_of_case()
        linear_extrude(case_height, center=false)
        circle(1.7);
    }
}

module mounting_hole_countersinks() {
    orient_to_top_of_case()
    translate([0, 0, pcb_thickness + component_thickness + case_thickness])
    linear_extrude(case_height * 4, center=true)
    holes();
}

difference() {
    union() {
        intersection() {
            difference() {
                shell();
                pcb_tray();
                component_cutout();
                battery_cutout();
                usb_cutout();
                wire_cutout();
                power_switch_cutout();
                mounting_hole_countersinks();
            };
            translate([0, 0, 500])
            cube(1000, center=true);
        };
        mounting_hole_struts();
    };
    mounting_drill_holes();
};