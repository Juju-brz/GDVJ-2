extends Node


var ShaderFrag : String = """shader_type canvas_item;

void fragment() {
	vec3 color1 = vec3(1.0, 0.5, 0.0); //orange
	vec3 color2 = vec3(0.3, 0.4, 0.7); //blue
	vec3 color3 = vec3(0.3, 1.0, 0.3); // green
	
	// CENTER //
	vec2 uv = UV * 2.0 - 1.0;
	uv.x *= 16.0 / 9.0;
	
	vec3 color = mix(color3, color2, uv.x + sin(TIME * 0.5));
	
	//OUTPUT
	COLOR = vec4(color, 1.0);
}"""

signal code_pushed(code)
signal color_changed(bg_color: Color)

var mouse_activation : bool = true
