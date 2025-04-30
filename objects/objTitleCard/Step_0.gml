
state();

if (fade_timer == 1) 
    instance_create_depth(x, y, depth, objFadeIn);

if (fade_timer > 0) 
    fade_timer--;

    
