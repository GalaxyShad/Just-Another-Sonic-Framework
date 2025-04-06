

function PlayerStateSkid() : BaseState() constructor {

	/// @param {Struct.Player} plr
	__create_dust_sfx = function(plr) {
		var _offset_y = plr.collider.get_radius().floor.height;
		var _offset_x = plr.inst.image_xscale * 12;
		
		instance_create_depth(
			plr.inst.x + _offset_y *  plr.collider.get_angle_data().sin
				       + _offset_x *  plr.collider.get_angle_data().cos, 
			plr.inst.y + _offset_y *  plr.collider.get_angle_data().cos
				       + _offset_x * -plr.collider.get_angle_data().sin, 
			plr.inst.depth-1, 
			objSfxSkidDust, {
				vspeed: -1
			}
		);
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) { 
		if (abs(plr.gsp) <= 0.5 || !plr.ground || 
		    ((plr.gsp < 0 && plr.input_x() < 0) || (plr.gsp > 0 && plr.input_x() > 0))
		) {
			plr.state_machine.change_to("normal");	
		}
		
		if (global.tick % 3 == 0) {
			__create_dust_sfx(plr);
		}
	};
	
	/// @param {Struct.Player} plr
	on_start = function(plr) { 
		plr.animator.set("skid");
		__create_dust_sfx(plr);
	};
}