
SFX_COLOR_MAGIC			=	#FFFFFF;
SFX_COLOR_MAGIC_SUPER	=	#FFFFFF;

PAL_CLASSIC = [ #2424b4, #2448d8, #4848fc, #6c6cfc ];
PAL_SUPER   = [ 
	[ #ce9034, #ffac34, #ffce57, #ffff74 ],
	[ #ffac74, #ffce90, #ffffac, #ffffce ], 
	[ #ffffaa, #ffffaa, #ffffaa, #ffffaa ],
	[ #ffac74, #ffce90, #ffffac, #ffffce ], 
];

SENSOR_FLOORBOX_NORMAL	=	[8, 20];
SENSOR_FLOORBOX_ROLL	=	[7, 15];

SENSOR_WALLBOX_NORMAL	=	[10, 8];
SENSOR_WALLBOX_SLOPES	=	[10, 0];

position = { x: x, y: y};

collision_detector = new PlayerCollisionDetector(self);
state  = new State(self);
add_basic_player_states(state);

physics		= new PlayerPhysics();
animator	= new PlayerAnimator();

// Inherit the parent event
event_inherited();

