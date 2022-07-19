/// @description Insert description here
// You can write your code in this editor

var _height = 256 / 32;

var _x = camera_get_view_x(view_camera[0]);
var _y = camera_get_view_y(view_camera[0]);
var _w = camera_get_view_width(view_camera[0])
var _h = camera_get_view_height(view_camera[0])

for (var i = 0; i < _height; i++) {
	draw_sprite_tiled_ext(sprBackZoneTest, 0, _x * min(0.10 + i / 10, 0.9),  _y + (i * 16),
						 (i + 1) / 6 + 1, 1, make_color_hsv(160, 100, 255-i*24), 1);
	draw_sprite_tiled_ext(sprBackZoneTest, 0, _x * min(0.10 + i / 10, 0.9),  _y - 16 - (i * 16),
						 (i + 1) / 6 + 1, 1, make_color_hsv(160, 100, 255-i*24), 1);
				
}   

exit;

var i, j, z;

var px = 0;
var py = 0;
	
var js = 0.17; // 0.27
var is = 0.12; // 0.22
	
for(j=0; 6.28>j; j+=js) {
    for(i=0; 6.28 >i; i+=is) {
		
		
        var		sini=sin(i),
                cosj=cos(j),
                sinA=sin(A),
                sinj=sin(j),
                cosA=cos(A),
                cosj2=cosj+2,
                mess=1/(sini*cosj2*sinA+sinj*cosA+5),
                cosi=cos(i),
                cosB=cos(B),
                sinB=sin(B),
                t=sini*cosj2*cosA-sinj* sinA;
				
        var xx=30*mess*(cosi*cosj2*cosB-t*sinB)*3,
            yy= 30*mess*(cosi*cosj2*sinB +t*cosB)*3,
           
            N=8*((sinj*sinA-sini*cosj*cosA)*cosB-sini*cosj*sinA-sinj*cosA-cosi *cosj*sinB);
 
 
		var col =  make_color_hsv(N * 20 + 20, 128, 32);
		draw_circle_color(
			_x + _w / 2 + xx,
			_y + _h / 2 + yy,
			1,
			col,
			col,
			false
		);
		
		/*draw_line_color(
			_x + _w / 2 + px, 
			_y + _h / 2 + py,
			_x + _w / 2 + xx, 
			_y + _h / 2 + yy, col, col);*/
		
		px = xx;
		py = yy;
    }
}

A+=0.01;
B+= 0.01;
