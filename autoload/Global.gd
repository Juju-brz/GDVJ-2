extends Node


var ShaderFrag : String = """shader_type canvas_item;



uniform float BPM = 120; // Default Value

void fragment() {
	
	float sharp = 40.0;
	
	// COLORS //
	vec3 color1 = vec3(1.0, 0.5, 0.0); //orange
	vec3 color2 = vec3(0.3, 0.4, 0.7); //blue
	vec3 color3 = vec3(0.3, 1.0, 0.3); // green
	
	// SOUND CAPTATION //
	float BPS = BPM / 60.0; //Beat per second
	float onde = sin(TIME * BPS * TAU * 0.50);
	 float BEAT_PHASE = fract(TIME * BPS);
	 float PULSE = sin(BEAT_PHASE * TAU); 
	
	// CENTER UV //
	vec2 uv = UV * 2.0 - 1.0;
	uv.x *= 16.0 / 9.0;
	
	// IMAGE BACKGOUND //
	vec2 t = fract(UV * 4.0);
	//t += sin(TIME);
	vec4 tex = texture(TEXTURE, t);
	
	vec3 color = mix(color3, color2, uv.x + onde);
	
	// OUTPUT //
	COLOR = vec4(color, 1.0);
	//COLOR = vec4(tex.rgb, tex.a);
}"""


var mouse_activation : bool = true
var BPM : String = "120.0"
var loop = 1
