
drop_time = 0;

SFX_COLOR_MAGIC			=	#D80024;
SFX_COLOR_MAGIC_SUPER	=	#FC90B4;

PAL_CLASSIC = [ #000000, #6C0024, #D80024, #FC486C ];
PAL_SUPER   = [ 
	[ #000000, #6C0024, #D80048, #FC4890 ],
	[ #000000, #902448, #FC486C, #FC6CB4 ], 
	[ #000000, #B4486C, #FC6C90, #FC90D8 ],
	[ #000000, #D86C90, #FC90B4, #FCB4FC ], 
	[ #000000, #FC90B4, #FCB4D8, #FCD8FC ], 
	[ #000000, #FCB4D8, #FCD8FC, #FCFCFC ], 
	[ #000000, #FC90B4, #FCB4D8, #FCD8FC ], 
	[ #000000, #D86C90, #FC90B4, #FCB4FC ], 
	[ #000000, #B4486C, #FC6C90, #FC90D8 ],
	[ #000000, #902448, #FC486C, #FC6CB4 ], 
];

SENSOR_FLOORBOX_NORMAL	=	[8, 20];
SENSOR_FLOORBOX_ROLL	=	[7, 15];
SENSOR_FLOORBOX_SPECIAL	=	[10,10]; //Glide and Climbe

SENSOR_WALLBOX_NORMAL	=	[10, 8];
SENSOR_WALLBOX_SLOPES	=	[10, 0];

sensor = new Sensor(x, y, SENSOR_FLOORBOX_NORMAL, SENSOR_WALLBOX_NORMAL);
state  = new State(self);
add_basic_player_states(state);

state.override("jump",		new KnucklesStateJump());

state.add("glide",			new KnucklesStateGlide());
state.add("glideRotation",	new KnucklesStateGlideRotation());
state.add("land",			new KnucklesStateLand());
state.add("drop",			new KnucklesStateDrop());
state.add("climbe",			new KnucklesStateClimbe());
state.add("clambering",		new KnucklesStateClambering());

physics = new PlayerPhysics();

animator = new PlayerAnimator();
animator
	.add("idle",		sprKnuckles			)
	.add("bored",		sprKnucklesBored    ).loop_from(2).speed(.25)
	.add("bored_ex",	sprKnucklesBoredEx  ).loop_from(2).speed(.25)
	
	.add("look_up",		sprKnucklesLookUp   ).stop_on_end().speed(.25)
	.add("look_down",	sprKnucklesCrouch   ).stop_on_end().speed(.25)
	
	.add("walking",		sprKnucklesWalk		)
	.add("running",		sprKnucklesRun		)
	.add("dash",		sprKnucklesRun		)
	
	.add("curling",		sprKnucklesRoll		)
	
	.add("spring",		sprKnucklesSpring	)
	.add("spindash",	sprKnucklesSpindash	)
	.add("push",		sprKnucklesPush		).speed(.125)
	
	.add("skid",		sprKnucklesSkid		).stop_on_end().speed(.5)
	
	.add("balancing_a",	sprKnucklesBalancing).speed(.05)
	.add("balancing_b",	sprKnucklesBalancingB).speed(.25)
	
	.add("hurt",		sprKnucklesHurt		).stop_on_end()
	.add("breathe",		sprKnucklesSkid		).stop_on_end().speed(.5)	
	
	.add("die",			sprKnucklesDie		).speed(0)
	
	
	.add("glide",			sprKnucklesGlide	)
	.add("glideRotation",	sprKnucklesUngroundedRotation)//.speed(0.075)
	.add("drop",			sprKnucklesDrop		).stop_on_end().speed(0.1)
	.add("land",			sprKnucklesLand		).speed(0)
	.add("climbe",			sprKnucklesClimbe	).speed(0)
	.add("clambering",		sprKnucklesClambering).stop_on_end().speed(0.1)
	
	.add("transform",		sprKnucklesTransform).stop_on_end().speed(.5)
;
animator.set("idle");


// Inherit the parent event
event_inherited();

