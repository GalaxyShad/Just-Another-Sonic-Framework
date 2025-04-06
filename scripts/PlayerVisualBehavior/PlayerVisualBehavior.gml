/// @param {Struct.Player} plr
function player_behavior_visual_angle(plr) {
	if (plr.animator.current() == "curling") {
		plr.animation_angle = 0;
		return;
	}
	
	if (!plr.ground) {
		plr.animation_angle += angle_difference(0, plr.animation_angle) / 10;
	} else {
		var _ang = plr.collider.is_angle_in_range(35, 325) 
			? plr.collider.get_angle_data().degrees
			: 0;
			
		plr.animation_angle += angle_difference(_ang, plr.animation_angle) / 4;
	}
}

/// @param {Struct.Player} plr
function player_behavior_visual_flip(plr) {
	if (!plr.ground) {
		if		(plr.input_x() > 0)	image_xscale = 1;
		else if (plr.input_x() < 0)	image_xscale = -1;
	} else {
		if		(plr.input_x() > 0 && plr.gsp > 0)	image_xscale = 1;
		else if (plr.input_x() < 0 && plr.gsp < 0)	image_xscale = -1;
	}
}

/// @param {Struct.Player} plr
function player_behavior_visual_create_afterimage(plr) {
	if (!(plr.physics.is_super_fast_shoes_on() || (plr.physics.is_super() && abs(plr.gsp) >= 6)))
		return;
	
	if (global.tick % 8 != 0) return;
	
	instance_create_depth(plr.inst.x, plr.inst.y, plr.inst.depth+1, objSfxAfterImage, { 
		SpriteIndex:	plr.inst.sprite_index,
		ImageIndex:		plr.inst.image_index,
		Angle:			plr.animation_angle,
		Xscale:			plr.inst.image_xscale,
		Blend:			plr.physics.is_super() ? plr.palette.sfx_color_super : plr.palette.sfx_color
	});
}


