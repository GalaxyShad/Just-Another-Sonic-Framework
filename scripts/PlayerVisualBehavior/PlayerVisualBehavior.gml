
function player_behavior_visual_angle() {
	if (animator.current() == "curling") {
		animation_angle = 0;
		return;
	}
	
	if (!ground) {
		animation_angle += angle_difference(0, animation_angle) / 10;
	} else {
		var _ang = collision_detector.is_angle_in_range(35, 325) 
			? collision_detector.get_angle_data().degrees
			: 0;
			
		animation_angle += angle_difference(_ang, animation_angle) / 4;
	}
}


function player_behavior_visual_flip() {
	if(state.current() == "climbe") show_debug_message("Hi");
	if (!ground) {
		if		(is_key_right)	image_xscale = 1;
		else if (is_key_left)	image_xscale = -1;
	} else {
		if		(is_key_right && gsp > 0)	image_xscale = 1;
		else if (is_key_left  && gsp < 0)	image_xscale = -1;
	}
}


function player_behavior_visual_create_afterimage() {
	if (!(physics.is_super_fast_shoes_on() || (physics.is_super() && abs(gsp) >= 6)))
		return;
	
	if (global.tick % 8 != 0) return;
	
	instance_create_depth(x, y, depth+1, objSfxAfterImage, { 
		SpriteIndex:	sprite_index,
		ImageIndex:		image_index,
		Angle:			animation_angle,
		Xscale:			image_xscale,
		Blend:			physics.is_super() ? SFX_COLOR_MAGIC_SUPER : SFX_COLOR_MAGIC
	});
}


