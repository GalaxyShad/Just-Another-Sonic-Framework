array_foreach(plr.visual_loop.get_loop(), function(_value, _index) {
	if (plr.visual_loop.is_function_available(_value)) _value(plr);
});

plr.state_machine.animate();

var _res = plr.animator.animate();

image_angle		= plr.animation_angle;
sprite_index	= _res[0];
image_index		= _res[1];
image_speed		= 0;

if (plr.physics.is_underwater() && !is_instanceof(plr.shield, ShieldBubble))
	plr.timer_underwater.tick();
	
plr.timer_speed_shoes.tick();
plr.timer_powerup_invincibility.tick();
plr.timer_invincibility.tick();

