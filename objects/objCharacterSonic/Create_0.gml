character_builder = new CharacterBuilder(self);

character_builder
	.set_name("Sonic")
	.set_name_color(c_blue)

	.set_sign_post_sprite(sprSonicSignPost)

	.set_vfx_color(#0F52BA)
	.set_vfx_super_color(#FFCE57)

	.set_base_palette([ #2424b4, #2448d8, #4848fc, #6c6cfc ])

	.add_super_palette_fading_colors([ #ce9034, #ffac34, #ffce57, #ffff74 ])
	.add_super_palette_fading_colors([ #ffac74, #ffce90, #ffffac, #ffffce ])
	.add_super_palette_fading_colors([ #ffffaa, #ffffaa, #ffffaa, #ffffaa ])
	.add_super_palette_fading_colors([ #ffac74, #ffce90, #ffffac, #ffffce ])

	
	.configure_animations(function (anim) { 
		anim
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
			.add_super("look_down",	sprSuperSonicCrouch ).stop_on_end().speed(.25);
	})

	.configure_physics_super({
			acceleration_speed:		0.1875,
			deceleration_speed:		1,
			top_speed:				10,
			jump_force:				8,
			air_acceleration_speed: 0.375,
	})

	.configure_states(function (st) {
		st
			.override("jump",		new SonicStateJump())
			.override("look_up",	new SonicStateLookUp())
			
			.add("transform",	 new PlayerStateTransform(11))
			.add("peelout",	 new SonicStatePeelout())
			.add("dropdash",	 new SonicStateDropDash())
	})

event_inherited();