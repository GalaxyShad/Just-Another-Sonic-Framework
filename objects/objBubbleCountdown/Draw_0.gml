
if (y <= oWater.y)
	instance_destroy();

if (anim_index < appearence_frames_count) {
	draw_sprite(appearence_sprite, floor(anim_index), x, y);	
} else {
	draw_sprite(
		number_sprite, 
		number + 6 * (floor(anim_index) == appearence_frames_count), 
		x + sin(tick) * 4, y
	);	
}

tick += 0.125;

anim_index += anim_speed;


