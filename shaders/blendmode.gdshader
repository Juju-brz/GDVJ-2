shader_type canvas_item;

uniform bool multiplyblend = false;
uniform vec4 blend_color : source_color = vec4(1.0);
void fragment() {
	
	vec4 tex = texture(TEXTURE, UV);
	if (multiplyblend == true)
		 COLOR = vec4(tex.rgb * blend_color.rgb, tex.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
