/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе











// Inherit the parent event
event_inherited();
item = ITEM_ELECTRIC_SHIELD;
action = function(breaker) {
	with breaker set_shield(new ShieldLightning());
};

