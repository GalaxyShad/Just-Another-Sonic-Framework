/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if keyboard_check_pressed(vk_right)
	sprite_index++;
else if keyboard_check_pressed(vk_left) && sprite_index > 0
	sprite_index--;
else if keyboard_check_pressed(vk_up)
	image_speed += 0.125;
else if keyboard_check_pressed(vk_down)
	image_speed -= 0.125;


draw_sprite_ext(sprite_index, image_index, x, y, 4, 4, 0, c_white, 1);
draw_point(x, y);

var w = sprite_get_width(sprite_index) * 4;
var h = sprite_get_height(sprite_index) * 4;
draw_rectangle(x - w / 2, y - h / 2, x + w / 2, y + h / 2, true);

draw_text(0, 0, 
	"sprite name: " + string(sprite_get_name(sprite_index)) + "\n" +
	"sprite id: " + string(sprite_index) + "\n" +
	"info: " + string(sprite_get_info(sprite_index))
);



