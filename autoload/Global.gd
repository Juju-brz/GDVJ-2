extends Node


var ShaderFrag : String = """shader_type canvas_item;

uniform float BPM = 120; // Default Value

void fragment() {
	vec3 color1 = vec3(1.0, 0.5, 0.0); //orange
	vec3 color2 = vec3(0.3, 0.4, 0.7); //blue
	vec3 color3 = vec3(0.3, 1.0, 0.3); // green
	
	// SOUND CAPTATION //
	//float minute = 60.0;
	float BPS = BPM / 60.0; //Beat per second
	//float rythm = TIME * (float(beat));
	//float phase = fract(beat);
	float onde = sin(TIME * BPS * TAU);
	
	// CENTER UV //
	vec2 uv = UV * 2.0 - 1.0;
	uv.x *= 16.0 / 9.0;
	
	vec3 color = mix(color3, color2, uv.x + onde);
	
	// OUTPUT //
	COLOR = vec4(color, 1.0);
}"""

signal code_pushed(code)
signal color_changed(bg_color: Color)

var mouse_activation : bool = true
var BPM : String = "120.0"
