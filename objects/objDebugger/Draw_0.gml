
var _cam = camera_get_active();

x = camera_get_view_x(_cam);
y = camera_get_view_y(_cam);

draw_set_font(global.sprite_font_main);
draw_set_color(c_white);

if (show_debug_info) {
	draw_text(
		camera_get_view_width(_cam) + x - 100, y + 16,
		string_upper(
			$"version: {GIT_COMMIT_ID} {GIT_UNIX_TIMESTAMP}\n"+
			$"character: {object_get_name(inst_player.object_index)}\n"+
			$"fps: {fps}\n"+
			$"tick: {global.tick}\n"+
			$"ground: {inst_player.plr.ground}\n" +
			$"action: {inst_player.plr.state_machine.current()}\n"+
			$"animation: {inst_player.plr.animator.current()}\n"+
			$"gsp: {inst_player.plr.gsp}\n" +
			$"xsp: {inst_player.plr.xsp}\n" +
			$"ysp: {inst_player.plr.ysp}\n" +
			$"x: {inst_player.x}\n" +
			$"y: {inst_player.y}\n" +
			$"sensor_angle_data: deg: {inst_player.plr.collider.get_angle_data().degrees} | cos: {inst_player.plr.collider.get_angle_data().cos} | sin: {inst_player.plr.collider.get_angle_data().sin}  \n" +
			$"animation_angle: {inst_player.animation_angle}\n" +
			$"\n" +
			$"allow_jump: {inst_player.allow_jump}\n" +
			$"allow_movement: {inst_player.allow_movement}\n" +
			$"\n" +
			$"remaining_air: {inst_player.remaining_air}/{inst_player.timer_underwater.get_count()}\n"+
			$"speed_shoes: {inst_player.timer_speed_shoes.get_count()}\n" +
			$"\n" +
			$"physics_underwater: {inst_player.plr.physics.is_underwater()}\n"+
			$"physics_fast_shoes: {inst_player.plr.physics.is_super_fast_shoes_on()}\n"+
			$"physics_super: {inst_player.plr.physics.is_super()}\n"+
			$"\n" +
			$"running_on_water: {inst_player.running_on_water}\n" +
			$"\n" +
			$"animator_image_speed: {inst_player.plr.animator.__image_speed}\n" +
			$"\n" +
			$"timer underwater {inst_player.timer_underwater.get_count()}\n" +
			$"sprite_index: {inst_player.sprite_index}\n" +
			$"image_index: {inst_player.image_index}\n" +
			$"image_speed: {inst_player.image_speed}\n" +
			$"image_xscale: {inst_player.image_xscale}\n" )
	);
}