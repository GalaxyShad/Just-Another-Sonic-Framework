/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


enum Shield {
	None,
	Classic,
	Bubble,
	Flame,
	Lightning
};

o_dj = instance_create_layer(x, y, layer, objDJ);

shield = Shield.None;

magic_color = #0F52BA;
running_on_water = false;

set_shield = function(_shield = Shield.None) {
	if (physics.is_underwater() && 
		(_shield == Shield.Flame || _shield == Shield.Lightning)
	) return;
	
	shield = _shield;
	
	if (shield == Shield.None)
		return;
		
	if (shield == Shield.Bubble)
		player_underwater_regain_air();
	
	var _sounds = [
		sndBlueShield, 
		sndBubbleShield, 
		sndFireShield, 
		sndLightningShield
	];
	
	audio_play_sound(_sounds[_shield - 1], 0, 0);
}

equip_speed_shoes = function() {
	o_dj.set_music("speed_shoes");
	
	timer_speed_shoes.reset();
	timer_speed_shoes.start();
	
	physics.apply_super_fast_shoes();	
}

show_debug_info = true;

physics = new PlayerPhysics(,{
	acceleration_speed:		0.1875,
	deceleration_speed:		1,
	top_speed:				10,
	jump_force:				8,
	air_acceleration_speed: 0.375,
});

//physics.apply_super_form();
//physics.apply_super_fast_shoes();

kgr = 3; //knuckles_glid_rotation
glid_top=5;

animation_angle = 0;

control_lock_timer = 0;

idle_anim_timer = 0;

using_shield_abbility = false;



ground = false;

xsp = 0;
ysp = 0;
gsp = 0;

camera = instance_create_layer(x, y, layer, objCamera);

action = 0;

peelout_timer = 0;

inv_timer = 0;


drpspd		= 8; //the base speed for a drop dash

allow_jump		= true;
allow_movement	= true;

//peelout_animation_spd = 0;

water_shield_scale = {
	xscale: 1,
	yscale: 1,
	
	__xscale: 1,
	__yscale: 1
};


#macro SENSOR_FLOORBOX_NORMAL	[8, 20]
#macro SENSOR_FLOORBOX_ROLL		[7, 15]

#macro SENSOR_WALLBOX_NORMAL	[10, 8]
#macro SENSOR_WALLBOX_SLOPES	[10, 0]

sensor = new Sensor(x, y, SENSOR_FLOORBOX_NORMAL, SENSOR_WALLBOX_NORMAL);
state = new State(id);
player_states();
state.change_to("normal");

remaining_air = 30;

timer_underwater	= new Timer2(60, true, function() {
	if (array_contains([25, 20, 15], remaining_air)) {
		// warning chime	
		audio_play_sound(sndUnderwaterWarningChime, 0, 0);
	} 
	
	if (remaining_air == 12) {
		// drowning music	
		show_debug_message("drowning music");
		o_dj.set_music("drowning");
	} 
	
	if (array_contains([12, 10, 8, 6, 4, 2], remaining_air)) {
		// warning number bubble
		var _number = (remaining_air / 2) - 1;
		instance_create_depth(
			x + 6 * image_xscale, y, -1000, objBubbleCountdown, { number: _number });
	} 
	
	if (remaining_air == 0) {
		// player drown	
		audio_play_sound(sndPlrDrown, 0, 0);
		state.change_to("die");
	}
	
	instance_create_depth(x + 6 * image_xscale, y, -1000, objBreathingBubble);
	
	remaining_air--;
});

timer_speed_shoes	= new Timer2(21 * 60, false, physics.cancel_super_fast_shoes);



animator = new PlayerAnimator();

animator
	.add("idle",		sprSonic			)
	.add("bored",		sprSonicBored		).loop_from(2).speed(1/30)
	.add("bored_ex",	sprSonicBoredEx		).loop_from(2).speed(1/30)
	
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
	
	// === Super ===
	.add_super("idle",		sprSuperSonic	 ).speed(0.25)
	.add_super("walking",	sprSuperSonicWalk)
	.add_super("running",	sprSuperSonicRun )
	.add_super("dash",		sprSuperSonicDash )
	.add_super("look_up",	sprSuperSonicLookUp ).stop_on_end().speed(.25)
	.add_super("look_down",	sprSuperSonicCrouch ).stop_on_end().speed(.25)
;

animator.set("idle");

animator.set_form_super();
physics.apply_super_form();
	
is_key_left				= false;
is_key_right			= false;
is_key_up				= false;
is_key_down				= false;
is_key_action			= false;
is_key_action_pressed	= false;

sprite_index_prev		= 0;

p_sfx_water_run			= -1;
