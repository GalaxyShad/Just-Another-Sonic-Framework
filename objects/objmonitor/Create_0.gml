/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе
is_destroyed = false;
is_falling   = false;

#macro ITEM_NONE			-1
#macro ITEM_RING			0
#macro ITEM_SHIELD			1
#macro ITEM_ELECTRIC_SHIELD	2
#macro ITEM_FIRE_SHIELD		3
#macro ITEM_WATER_SHIELD	4
#macro ITEM_INVINCIBILITY	5
#macro ITEM_SPEED_SNEAKERS	6
#macro ITEM_SUPER			7
#macro ITEM_EGGMAN			8
#macro ITEM_1UP				9

//item = ITEM_RING;

action = function(breaker) {

};

destroy = function(breaker) {
	var _o_icon = instance_create_depth(x, y, 5, objMonitorIcon);
	
	_o_icon.image_index = item;
	_o_icon.action = action;
	_o_icon.breaker = other;
	
	instance_destroy();
}









