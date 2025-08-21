for (var i = 0; i < (Spr_x); i++) {

    var _corkpos = i / (Width);

    var _x = x + i;
    var _y = y + Offset_y - Height + (Height) * dcos(_corkpos * (180) + Offset_x);
    
    if (i % floor(Spr_x/Count_spr+1) == 0)
	    draw_sprite(sprSonicCorcksew, floor(i / Spr_x * 12) ,_x, _y);
    
    if (i == Spr_x-1)
	    draw_sprite(sprSonicCorcksew, floor(i / Spr_x * 12) ,_x, _y);

    draw_text(x, y-25, string(Offset_y) + " + " + string(Height) + " * cos(" + string(Width) + " * X + " + string(Offset_x) + ")");
    draw_text(x, y-50, "Sprite_count " + string(Count_spr+1));
}

if (keyboard_check(ord("H"))) {

    if (keyboard_check_pressed(vk_up)) Offset_y--;
    if (keyboard_check_pressed(vk_down)) Offset_y++;
} 


if (keyboard_check(ord("J"))) {

    if (keyboard_check_pressed(vk_up)) Height++;
    if (keyboard_check_pressed(vk_down)) Height--;
} 

if (keyboard_check(ord("K"))) {

    if (keyboard_check_pressed(vk_up)) Width--;
    if (keyboard_check_pressed(vk_down)) Width++;
} 

if (keyboard_check(ord("L"))) {

    if (keyboard_check_pressed(vk_up)) Offset_x-=2;
    if (keyboard_check_pressed(vk_down)) Offset_x+=2;
}

if (keyboard_check(ord("N"))) {

    if (keyboard_check_pressed(vk_up)) Count_spr++;
    if (keyboard_check_pressed(vk_down)) Count_spr--;
    if (!Count_spr>0) Count_spr=1;
}
