/// @description Insert description here
// You can write your code in this editor

if ((state.current()=="normal" || state.current()=="look_up" || state.current()=="look_down" || state.current()=="hang") && xsp==0 && ysp==0 || state.current()=="breathe") draw_sprite_ext(sprTailsTailType1,global.tick/10,x,y,image_xscale,1,0,c_white,255);
if (state.current()=="push" || state.current()=="skid") draw_sprite_ext(sprTailsTailType2,global.tick/10,x-6*image_xscale,y+10,image_xscale,1,0,c_white,255);
if (state.current()=="spindash") draw_sprite_ext(sprTailsTailType2,global.tick/10,x-12*image_xscale,y+10,image_xscale,1,0,c_white,255);
if (state.current()=="roll" || state.current()=="jump") draw_sprite_ext(sprTailsTailType3,global.tick/10,x,y,1,xsp!=0 ? sign(xsp) : 1,point_direction(0,0,xsp,ysp),c_white,255);
//if (state.current()=="spring") draw_sprite_ext(sprTailsTailType2,global.tick/10,x,y,1,xsp!=0 ? sign(xsp) : 1,point_direction(0,0,xsp,ysp),c_white,255);

event_inherited();