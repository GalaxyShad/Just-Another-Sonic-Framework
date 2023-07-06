
var _VAR_CHECK_LIST = [
	"SFX_COLOR_MAGIC",
	"SFX_COLOR_MAGIC_SUPER",
	
	"SENSOR_FLOORBOX_NORMAL",
	"SENSOR_FLOORBOX_ROLL",
	
	"SENSOR_WALLBOX_NORMAL",
	"SENSOR_WALLBOX_SLOPES",
	
	"sensor",
	"state",
	"physics",
	
	"animator"
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
	sensor:			[Sensor,			"Sensor"		],
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

show_debug_info = true;

o_dj = !instance_exists(objDJ) ? 
	instance_create_layer(x, y, layer, objDJ) :
	instance_find(objDJ, 0);
camera = !instance_exists(objCamera) ? 
	instance_create_layer(x, y, layer, objCamera) :
	instance_find(objCamera, 0);
	
camera.FollowingObject = id;

shield = undefined;

running_on_water = false;

animation_angle = 0;

ground = false;

xsp = 0;
ysp = 0;
gsp = 0;

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


behavior_loop = new PlayerLoop(id);
behavior_loop
	.add(player_switch_sensor_radius)
	.add(player_collision)
	.add(player_ground_movement)
	.add(player_air_movement)

handle_loop = new PlayerLoop(id);
handle_loop
	.add(player_handle_layers)
	.add(player_handle_rings)
	.add(player_handle_springs)
	.add(player_handle_spikes)
	.add(player_handle_monitors)
	.add(player_handle_moving_platforms)
	.add(player_handle_water)
	.add(player_handle_bubbles)
;



is_key_left				= false;
is_key_right			= false;
is_key_up				= false;
is_key_down				= false;
is_key_action			= false;
is_key_action_pressed	= false;

p_sfx_water_run			= -1;
