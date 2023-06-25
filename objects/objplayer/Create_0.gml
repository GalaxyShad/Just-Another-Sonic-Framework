/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


#macro SHIELD_NONE			0
#macro SHIELD_CLASSIC		1
#macro SHIELD_BUBBLE		2
#macro SHIELD_FIRE			3
#macro SHIELD_ELECTRIC		4



shield = SHIELD_NONE;



show_debug_info = true;

physics = new PlayerPhysics(,{
	acceleration_speed:		0.1875,
	deceleration_speed:		1,
	top_speed:				10,
	
	air_acceleration_speed: 0.375,
	jump_force:				8,
});

physics.apply_underwater();


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

#macro ACT_NORMAL		0

#macro ACT_ROLL			2

#macro ACT_HURT			-2

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

#macro SENSOR_WALLBOX_NORMAL	[10, 8]
#macro SENSOR_WALLBOX_SLOPES	[10, 0]

sensor = new Sensor(x, y, SENSOR_FLOORBOX_NORMAL, SENSOR_WALLBOX_NORMAL);
state = new State(id);
PlayerStates();
state.change_to("normal");


is_key_left = 0;
is_key_right = 0;
is_key_up = 0;
is_key_down = 0;
is_key_action = 0;

sprite_index_prev = 0;
