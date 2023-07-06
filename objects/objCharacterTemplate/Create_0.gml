
SFX_COLOR_MAGIC			=	#FFFFFF;
SFX_COLOR_MAGIC_SUPER	=	#FFFFFF;

SENSOR_FLOORBOX_NORMAL	=	[8, 20];
SENSOR_FLOORBOX_ROLL	=	[7, 15];

SENSOR_WALLBOX_NORMAL	=	[10, 8];
SENSOR_WALLBOX_SLOPES	=	[10, 0];

sensor = new Sensor(x, y, SENSOR_FLOORBOX_NORMAL, SENSOR_WALLBOX_NORMAL);
state  = create_basic_player_states();

physics = new PlayerPhysics();

animator = new PlayerAnimator();

// Inherit the parent event
event_inherited();

