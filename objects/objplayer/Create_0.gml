
var num = audio_get_listener_count();
for( var i = 0; i < num; i++)
{
    var info = audio_get_listener_info(i);
    audio_set_master_gain(info[? "index"], 0.1);
    ds_map_destroy(info);
}

var _VAR_CHECK_LIST = [
	"SFX_COLOR_MAGIC",
	"SFX_COLOR_MAGIC_SUPER",
	
	"SENSOR_FLOORBOX_NORMAL",
	"SENSOR_FLOORBOX_ROLL",
	
	"SENSOR_WALLBOX_NORMAL",
	"SENSOR_WALLBOX_SLOPES",
	
	"state",
	"physics",
	
	"animator",
	
	"PAL_CLASSIC",
	"PAL_SUPER",
];

array_foreach(_VAR_CHECK_LIST, function(_variable) {
	if (!variable_instance_exists(id, _variable)) {
		show_error(
			"[CHARACTER INITIALISATION ERROR]\n" +
			$"Variable [{_variable}] is not exist.\n" +
			"You need to initialize this variable to create your character.\n",
			true
		)
	}
});

var _VAR_TYPES_CHECK_MAP = {
	state:			[State,				"State"			],
	physics:		[PlayerPhysics,		"PlayerPhysics"	],
	animator:		[PlayerAnimator,	"PlayerAnimator"]
};

struct_foreach(_VAR_TYPES_CHECK_MAP, function(_key, _value) {
	var _instance_variable = variable_instance_get(id, _key);
	
	if (!is_instanceof(_instance_variable, _value[0])) {
		show_error(
			"[CHARACTER INITIALISATION ERROR]\n" +
			$"Variable [{_key}] should be the type of [{_value[1]}].\n",
			true
		)	
	}
});

if (!variable_instance_exists(id, "draw_player")) {
	draw_player = function() {
		draw_self();	
	}
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
	
camera.FollowingObject = id;

PALLETE_SUPER_CYCLE_LENGTH = array_length(PAL_SUPER); 

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
	function() { with self player_underwater_event(); }
);

timer_speed_shoes = new Timer2(
	DURATION_SUPER_FAST_SHOES, 
	false, 
	function() { with self physics.cancel_super_fast_shoes(); }
);

timer_control_lock = new Timer2(
	DURATION_CONTROL_LOCK,
	false,
	function() { with self allow_movement = true; }
);

timer_invincibility = new Timer2(DURATION_INVINCIBILITY, false);

timer_powerup_invincibility = new Timer2(31 * 60, false);

plr = new Player(
	self,
	collision_detector,
	state,
	animator,
	physics
)

behavior_loop = new PlayerLoop();
behavior_loop
	.add(player_switch_sensor_radius)
	
	// Collisions
	.add(player_behavior_collisions)
	
	// Ground
	.add(player_behavior_slope_decceleration)
	.add(player_behavior_ground_movement)
	.add(player_behavior_ground_friction)
	.add(player_behavior_fall_off_slopes)
	
	// Air (!ground)
	.add(player_behavior_apply_gravity)
	.add(player_behavior_air_movement)
	.add(player_behavior_air_drag)
	.add(player_behavior_jump)
;

handle_loop = new PlayerLoop();
handle_loop
	.add(player_handle_layers)
	.add(player_handle_rings)
	.add(player_handle_springs)
	.add(player_handle_spikes)
	.add(player_handle_monitors)
	.add(player_handle_moving_platforms)
	.add(player_handle_water)
	.add(player_handle_bubbles)
	.add(player_handle_enemy)
	.add(player_handle_corksew)
	.add(player_handle_projectile)
;

visual_loop = new PlayerLoop();
visual_loop
	.add(player_behavior_visual_angle)
	.add(player_behavior_visual_flip)
	.add(player_behavior_visual_create_afterimage)
;

is_key_left				= false;
is_key_right			= false;
is_key_up				= false;
is_key_down				= false;
is_key_action			= false;
is_key_action_pressed	= false;

p_sfx_water_run			= -1;

jump_surface = -1;


