

function PlayerStateSkid() : BaseState() constructor {
	__create_dust_sfx = function(player) {
		var _offset_y = player.sensor.get_floor_box().vradius;
		var _offset_x = player.image_xscale * 12;
		
		instance_create_depth(
			player.x + _offset_y *  player.sensor.get_angle_sin()
				     + _offset_x *  player.sensor.get_angle_cos(), 
			player.y + _offset_y *  player.sensor.get_angle_cos()
				     + _offset_x * -player.sensor.get_angle_sin(), 
			player.depth-1, 
			objSfxSkidDust 
		);
	};
	
	on_step = function(player) { with player {
		if (abs(gsp) <= 0.5 || !ground || 
		    ((gsp < 0 && is_key_left) || (gsp > 0 && is_key_right))
		) {
			state.change_to("normal");	
		}
		
		if (global.tick % 5 == 0) {
			other.__create_dust_sfx(player);
		}
	}};
	
	on_start = function(player) { 
		player.animator.set("skid");
		__create_dust_sfx(player);
	};
}