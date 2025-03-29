/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе











// Inherit the parent event
event_inherited();
item = ITEM_SUPER;
action = function(breaker) {
	with breaker plr.state_machine.change_to("transform");
};

