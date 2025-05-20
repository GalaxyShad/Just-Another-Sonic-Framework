y = ystart + dsin(tick) * 2;

tick += 3;

if (tick == 30) {
    audio_play_sound(sndSplash, 0, 0);
}

if (tick == 120) {
    audio_play_sound(sndSplashSonicYea, 0, 0);
}

if (tick == 504) {
    instance_create_depth(x, y, -1000, objFade, {
        is_fade_in: false,
        on_finish: [self, function() {
            room_goto_next();
        }]
    })
}

