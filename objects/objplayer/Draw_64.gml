
if (!plr.show_debug_info)
	exit;

draw_text(
	camera_get_view_width(camera_get_default()) - 300, 16,
	$"version:			{GIT_COMMIT_ID} {GIT_UNIX_TIMESTAMP}\n"+
	$"character:		{object_get_name(object_index)}\n"+
	$"fps:				{fps}\n"+
	$"tick:				{global.tick}\n"+
	$"ground:			{plr.ground}\n" +
	$"action:			{plr.state_machine.current()}\n"+
	$"animation:		{plr.animator.current()}\n"+
	$"gsp:				{plr.gsp}\n" +
	$"xsp:				{plr.xsp}\n" +
	$"ysp:				{plr.ysp}\n" +
	$"x:				{x}\n" +
	$"y:				{y}\n" +
	$"sensor_angle_data: deg: {plr.collider.get_angle_data().degrees} | cos: {plr.collider.get_angle_data().cos} | sin: {plr.collider.get_angle_data().sin}  \n" +
	$"animation_angle:	{plr.animation_angle}\n" +
	$"\n" +
	$"remaining_air:	{plr.remaining_air}/{plr.timer_underwater.get_count()}\n"+
	$"speed_shoes:		{plr.timer_speed_shoes.get_count()}\n" +
	$"\n" +
	$"physics_underwater:	{plr.physics.is_underwater()}\n"+
	$"physics_fast_shoes:	{plr.physics.is_super_fast_shoes_on()}\n"+
	$"physics_super:		{plr.physics.is_super()}\n"+
	$"\n" +
	$"animator_image_speed:		{plr.animator.__image_speed}\n" +
	$"\n" +
	$"sprite_index:		{sprite_index}\n" +
	$"image_index:		{image_index}\n" +
	$"image_speed:		{image_speed}\n" +
	$"image_xscale:		{image_xscale}\n"
);
