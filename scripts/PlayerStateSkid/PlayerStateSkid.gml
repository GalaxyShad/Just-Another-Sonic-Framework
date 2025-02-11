

function PlayerStateSkid() : BaseState() constructor {
	__create_dust_sfx = function(player) {
		var _offset_y = player.collision_detector.get_radius().floor.height;
		var _offset_x = player.image_xscale * 12;
		
		instance_create_depth(
			player.x + _offset_y *  player.collision_detector.get_angle_data().sin
				     + _offset_x *  player.collision_detector.get_angle_data().cos, 
			player.y + _offset_y *  player.collision_detector.get_angle_data().cos
				     + _offset_x * -player.collision_detector.get_angle_data().sin, 
			player.depth-1, 
			objSfxSkidDust, {
				vspeed: -1
			}
		);
	};
	
	on_step = function(player) { with player {
		if (abs(gsp) <= 0.5 || !ground || 
		    ((gsp < 0 && is_key_left) || (gsp > 0 && is_key_right))
		) {
			state.change_to("normal");	
		}
		
		if (global.tick % 3 == 0) {
			other.__create_dust_sfx(player);
		}
	}};
	
	on_start = function(player) { 
		player.animator.set("skid");
		__create_dust_sfx(player);
	};
}