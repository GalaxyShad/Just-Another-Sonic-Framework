
function ShieldUseable() : BaseShield() constructor {
	use_ability = function() {
		show_error("[Shield] 'use_ability' not implemented" , true);
	};
	
	is_ability_used = function() {
		show_error("[Shield] 'is used' not implemented" , true);
	};
	
	reset_ability = function() {
		show_error("[Shield] 'reset' not implemented" , true);
	};
};