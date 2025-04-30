var _cam = camera_get_active();

x = camera_get_view_x(_cam);
y = camera_get_view_y(_cam);

var _w = camera_get_view_width(_cam);
var _h = camera_get_view_height(_cam);


if (!surface_exists(title_card_surface)) {
    title_card_surface = surface_create(_w, _h);
    exit;
} else {
    surface_set_target(title_card_surface);

    draw_clear_alpha(c_black,0);

    if (fade_timer != 0) {
        draw_set_color(c_black);
        draw_rectangle(0, 0, _w, _h, false);
        draw_set_color(c_white);
    }

    
    draw_set_color(c_white);

    draw_set_halign(fa_center);
    draw_set_font(global.sprite_font_hud);

    draw_text(framework_text.x, framework_text.y, framework_text.TEXT);

    draw_set_font(global.sprite_font_plr_has_passed);
    draw_set_halign(fa_left);
    draw_text_transformed(zonename_text.x, zonename_text.y, zonename_text.TEXT, 1, 1, 0);
    draw_text_transformed(zone_text.x, zone_text.y, zone_text.TEXT, 1, 1, 0);
    if (act_number != undefined)
        draw_sprite(sprFontAct, act_number-1, zone_text.x + 64, zone_text.y);
    draw_set_halign(fa_left);
    draw_set_font(-1);

    var _line_height = sprite_get_height(sprSplashLine);

    draw_sprite(sprSplashLine, 0, _w / 2 + line_offset_x, line_y);
    draw_sprite(sprSplashLine, 0, _w / 2 + line_offset_x, line_y - _line_height);

    draw_sprite(sprSplashLine, 0, _w / 2 - line_offset_x, line_y);
    draw_sprite(sprSplashLine, 0, _w / 2 - line_offset_x, line_y - _line_height);

    line_y += 2;

    if (line_y >= _line_height) line_y = 0;

    surface_reset_target();

    depth = -10000000000000000000;

    draw_surface(title_card_surface, x, y);
}