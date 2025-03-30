
character_builder = new CharacterBuilder(self);

character_builder
	.set_base_palette([ #000000, #6C0024, #D80024, #FC486C ])
	.add_super_palette_fading_colors([ #000000, #6C0024, #D80048, #FC4890 ])
	.add_super_palette_fading_colors([ #000000, #902448, #FC486C, #FC6CB4 ]) 
	.add_super_palette_fading_colors([ #000000, #B4486C, #FC6C90, #FC90D8 ])
	.add_super_palette_fading_colors([ #000000, #D86C90, #FC90B4, #FCB4FC ]) 
	.add_super_palette_fading_colors([ #000000, #FC90B4, #FCB4D8, #FCD8FC ]) 
	.add_super_palette_fading_colors([ #000000, #FCB4D8, #FCD8FC, #FCFCFC ]) 
	.add_super_palette_fading_colors([ #000000, #FC90B4, #FCB4D8, #FCD8FC ]) 
	.add_super_palette_fading_colors([ #000000, #D86C90, #FC90B4, #FCB4FC ]) 
	.add_super_palette_fading_colors([ #000000, #B4486C, #FC6C90, #FC90D8 ])
	.add_super_palette_fading_colors([ #000000, #902448, #FC486C, #FC6CB4 ]) 

	.set_vfx_color(#D80024)
	.set_vfx_super_color(#FC90B4)

	.set_base_collision_radius(8, 20)
	.set_curling_collision_radius(7, 15)

	.configure_states(function (state) {
		state
			.add("glide",			new KnucklesStateGlide())
			.add("glideRotation",	new KnucklesStateGlideRotation())
			.add("land",			new KnucklesStateLand())
			.add("drop",			new KnucklesStateDrop())
			.add("climbe",			new KnucklesStateClimbe())
			.add("clambering",		new KnucklesStateClambering())
			.add("transform",		new PlayerStateTransform(2))

			.override("jump",		new KnucklesStateJump())
	})

	.configure_animations(function (anim) {
		anim
			.add("idle",		sprKnuckles			)
			.add("bored",		sprKnucklesBored    ).loop_from(2).speed(.25)
			.add("bored_ex",	sprKnucklesBoredEx  ).loop_from(2).speed(.25)
			
			.add("look_up",		sprKnucklesLookUp   ).stop_on_end().speed(.25)
			.add("look_down",	sprKnucklesCrouch   ).stop_on_end().speed(.25)
			
			.add("walking",		sprKnucklesWalk		)
			.add("running",		sprKnucklesRun		)
			.add("dash",		sprKnucklesRun		)
			
			.add("curling",		sprKnucklesRoll		)
		
			.add("corksew", 	sprKnucklesCorcksew)
			
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
			
			.add("transform",		sprKnucklesTransform).loop_from(1).speed(.25)
	})

// Inherit the parent event
event_inherited();

