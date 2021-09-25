pcb_width = 266.8;
pcb_height = 103.66;
pcb_thickness = 1.6;
pcb_inner_margin = 3;
pcb_outer_margin = 1;

battery_width = 30;
battery_height = 35;
battery_thickness = 5;

case_height = 11;
case_thickness = 1.5;
component_thickness = 2.5;
shell_height_margin = 8;
shell_width_margin = 6;

tilt_angle = 6;

mounting_hole_diameter = 2.5;
mounting_hole_locations = [
    [33.4, 8.7], [-33.4, 8.9],
    [52.58, -23.5], [-52.7, -23.5],
    [91.5, 21], [-91.8, 21.1],
    [120.6, 0.5], [-120.9, 0.4]
];

module dxf_layer(name) {
    translate([-148.6, 100, 0])
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
    resize([pcb_width + 2 * shell_width_margin, pcb_height + 2 * shell_height_margin, 0])
    rotate([180 - tilt_angle, 0, 180])
    linear_extrude(case_height * 2, center=true)
    edge();
}

module component_cutout() {
    resize([pcb_width - 2 * pcb_inner_margin, pcb_height - 2 * pcb_inner_margin, 0])
    orient_to_top_of_case()
    linear_extrude(2 * (pcb_thickness + component_thickness), center=true)
    edge();
}

module battery_cutout() {
    translate([0, -15, case_thickness])
    linear_extrude(case_height * 2, center=false)
    square([battery_width, battery_height], center=true);
}

module pcb_tray() {
    resize([pcb_width + pcb_outer_margin * 2, pcb_height + pcb_outer_margin * 2, 0])
    orient_to_top_of_case()
    linear_extrude(2 * pcb_thickness, center=true)
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
                mounting_hole_countersinks();
            };
            translate([0, 0, pcb_width])
            cube(pcb_width * 2, center=true);
        };
        mounting_hole_struts();
    };
    mounting_drill_holes();
};