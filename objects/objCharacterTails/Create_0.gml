
character_builder = new CharacterBuilder(self);

character_builder
	.set_vfx_color(#FC9000)
	.set_vfx_super_color(#FFCE57)

	.set_base_palette([ #900000, #B46C48, #FC9000, #FCB400 ])

	.add_super_palette_fading_colors([ #B46C48, #B46C48, #FCB424, #FCD848 ])
	.add_super_palette_fading_colors([ #D86C48, #D86C48, #FCD848, #FCD890 ])
	.add_super_palette_fading_colors([ #FC9048, #FC9048, #FCD890, #FCFCB4 ])
	.add_super_palette_fading_colors([ #D86C48, #D86C48, #FCD848, #FCD890 ])

	.set_base_collision_radius(9, 15)
	.set_curling_collision_radius(7, 14)

	.configure_states(function(st) {
		st
			.override("jump", new TailsStateJump())

			.add("fly",		  new TailsStateFly())
			.add("transform", new PlayerStateTransform(2))		
	})

	.configure_animations(function (animator) {
		animator
			.add("idle",		sprTails		)
			.add("bored",		sprTailsBored	).stop_on_end().speed(.1)
			.add("bored_ex",	sprTailsBoredEx	).speed(.05)
			
			.add("look_up",		sprTailsLookUp	).stop_on_end().speed(.25)
			.add("look_down",	sprTailsCrouch	).stop_on_end().speed(.25)
			
			.add("walking",		sprTailsWalk	)
			.add("running",		sprTailsRun		)
			.add("dash",		sprTailsDash	)

			.add("corksew", 	sprTailsCorkscrew)
			
			.add("curling",		sprTailsRoll	)
			
			.add("spring",		sprTailsSpring)
			.add("spindash",	sprTailsSpindash)
			.add("push",		sprTailsPush	).speed(.125)
			
			.add("skid",		sprTailsSkid	).stop_on_end().speed(.5)
			
			.add("balancing_a",	sprTailsBalancing).speed(.05)
			.add("balancing_b",	sprTailsBalancing).speed(.05)
			
			.add("hurt",		sprTailsHurt	).stop_on_end()
			.add("breathe",		sprTailsBreathe	).stop_on_end().speed(.5)	
			
			.add("die",			sprTailsDie		).speed(0)
				
			.add("transform",   sprTailsTransform).loop_from(1).speed(.25)
			.add("fly",			sprTailsFly		).speed(.125)
			.add("fly_tired",	sprTailsFlyTired).speed(.125)
			.add("swim",		sprTailsSwim	).speed(.125)
			.add("swim_tired",	sprTailsSwimTired).speed(.125)
	})



draw_player = function() {
	// if ((state.current()=="normal" || state.current()=="look_up" || state.current()=="look_down" || state.current()=="hang") && plr.xsp==0 && plr.ysp==0 || state.current()=="breathe") draw_sprite_ext(sprTailsTailType1,global.tick/10,x,y,image_xscale,1,0,c_white,255);
	// if (state.current()=="push" || state.current()=="skid") draw_sprite_ext(sprTailsTailType2,global.tick/10,x-6*image_xscale,y+10,image_xscale,1,0,c_white,255);
	// if (state.current()=="spindash") draw_sprite_ext(sprTailsTailType2,global.tick/10,x-12*image_xscale,y+10,image_xscale,1,0,c_white,255);
	// if (state.current()=="roll" || state.current()=="jump") draw_sprite_ext(sprTailsTailType3,global.tick/10,x,y,1,plr.xsp!=0 ? sign(plr.xsp) : 1,point_direction(0,0,plr.xsp,plr.ysp),c_white,255);	
	
	// draw_self();
}

// Inherit the parent event
event_inherited();

