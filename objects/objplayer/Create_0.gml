/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

var num = audio_get_listener_count();
for( var i = 0; i < num; i++;)
{
    var info = audio_get_listener_info(i);
    audio_set_master_gain(info[? "index"], 0.1);
    ds_map_destroy(info);
}

#macro SHIELD_NONE			0
#macro SHIELD_CLASSIC		1
#macro SHIELD_BUBBLE		2
#macro SHIELD_FIRE			3
#macro SHIELD_ELECTRIC		4

oDj = instance_create_layer(x, y, layer, objDJ);

shield = SHIELD_NONE;

running_on_water = false;

set_shield = function(_shield = SHIELD_NONE) {
	if (physics.is_underwater() && 
		(_shield == SHIELD_FIRE || _shield == SHIELD_ELECTRIC)
	) return;
	
	shield = _shield;
	
	if (shield == SHIELD_NONE)
		return;
		
	if (shield == SHIELD_BUBBLE)
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
	oDj.set_music("speed_shoes");
	
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

//knuckles
glide_rotation = 3;
glide_top = 24;
glide_gravity_force = 0.125;
climbe_speed = 1;

animation_angle = 0;

control_lock_timer = 0;

idle_anim_timer = 0;

using_shield_abbility = false;



ground = false;
climbe = false;

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

peelout_animation_spd = 0;

water_shield_scale = {
	xscale: 1,
	yscale: 1,
	
	__xscale: 1,
	__yscale: 1
};


#macro SENSOR_FLOORBOX_NORMAL	[8, 20]
#macro SENSOR_FLOORBOX_ROLL		[7, 15]
#macro SENSOR_FLOORBOX_GLIDE	[10, 10]

#macro SENSOR_WALLBOX_NORMAL	[10, 8]
#macro SENSOR_WALLBOX_SLOPES	[10, 0]

sensor = new Sensor(x, y, SENSOR_FLOORBOX_NORMAL, SENSOR_WALLBOX_NORMAL);
state = new State(id);
PlayerStates();
state.change_to("normal");

remaining_air = 30;

timer_underwater	= new Timer2(60, true, function() {
	if (array_contains([25, 20, 15], remaining_air)) {
		// warning chime	
		audio_play_sound(sndUnderwaterWarningChime, 0, 0);
	} 
	
	if (remaining_air == 12) {
		// drowning music	
		//show_debug_message("drowning music");
		oDj.set_music("drowning");
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


is_key_left = 0;
is_key_right = 0;
is_key_up = 0;
is_key_down = 0;
is_key_action = 0;

sprite_index_prev = 0;

pSfxWaterRun = noone;
