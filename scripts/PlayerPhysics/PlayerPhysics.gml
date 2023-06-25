
function PlayerPhysics(_custom_props = {}, _custom_superform_props = {}) constructor {

	__default_props = {
		// Ground
		acceleration_speed:			0.046875,
		deceleration_speed:			0.5,
		friction_speed:				0.046875,
		top_speed:					6,
		
		// Slopes
		slope_factor:				0.125,
		slope_factor_rollup:		0.078125,
		slope_factor_rolldown:		0.3125,
 
		// Air
		air_acceleration_speed:		0.09375,
 
		gravity_force:				0.21875,
		jump_force:					6.5,
		jump_release:				-4,	
 
		// Rolling
		roll_friction_speed:		0.0234375,
		roll_deceleration_speed:	0.125		
	};
	
	
	__default_superform_props = {
		acceleration_speed:			0.09375,
		deceleration_speed:			0.75,
		top_speed:					8,
		
		air_acceleration_speed:		0.1875
	};
	
	__custom_props				= _custom_props;
	__custom_superform_props	= _custom_superform_props;
	
	__is_underwater				= false;
	__is_super_fast_shoes_on	= false;
	__is_super					= false;
	
	
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

	is_underwater = function() {
		return __is_underwater;	
	};


	reset = function() {
		__apply_props(__default_props);
		if (__is_underwater) __apply_underwater();
	};
	
	
	apply_underwater = function() {
		if (__is_underwater) return;
		__apply_underwater();
		__is_underwater = true;
	};
	
	
	cancel_underwater = function() {
		if (!__is_underwater) return;
		__cancel_underwater();
		__is_underwater = false;	
	};
	
	
	apply_super_fast_shoes = function() {
		if (__is_super_fast_shoes_on) return;
		__apply_super_fast_shoes();
		__is_super_fast_shoes_on = true;
	};
	
	
	cancel_super_fast_shoes = function() {
		if (!__is_super_fast_shoes_on) return;
		__cancel_super_fast_shoes();
		__is_super_fast_shoes_on = false;
	};

	
	apply_super_form = function(_sonic_like = false) {
		__apply_props(__default_superform_props);
		
		if (__is_underwater) __apply_underwater();
	};
	
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
	
	__apply_props = function(_props) {
		struct_foreach(_props, function(name) {
			self[$ name] = _props[$ name] ?? self[$ name];
		});	
	};
	
	
	__apply_underwater = function() {
		acceleration_speed		/= 2;
		deceleration_speed		/= 2;
		friction_speed			/= 2;
		top_speed				/= 2;
		
		air_acceleration_speed	/= 2;
		
		roll_friction_speed		/= 2;
		
		jump_force				/= 2;
		jump_release			/= 2;
		
		gravity_force			/= 3.5;
	};
	
	
	__cancel_underwater = function() {
		acceleration_speed		*= 2;
		deceleration_speed		*= 2;
		friction_speed			*= 2;
		top_speed				*= 2;
		
		air_acceleration_speed	*= 2;
		
		roll_friction_speed		*= 2;
		
		jump_force				*= 2;
		jump_release			*= 2;
		
		gravity_force			*= 3.5;
	};
	
	
	__apply_super_fast_shoes = function() {
		acceleration_speed		*= 2;
		friction_speed			*= 2;
		top_speed				*= 2;
		air_acceleration_speed	*= 2;
		roll_friction_speed		*= 2;
	};
	
	
	__cancel_super_fast_shoes = function() {
		acceleration_speed		/= 2;
		friction_speed			/= 2;
		top_speed				/= 2;
		air_acceleration_speed	/= 2;
		roll_friction_speed		/= 2;
	};
	
	
	__init__ = function() {
		struct_foreach(__default_props, function(name) {
			__default_props[$ name] = __custom_props[$ name] ?? __default_props[$ name];
			self[$ name] = __default_props[$ name];
		});
		
		struct_foreach(__default_superform_props, function(name) {
			__default_superform_props[$ name] = 
				__custom_superform_props[$ name] ?? __default_superform_props[$ name];
		});
	}();	
	
};