instance_create_depth(x, y, depth, objFade, {
    speed: 0.25,
    is_fade_in: false,
    on_finish: [self, function(ctx) { room_goto(ctx.next_scene) }]
});