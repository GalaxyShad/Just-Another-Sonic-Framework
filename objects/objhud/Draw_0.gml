/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе
draw_set_font(global.font);
var _mili_seconds = global.tick % 100;
var _seconds = global.tick div 100 mod 60;
var _minutes = global.tick div 6000 mod 60;
//var _seconds = global.time % 60;
//var _minutes = floor(global.time / 60);

var _x = camera_get_view_x(view_camera[view_current]);
var _y = camera_get_view_y(view_camera[view_current]);

draw_sprite(sprScore,0,_x+17,_y+9);
var _score = 666;
draw_text(_x+65,_y+9,_score);
//for(var i=0;i<6;i++)
//	draw_sprite(sprNumbers,(_score div (power(10,5-i))) mod 10,_x+65+8*i,_y+9);

draw_sprite(sprTime,
	_minutes>9 ? global.tick / 25 : 0
	,_x+17,_y+25);
draw_sprite(sprNumbers,_minutes mod 10,_x+57,_y+25);
for(var i=0;i<2;i++)
	draw_sprite(sprNumbers,(_seconds div (power(10,1-i))) mod 10,_x+73+8*i,_y+25);
for(var i=0;i<2;i++)
	draw_sprite(sprNumbers,(_mili_seconds div (power(10,1-i))) mod 10,_x+97+8*i,_y+25);
for(var i=0;i<2;i++)
	draw_sprite(sprApostrophe,i,_x+64+24*i,_y+25);

draw_sprite(
	sprRings,
	global.rings<3 ? global.tick / 25 : 0
	,_x+17,_y+41);
var _rings = global.rings;

draw_text(_x+65,_y+41,_rings);
draw_set_font(-1);
//for(var i=0;i<3;i++)
//	draw_sprite(sprNumbers,(_rings div (power(10,2-i))) mod 10,_x+65+8*i,_y+41);




