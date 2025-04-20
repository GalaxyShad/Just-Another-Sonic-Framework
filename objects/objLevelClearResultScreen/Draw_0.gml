x = camera_get_view_x(camera_get_active()) + camera_get_view_width(camera_get_active()) / 2;
y = camera_get_view_y(camera_get_active()) + camera_get_view_height(camera_get_active()) / 2;


ui_plr_got.x = lerp(ui_plr_got.x, ui_plr_got.dst_x, 0.2);
ui_through.x = lerp(ui_through.x, ui_through.dst_x, 0.2);

draw_set_font(global.sprite_font_plr_has_passed);
draw_set_color(ui_plr_got.text_plr_color);
draw_text(x + ui_plr_got.x, y + ui_plr_got.y, ui_plr_got.text_plr);
draw_set_color(c_white);
draw_text(x + ui_plr_got.x + string_width(ui_plr_got.text_plr), y + ui_plr_got.y, ui_plr_got.text);

draw_text(x + ui_through.x, y + ui_through.y, ui_through.text);
draw_sprite(sprFontAct, act_sprite_index, x + ui_through.x + 132, y + ui_through.y - 16);

for (var i = 0; i < array_length(ui_arr_texts); i++) {
    ui_arr_texts[i].x = lerp(ui_arr_texts[i].x, ui_arr_texts[i].dst_x, 0.2);

    draw_set_halign(fa_left);
    draw_set_color(c_yellow);
    draw_set_font(global.sprite_font_hud);
    draw_text(x + ui_arr_texts[i].x, y + ui_arr_texts[i].y, ui_arr_texts[i].text);

    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_set_font(global.font);
    draw_text(x - ui_arr_texts[i].x, y + ui_arr_texts[i].y, ui_arr_texts[i].value);

}

draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(-1);