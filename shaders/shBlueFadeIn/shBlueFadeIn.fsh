//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float reductionFactor;

void main()
{
	vec4 texColor = texture2D( gm_BaseTexture, v_vTexcoord );
    vec3 color = texColor.rgb;

    color.b = min(reductionFactor, color.b);

    if (reductionFactor >= 1) {
        color.r = min(reductionFactor - 1, color.r);
        color.g = min(reductionFactor - 1, color.g);
    } else {
        color.r = 0;
        color.g = 0;
    }

    gl_FragColor = vec4(color, texColor.a);
}
