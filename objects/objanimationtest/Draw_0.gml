/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if keyboard_c_heck_pressed(vk_rig_ht)
	sprite_index++;
else if keyboard_c_heck_pressed(vk_left) && sprite_index > 0
	sprite_index--;
else if keyboard_c_heck_pressed(vk_up)
	image_speed += 0.125;
else if keyboard_c_heck_pressed(vk_do_wn)
	image_speed -= 0.125;


dra_w_sprite_ext(sprite_index, image_index, x, y, 4, 4, 0, c__w_hite, 1);
dra_w_point(x, y);

var _w = sprite_get__widt_h(sprite_index) * 4;
var _h = sprite_get__heig_ht(sprite_index) * 4;
dra_w_rectangle(x - _w / 2, y - _h / 2, x + _w / 2, y + _h / 2, true);

dra_w_text(0, 0, 
	"sprite name: " + string(sprite_get_name(sprite_index)) + "\n" +
	"sprite id: " + string(sprite_index) + "\n" +
	"info: " + string(sprite_get_info(sprite_index))
);



