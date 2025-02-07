array_foreach(visual_loop.get_loop(), function(_value, _index) {
	if (visual_loop.is_function_available(_value)) _value(plr);
});

state.animate();

var _res = animator.animate();

image_angle		= animation_angle;
sprite_index	= _res[0];
image_index		= _res[1];
image_speed		= 0;

if (physics.is_underwater() && !is_instanceof(shield, ShieldBubble))
	timer_underwater.tick();
	
timer_speed_shoes.tick();
timer_powerup_invincibility.tick();
timer_invincibility.tick();

position.x = x;
position.y = y;

