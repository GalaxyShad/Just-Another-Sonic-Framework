
draw_set_halign(fa_left);

draw_set_color(c_black);
draw_roundrect(x-16, y-16, x + 512, y + 16 + 12 * array_length_1d(items_list) + 16, false);

for (var i = 0; i < array_length_1d(items_list); i++) {
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
    
    draw_text(x, y + 12 * i, text);

    draw_set_alpha(1);
}

draw_set_halign(fa_left);


