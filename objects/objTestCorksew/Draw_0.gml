for (var i = 0; i < 384; i++) {

    var _corkpos = i / (Width);

    var _x = x + i;
    var _y = B + y+(Height) - abs(dsin(_corkpos * (180))) * (Height + A);

    draw_self();
    if (i % 16 == 0)
	    draw_sprite(sprSonicCorcksew, floor(_corkpos * 11) ,_x, _y);

    draw_text(x, y, string(Width) + " x " + string(Height) + " x " + string(A) + " x " + string(B));
}

if (keyboard_check(ord("H"))) {

    if (keyboard_check(vk_up)) Height++;
    if (keyboard_check(vk_down)) Height--;
} 


if (keyboard_check(ord("J"))) {

    if (keyboard_check(vk_up)) Width++;
    if (keyboard_check(vk_down)) Width--;
} 

if (keyboard_check(ord("K"))) {

    if (keyboard_check(vk_up)) A++;
    if (keyboard_check(vk_down)) A--;
} 


if (keyboard_check(ord("L"))) {

    if (keyboard_check(vk_up)) B++;
    if (keyboard_check(vk_down)) B--;
} 