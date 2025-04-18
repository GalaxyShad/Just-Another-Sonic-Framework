


var num = audio_get_listener_count();
for( var i = 0; i < num; i++)
{
    var info = audio_get_listener_info(i);
    audio_set_master_gain(info[? "index"], 0.1);
    ds_map_destroy(info);
}

if (!variable_instance_exists(id, "character_builder")) {
	show_error(
		"[CHARACTER INITIALISATION ERROR]\n" +
		$"character_builder not exists.\n" +
		"You need to initialize this variable to create your character.\n",
		true
	)
}

show_debug_info = true;

o_dj = !instance_exists(objDJ) ? 
	instance_create_layer(x, y, layer, objDJ) :
	instance_find(objDJ, 0);
	
camera = !instance_exists(objCameraSonicWorlds) ? 
	instance_create_layer(x, y, layer, objCameraSonicWorlds) :
	instance_find(objCameraSonicWorlds, 0);

// camera = !instance_exists(objCamera) ? 
// 	instance_create_layer(x, y, layer, objCamera) :
// 	instance_find(objCamera, 0);

if (!instance_exists(objSolidTIlemapFinder))
	instance_create_depth(x, y, depth, objSolidTIlemapFinder);
	
camera.FollowingObject = id;

shield = undefined;

running_on_water = false;

animation_angle = 0;

allow_jump		= true;
allow_movement	= true;

remaining_air = 30;

#macro DELAY_UNDERWATER_EVENT		60
#macro DURATION_SUPER_FAST_SHOES	21*60
#macro DURATION_CONTROL_LOCK		30
#macro DURATION_INVINCIBILITY		120

timer_underwater  = new Timer2(
	DELAY_UNDERWATER_EVENT, 
	true, 
	function() {  player_underwater_event(plr); }
);

timer_speed_shoes = new Timer2(
	DURATION_SUPER_FAST_SHOES, 
	false, 
	function() { with plr physics.cancel_super_fast_shoes(); }
);

timer_control_lock = new Timer2(
	DURATION_CONTROL_LOCK,
	false,
	function() { with plr allow_movement = true; }
);

timer_invincibility = new Timer2(DURATION_INVINCIBILITY, false);

timer_powerup_invincibility = new Timer2(31 * 60, false);

plr = character_builder.build();
plr.state_machine.change_to("normal");


draw_player = function() {
	if (plr.draw_behind != undefined)
		plr.draw_behind(plr);	
	draw_self();	
}

p_sfx_water_run			= -1;

jump_surface = -1;


