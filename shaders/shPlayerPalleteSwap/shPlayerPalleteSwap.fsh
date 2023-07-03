//
// Simple pallete swap fragment shader
//
uniform vec3 old1;
uniform vec3 old2;
uniform vec3 old3;
uniform vec3 old4;

uniform vec3 new1;
uniform vec3 new2;
uniform vec3 new3;
uniform vec3 new4;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec3 col =  vec3(gl_FragColor);

	if		(col == old1) { col = new1; }
	else if (col == old2) { col = new2; }
	else if (col == old3) { col = new3; }
	else if (col == old4) { col = new4; }
	
	gl_FragColor = vec4(col, gl_FragColor.a);
}
