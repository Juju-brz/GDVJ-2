// 2D Geometries //

// The MIT License
// Copyright © 2018 Inigo Quilez

float sdCircle( vec2 p, float r, float sharp) {
	return (length(p) - r) * sharp;
}

float sdPentagram(vec2 p, float r) {
	const float k1x = 0.80;
	const float k2x = 0.30; 
	const float k1y = 0.58; 
	const float k2y = 0.95;
	const float k1z = 0.72;
	const vec2  v1  = vec2( k1x,-k1y);
	const vec2  v2  = vec2(-k1x,-k1y);
	const vec2  v3  = vec2( k2x,-k2y);

	p.x = abs(p.x);
	p -= 2.0*max(dot(v1,p),0.0)*v1;
	p -= 2.0*max(dot(v2,p),0.0)*v2;
	p.x = abs(p.x);
	p.y -= r;
	return length(p-v3*clamp(dot(p,v3),0.0,k1z*r))
		* sign(p.y*v3.x-p.x*v3.y);
}

float sdBox(vec2 p, vec2 b) {
    vec2 d = abs(p)-b;
    return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
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

//TRANSFORM //
mat2 rot(float a) {
	float c = cos(a), s = sin(a);
	return mat2(vec2(c, -s), vec2(s, c));
}

// COLOR //
vec3 palette (float t, vec3 a, vec3  b, vec3 c, vec3 d)  {
	return a + b * cos(6.28318 * (c*t*d));
}

vec2 colorizeUV(vec2 uv, float speed) {
	vec2 colorizeUV = vec2(sin(uv.x + TIME * speed), cos(uv.y + TIME * speed) );
	return colorizeUV;
}