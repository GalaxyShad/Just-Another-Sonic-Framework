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

    color.r = max(color.r - reductionFactor, 0.0);
    color.g = max(color.g - reductionFactor, 0.0);

    if (reductionFactor >= 0.25)
    {
        color.b = max(color.b - reductionFactor + 0.25, 0.0);
    }

    gl_FragColor = vec4(color, texColor.a);
}
