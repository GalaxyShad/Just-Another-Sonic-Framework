
draw_set_halign(fa_left);

depth = -10000000000000000000;

var _x = camera_get_view_x(camera_get_active()) + 32;
var _y = camera_get_view_y(camera_get_active()) + 32;

draw_sprite(sprSonic, 0, 0, 0);

draw_set_color(c_black);
draw_roundrect(_x-16, _y-16, _x + 256, _y + 16 + 12 * array_length(items_list) + 16, false);

for (var i = 0; i < array_length(items_list); i++) {
    var item = items_list[i];

    if (item == undefined) continue;
    
    draw_set_color(c_white);

    if (pos == i) {
        draw_set_color(make_color_rgb(255,179,71));
    }
    
    if (item[$ "disabled"]) {
        draw_set_alpha(0.5);
    }
    
    var text = item.label;

    if (item[$ "display_label"] != undefined) {
        text = item.display_label(self);
    }

    if (item[$ "action_left"] != undefined) {
        text = "< " + text;
    }

    if (item[$ "action_right"] != undefined) {
        text = text + " >";
    }
    
    draw_text(_x, _y + 12 * i, text);

    draw_set_alpha(1);
}

draw_set_halign(fa_left);


