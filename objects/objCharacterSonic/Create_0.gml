character_builder = new CharacterBuilder(self);

event_inherited();
exit;

SFX_COLOR_MAGIC			=	#0F52BA;
SFX_COLOR_MAGIC_SUPER	=	#FFCE57;

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

position = { x: x, y: y };

collision_detector = new PlayerCollisionDetector(self);
state  = new State(self);
add_basic_player_states(state);

state.override("jump",		new SonicStateJump());
state.override("look_up",	new SonicStateLookUp());

state.add("transform",	 new PlayerStateTransform(11));
state.add("peelout",	 new SonicStatePeelout());
state.add("dropdash",	 new SonicStateDropDash());

physics = new PlayerPhysics(,{
	acceleration_speed:		0.1875,
	deceleration_speed:		1,
	top_speed:				10,
	jump_force:				8,
	air_acceleration_speed: 0.375,
});

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

	.add("corksew", 	sprSonicCorcksew)
	
	.add("curling",		sprSonicRoll		)
	.add("dropdash",	sprSonicDropDash	).speed(.5)
	
	.add("spring",		sprSonicSpring		).speed(.125)
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
	.add_super("idle",		sprSuperSonic		).speed(0.25)
	.add_super("walking",	sprSuperSonicWalk	)
	.add_super("running",	sprSuperSonicRun	)
	.add_super("dash",		sprSuperSonicDash	)
	.add_super("look_up",	sprSuperSonicLookUp ).stop_on_end().speed(.25)
	.add_super("look_down",	sprSuperSonicCrouch ).stop_on_end().speed(.25)
;
animator.set("idle");


// Inherit the parent event
event_inherited();

