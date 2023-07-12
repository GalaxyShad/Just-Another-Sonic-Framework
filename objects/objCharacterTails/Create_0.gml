
tired = false;

SFX_COLOR_MAGIC			=	#FC9000;
SFX_COLOR_MAGIC_SUPER	=	#FFCE57;

PAL_CLASSIC = [ #900000, #B46C48, #FC9000, #FCB400 ];
PAL_SUPER   = [ 
	[ #B46C48, #B46C48, #FCB424, #FCD848 ], 
	[ #D86C48, #D86C48, #FCD848, #FCD890 ],
	[ #FC9048, #FC9048, #FCD890, #FCFCB4 ],
	[ #D86C48, #D86C48, #FCD848, #FCD890 ],
];

SENSOR_FLOORBOX_NORMAL	=	[9, 15];
SENSOR_FLOORBOX_ROLL	=	[7, 14];

SENSOR_WALLBOX_NORMAL	=	[10, 8];
SENSOR_WALLBOX_SLOPES	=	[10, 0];

sensor = new Sensor(x, y, SENSOR_FLOORBOX_NORMAL, SENSOR_WALLBOX_NORMAL);
state  = new State(self);
add_basic_player_states(state);

state.override("jump",		new TailsStateJump());

state.add("fly",			new TailsStateFly());

physics = new PlayerPhysics();

animator = new PlayerAnimator();
animator
	.add("idle",		sprTails		)
	.add("bored",		sprTailsBored	).stop_on_end().speed(.1)
	.add("bored_ex",	sprTailsBoredEx	).speed(.05)
	
	.add("look_up",		sprTailsLookUp	).stop_on_end().speed(.25)
	.add("look_down",	sprTailsCrouch	).stop_on_end().speed(.25)
	
	.add("walking",		sprTailsWalk	)
	.add("running",		sprTailsRun		)
	.add("dash",		sprTailsDash	)
	
	.add("curling",		sprTailsRoll	)
	
	.add("spring",		sprTailsCorkscrew)
	.add("spindash",	sprTailsSpindash)
	.add("push",		sprTailsPush	).speed(.125)
	
	.add("skid",		sprTailsSkid	).stop_on_end().speed(.5)
	
	.add("balancing_a",	sprTailsBalancing).speed(.05)
	.add("balancing_b",	sprTailsBalancing).speed(.05)
	
	.add("hurt",		sprTailsHurt	).stop_on_end()
	.add("breathe",		sprTailsBreathe	).stop_on_end().speed(.5)	
	
	.add("die",			sprTailsDie		).speed(0)
		
	.add("transform",   sprTailsTransform).stop_on_end().speed(.5)
	.add("fly",			sprTailsFly		).speed(.125)
	.add("fly_tired",	sprTailsFlyTired).speed(.125)
	.add("swim",		sprTailsSwim	).speed(.125)
	.add("swim_tired",	sprTailsSwimTired).speed(.125)
;
animator.set("idle");


draw_player = function() {
	if ((state.current()=="normal" || state.current()=="look_up" || state.current()=="look_down" || state.current()=="hang") && xsp==0 && ysp==0 || state.current()=="breathe") draw_sprite_ext(sprTailsTailType1,global.tick/10,x,y,image_xscale,1,0,c_white,255);
	if (state.current()=="push" || state.current()=="skid") draw_sprite_ext(sprTailsTailType2,global.tick/10,x-6*image_xscale,y+10,image_xscale,1,0,c_white,255);
	if (state.current()=="spindash") draw_sprite_ext(sprTailsTailType2,global.tick/10,x-12*image_xscale,y+10,image_xscale,1,0,c_white,255);
	if (state.current()=="roll" || state.current()=="jump") draw_sprite_ext(sprTailsTailType3,global.tick/10,x,y,1,xsp!=0 ? sign(xsp) : 1,point_direction(0,0,xsp,ysp),c_white,255);	
	
	draw_self();
}


// Inherit the parent event
event_inherited();

