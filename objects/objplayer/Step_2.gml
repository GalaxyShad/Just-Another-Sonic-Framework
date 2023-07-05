/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе



if (!ground) {
	animation_angle += angle_difference(0, animation_angle) / 10;
} else {
	var _ang = (sensor.get_angle() >= 35 && sensor.get_angle() <= 325) ? sensor.get_angle() : 0;
	animation_angle += angle_difference(_ang, animation_angle) / 4;
}

if (sprite_index == sprSonicRoll)
	animation_angle = 0;

if (animation_angle < 0) animation_angle = 360 + animation_angle;
animation_angle = (abs(animation_angle) % 360);

image_angle = animation_angle;

if (!ground) {
	if		(is_key_right)	image_xscale = 1;
	else if (is_key_left)	image_xscale = -1;
} else {
	if		(is_key_right && gsp > 0)	image_xscale = 1;
	else if (is_key_left  && gsp < 0)	image_xscale = -1;
}

state.animate();

var _res = animator.animate();
sprite_index	= _res[0];
image_index		= _res[1];
image_speed		= 0;

if ((physics.is_super_fast_shoes_on() || (physics.is_super() && abs(gsp) >= 6)) && 
	(global.tick % 8 == 0)
) {
	if (physics.is_super()) magic_color = #ffce57;
	
	instance_create_depth(x, y, depth+1, objSfxAfterImage, { 
		SpriteIndex: sprite_index,
		ImageIndex: image_index,
		Angle: animation_angle,
		Xscale: image_xscale,
		Blend: magic_color
	});
}


if (physics.is_underwater() && !is_instanceof(shield, ShieldBubble))
	timer_underwater.tick();
	
timer_speed_shoes.tick();
timer_invincibility.tick();

