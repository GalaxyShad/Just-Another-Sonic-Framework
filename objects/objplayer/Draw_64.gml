/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

/*
x = mouse_x;
y = mouse_y;

if mouse_check_button(mb_left)
	sensor.angle--;
if mouse_check_button(mb_right)
	sensor.angle++;*/

if (!show_debug_info)
	exit;

draw_text(
	16, 240,
	"fps: " + string(fps) + "\n" +
	"ground: " + string(ground) + "\n" +
	"action: " + string(state.current()) + "\n" +
	"gsp: " + string(gsp) + "\n" +
	"xsp: " + string(xsp) + "\n" +
	"ysp: " + string(ysp) + "\n" +
	"angle: " + string(sensor.get_angle()) + "\n" +
	"animation_angle: " + string(animation_angle) + "\n" +
	"\n" +
	"allow_jump: " + string(allow_jump) + "\n" +
	"allow_movement: " + string(allow_movement) + "\n" +
	"\n" +
	"sprit_index: " + string(sprite_index) + "\n" +
	"image_index: " + string(image_index) + "\n" +
	"image_speed: " + string(image_speed) + "\n" +
	"image_xscale: " + string(image_xscale) + "\n"

	/*
	"edge_left: " + string(sensor.is_collision_left_edge()) + "\n" + 
	"edge_right: " + string(sensor.is_collision_right_edge()) + "\n"	
	
	"found-angle: " + string(sensor.get_ground_angle()) + "\n" +

	"collision-left: " + string(sensor.is_collision_left()) + "\n" +
	"collision-right: " + string(sensor.is_collision_right()) + "\n" +
	"collision-top: " + string(sensor.is_collision_top()) + "\n" +
	"collision-bottom: " + string(sensor.is_collision_bottom()) + "\n" +
	"collision-ground: " + string(sensor.is_collision_ground()) + "\n"
	*/
);





