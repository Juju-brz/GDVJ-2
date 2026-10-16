// 2D Geometries //

float sdCircle( vec2 p, float r, float sharp  ){
	return (length(p) - r) * sharp;
}

// RAYMARCHING //

float raymarching(vec2 uv) {
	vec3 ro = vec3(0.0, 0.0, 1.0); //ray origin
	vec3 rd = vec3(uv.x, uv.y, -1.0);    //ray direction
	float d = 0.0;                       //distance

	for (int i = 0; i <100; i++) {       //launch Ray
		vec3 p = ro + d * rd;            //position
		float dist = length(p) -0.3;     //creates sphere
		d += dist;                       //we assign new value to d
	}
	return d;
}

// BOOLEAN //
float UNION (float a, float b) {
    return min(a, b);
}

float INTERSECTION(float a, float b) {
	return max(a, b);
}

float SOUSTRACTION(float a, float b) {
	return max(a, -b);
}

// COLOR //
vec3 palette (float t) { //I must look how its work
    vec3 a = vec3(0.328, 0.218, 0.268);
    vec3 b = vec3(-1.052, 0.500, 0.500);
    vec3 c = vec3(0.598, 1.000, 1.000);
    vec3 d = vec3(0.000, 0.333, 0.667);
    return a + b * cos(6.28318 * (c*t*d));
}

vec3 colorizeUV(vec2 uv, float speed) {
	vec3 colorizeUV = vec3(sin(uv.x + TIME * speed), cos(uv.y + TIME * speed), 0.0);
	return colorizeUV;
}