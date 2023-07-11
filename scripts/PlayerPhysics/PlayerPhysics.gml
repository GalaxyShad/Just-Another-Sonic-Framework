
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

	is_underwater			= function() { return __is_underwater; };
	is_super_fast_shoes_on	= function() { return __is_super_fast_shoes_on; };
	is_super				= function() { return __is_super; };


	reset = function() {
		if (__is_underwater) __cancel_underwater();
		if (__is_super_fast_shoes_on) __cancel_super_fast_shoes(); 
		
		__is_super = false;
		__apply_props(__default_props);
		
		if (__is_super_fast_shoes_on) __apply_super_fast_shoes(); 
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

	
	apply_super_form = function() {
		if (__is_underwater) __cancel_underwater();
		if (__is_super_fast_shoes_on) __cancel_super_fast_shoes(); 
		
		__apply_props(__default_superform_props);
		__is_super = true;
		
		if (__is_super_fast_shoes_on) __apply_super_fast_shoes(); 
		if (__is_underwater) __apply_underwater();
	};
	
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
	
	__apply_props = function(_props = {}) {
		//var _p = _props;
		
		struct_foreach(_props, function(_name, _st) {
			show_debug_message($"{_name}: {_st}");
			self[$ _name] = _st ?? self[$ _name];
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
		struct_foreach(__default_props, function(_name) {
			__default_props[$ _name] = __custom_props[$ _name] ?? __default_props[$ _name];
			self[$ _name] = __default_props[$ _name];
		});
		
		struct_foreach(__default_props, function(_name) {
			__default_superform_props[$ _name] = 
				__custom_superform_props[$ _name] ?? __default_superform_props[$ _name];
		});
	}();	
	
};