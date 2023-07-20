/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

var _mili_seconds = 0;
var _seconds = global.time % 60;
var _minutes = floor(global.time / 60);

var _x = camera_get_view_x(view_camera[view_current]);
var _y = camera_get_view_y(view_camera[view_current]);

draw_sprite(sprScore,0,_x+17,_y+9);
var _score = 666;
for(var i=0;i<6;i++)
	draw_sprite(sprNumbers,(_score div (power(10,5-i))) mod 10,_x+65+8*i,_y+9);

draw_sprite(sprTime,0,_x+17,_y+25);
for(var i=0;i<2;i++)
	draw_sprite(sprNumbers,(_minutes div (power(10,1-i))) mod 10,_x+57+8*i,_y+25);
for(var i=0;i<2;i++)
	draw_sprite(sprNumbers,(_seconds div (power(10,1-i))) mod 10,_x+81+8*i,_y+25);
for(var i=0;i<2;i++)
	draw_sprite(sprNumbers,(_mili_seconds div (power(10,1-i))) mod 10,_x+105+8*i,_y+25);
for(var i=0;i<2;i++)
	draw_sprite(sprApostrophe,i,_x+72+24*i,_y+25);





draw_sprite(sprRings,0,_x+17,_y+41);
var _rings = global.rings;
for(var i=0;i<3;i++)
	draw_sprite(sprNumbers,(_rings div (power(10,2-i))) mod 10,_x+65+8*i,_y+41);








/*
var _score = [6,6,6];
for(var i=0;i<array_length(_score) ;i++)
	draw_sprite(sprNumbers,_score[i],_x+65+8*i,_y+9);
*/
