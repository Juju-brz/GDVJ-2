shader_type canvas_item;

uniform vec3 tint : source_color = vec3(1.0, 0.5, 0.7);

void fragment() {
		
	// CENTER UV //
	vec2 uv = UV * 2.0 - 1.0;
	uv.x *= 16.0 / 9.0;
	vec2 t = fract(UV * 4.0);
	//t += sin(TIME);
	vec4 tex = texture(TEXTURE, t);
	COLOR = vec4(tex.rgb * tint, tex.a);
}