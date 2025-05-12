array_foreach(plr.visual_loop.get_loop(), function(_value, _index) {
	if (plr.visual_loop.is_function_available(_value)) _value(plr);
});

plr.state_machine.animate();

var _res = plr.animator.animate();

image_angle		= plr.animation_angle;
sprite_index	= _res[0];
image_index		= _res[1];
image_speed		= 0;

if (plr.physics.is_underwater() && !is_instanceof(plr.inst.shield, ShieldBubble)) {
	timer_underwater.tick();
}

timer_speed_shoes.tick();
timer_powerup_invincibility.tick();
timer_invincibility.tick();

