draw_self();


if (activated) {
	ball_frame += image_speed;
	
	ball_frame %= sprite_get_number(sprCheckpointCircle);
}

draw_sprite(sprCheckpointCircle, ball_frame, ball_pos.x, ball_pos.y);

draw_text(x, y-64, string(ball_speed.y))