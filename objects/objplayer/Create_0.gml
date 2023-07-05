/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

show_debug_info = false;

o_dj	= instance_create_layer(x, y, layer, objDJ);
camera	= instance_create_layer(x, y, layer, objCamera);

shield = undefined;

magic_color = #0F52BA;
running_on_water = false;

animation_angle = 0;

control_lock_timer = 0;
ground = false;

xsp = 0;
ysp = 0;
gsp = 0;

action = 0;
inv_timer = 0;

allow_jump		= true;
allow_movement	= true;

//peelout_animation_spd = 0;

#macro SENSOR_FLOORBOX_NORMAL	[8, 20]
#macro SENSOR_FLOORBOX_ROLL		[7, 15]

#macro SENSOR_WALLBOX_NORMAL	[10, 8]
#macro SENSOR_WALLBOX_SLOPES	[10, 0]

sensor = new Sensor(x, y, SENSOR_FLOORBOX_NORMAL, SENSOR_WALLBOX_NORMAL);
state  = create_basic_player_states();

remaining_air = 30;

physics = new PlayerPhysics(,{
	acceleration_speed:		0.1875,
	deceleration_speed:		1,
	top_speed:				10,
	jump_force:				8,
	air_acceleration_speed: 0.375,
});

#macro UNDERWATER_EVENT_DELAY		60
#macro SUPER_FAST_SHOES_DURATION	21*60

timer_underwater  = new Timer2(
	UNDERWATER_EVENT_DELAY, 
	true, 
	function() { with self player_underwater_event(); }
);

timer_speed_shoes = new Timer2(
	SUPER_FAST_SHOES_DURATION, 
	false, 
	function() { with self physics.cancel_super_fast_shoes(); }
);

animator = new PlayerAnimator();

animator
	.add("idle",		sprSonic			)
	.add("bored",		sprSonicBored		).loop_from(2).speed(.25)
	.add("bored_ex",	sprSonicBoredEx		).loop_from(2).speed(.25)
	
	.add("look_up",		sprSonicLookUp		).stop_on_end().speed(.25)
	.add("look_down",	sprSonicCrouch		).stop_on_end().speed(.25)
	
	.add("walking",		sprSonicWalk		)
	.add("running",		sprSonicRun			)
	.add("dash",		sprSonicDash		)
	
	.add("curling",		sprSonicRoll		)
	.add("dropdash",	sprSonicDropDash	).speed(.5)
	
	.add("spring",		sprSonicSpring		)
	.add("spindash",	sprSonicSpindash	)
	.add("push",		sprSonicPush		).speed(.125)
	
	.add("skid",		sprSonicSkid		).stop_on_end().speed(.5)
	
	.add("balancing_a",	sprSonicBalancing	).speed(.05)
	.add("balancing_b",	sprSonicBalancingB	).speed(.25)
	
	.add("hurt",		sprSonicHurt		).stop_on_end()
	.add("breathe",		sprSonicBreathe		)
	
	.add("die",			sprSonicDie			).speed(0)
	
	.add("transform",   sprSonicTransform	).stop_on_end().speed(.5)
	
	// === Super ===
	.add_super("idle",		sprSuperSonic	 ).speed(0.25)
	.add_super("walking",	sprSuperSonicWalk)
	.add_super("running",	sprSuperSonicRun )
	.add_super("dash",		sprSuperSonicDash )
	.add_super("look_up",	sprSuperSonicLookUp ).stop_on_end().speed(.25)
	.add_super("look_down",	sprSuperSonicCrouch ).stop_on_end().speed(.25)
;

animator.set("idle");

is_key_left				= false;
is_key_right			= false;
is_key_up				= false;
is_key_down				= false;
is_key_action			= false;
is_key_action_pressed	= false;

sprite_index_prev		= 0;

p_sfx_water_run			= -1;
