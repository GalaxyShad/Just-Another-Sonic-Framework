draw_set_font(global.font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(x, y, "100", 0.5, 0.75, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
