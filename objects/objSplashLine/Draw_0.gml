
draw_sprite(sprSplashLine, 0, x, y);
draw_sprite(sprSplashLine, 0, x, y-sprite_height);

y += 2;

if (y >= ystart + sprite_height) y = ystart;