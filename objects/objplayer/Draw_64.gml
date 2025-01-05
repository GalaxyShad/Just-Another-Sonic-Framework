

if (!show_debug_info)
	exit;
	

draw_text(
	camera_get_view_width(camera_get_default()) - 200, 16,
	$"character:		{object_get_name(object_index)}\n"+
	$"fps:				{fps}\n"+
	$"tick:				{global.tick}\n"+
	$"ground:			{ground}\n" +
	$"action:			{state.current()}\n"+
	$"animation:		{animator.current()}\n"+
	$"gsp:				{gsp}\n" +
	$"xsp:				{xsp}\n" +
	$"ysp:				{ysp}\n" +
	$"x:				{x}\n" +
	$"y:				{y}\n" +
	$"sensor_angle:		{sensor.get_angle()}\n" +
	$"animation_angle:	{animation_angle}\n" +
	$"\n" +
	$"allow_jump:		{allow_jump}\n" +
	$"allow_movement:	{allow_movement}\n" +
	$"\n" +
	$"remaining_air:	{remaining_air}/{timer_underwater.get_count()}\n"+
	$"speed_shoes:		{timer_speed_shoes.get_count()}\n" +
	$"\n" +
	$"physics_underwater:	{physics.is_underwater()}\n"+
	$"physics_fast_shoes:	{physics.is_super_fast_shoes_on()}\n"+
	$"physics_super:		{physics.is_super()}\n"+
	$"\n" +
	$"running_on_water:		{running_on_water}\n" +
	$"\n" +
	$"animator_image_speed:		{animator.__image_speed}\n" +
	$"\n" +
	$"sprite_index:		{sprite_index}\n" +
	$"image_index:		{image_index}\n" +
	$"image_speed:		{image_speed}\n" +
	$"image_xscale:		{image_xscale}\n"
);





