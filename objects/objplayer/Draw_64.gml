

if (!show_debug_info)
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
	$"animation_angle:	{animation_angle}\n" +
	$"\n" +
	$"allow_jump:		{allow_jump}\n" +
	$"allow_movement:	{allow_movement}\n" +
	$"\n" +
	$"remaining_air:	{remaining_air}/{timer_underwater.get_count()}\n"+
	$"speed_shoes:		{timer_speed_shoes.get_count()}\n" +
	$"\n" +
	$"physics_underwater:	{plr.physics.is_underwater()}\n"+
	$"physics_fast_shoes:	{plr.physics.is_super_fast_shoes_on()}\n"+
	$"physics_super:		{plr.physics.is_super()}\n"+
	$"\n" +
	$"running_on_water:		{running_on_water}\n" +
	$"\n" +
	$"animator_image_speed:		{plr.animator.__image_speed}\n" +
	$"\n" +
	$"timer underwater	{timer_underwater.get_count()}\n" +
	$"sprite_index:		{sprite_index}\n" +
	$"image_index:		{image_index}\n" +
	$"image_speed:		{image_speed}\n" +
	$"image_xscale:		{image_xscale}\n" 
);





