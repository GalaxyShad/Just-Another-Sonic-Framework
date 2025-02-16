

if (fade_timer != 0) {
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_color(c_white);
}

draw_rectangle_color(
    rect.x, rect.y, 
    rect.x + rect.w, rect.y + rect.h,
    c_purple, c_purple,
    c_red, c_red, 
    false
);

draw_set_font(fntTitleCard);

draw_set_color(c_gray);
draw_rectangle(text.x, text.y + 48, text.x - string_width(text.msg) * 4, text.y + 64, false);
draw_set_color(c_white);

draw_set_color(c_white);


draw_set_halign(fa_center);
draw_text(rect.x + rect.w / 2, rect.y + rect.h - 64, "JUST ANOTHER\nSONIC FRAMEWORK");


draw_set_halign(fa_right);
draw_text_transformed(text.x, text.y, text.msg, 4, 4, 0);


draw_set_halign(fa_left);
draw_set_font(-1);


// draw_text_transformed()