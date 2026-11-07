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

float sdSegment(vec2 p,vec2 a,vec2 b) {
	vec2 pa = p-a, ba = b-a;
	float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
	return length( pa - ba*h );
}
float dot2( in vec2 v ) { return dot(v,v); }

float sdHeart( in vec2 p ) {
	p.x = abs(p.x);

	if( p.y+p.x>1.0 )
			return sqrt(dot2(p-vec2(0.25,0.75))) - sqrt(2.0)/4.0;
		return sqrt(min(dot2(p-vec2(0.00,1.00)),
						dot2(p-0.5*max(p.x+p.y,0.0)))) * sign(p.x-p.y);
}
float sdVesica(vec2 p, float r, float d) {
    p = abs(p);

    float b = sqrt(r*r-d*d);  // can delay this sqrt by rewriting the comparison
    return ((p.y-b)*d > p.x*b) ? length(p-vec2(0.0,b))*sign(d)
                               : length(p-vec2(-d,0.0))-r;
}

// EFFECTS
float vortex(vec2 uv, float radius, float duplication) {
    duplication = clamp(duplication, 4.0, 20.0); // clamp inside the body
    float f = fract(sdCircle(uv, radius, duplication));
    return f;
}
// REPEAT
vec2 repeat(vec2 uv, float spacing) {
	vec2 p = mod(uv, spacing) - 0.5 * spacing;
	return p;
}

// BOOLEAN //
float UNION (float a, float b) {
	return min(a, b);
}

float INTERSECTION(float a, float b) {
	return max(a, b);
}

float DIFFERENCE(float a, float b) {
	return max(a, -b);
}

float EXCLUSION(float a, float b) {
	return max(UNION(a, b), -INTERSECTION(a, b));
}


//TRANSFORM //
mat2 rot(float a) {
	float c = cos(a), s = sin(a);
	return mat2(vec2(c, -s), vec2(s, c));
}
mat3 translate2d(vec2 t) {
	return mat3(vec3(1.0, 0.0, 0.0),
				vec3(0.0, 1.0, 0.0),
				vec3(t.x, t.y, 1.0));
}

// GOTHIC Geometries //
float Quatrefoil(vec2 uv, float radius, float sharp) {
	float d1 = sdCircle(uv + vec2(0.0,0.2), radius, sharp);
	float d2 = sdCircle(uv + vec2(0.2,0.0), radius, sharp);
	float d3 = sdCircle(uv - vec2(0.2, 0.0), radius, sharp);
	float d4 = sdCircle(uv - vec2(0.0, 0.2), radius, sharp);
	float e1 = EXCLUSION(d2, d3);
	float e2 = EXCLUSION(d1, d4);
	float e3 = INTERSECTION(e1, e2);
	return e3;
}

float rosace(vec2 uv, float shape) {
	float d1 = abs(sdCircle(uv, 0.6, 80.0));
	
	float halfpi = 1.57;
	//vec2 p = rot(halfpi) * uv;
	float d2 = abs(sdCircle(uv, 0.07, 80.0));
	float d3 = 1e9;
	for (int i = 0; i <10; i++) {
		float halfpi = 1.57;
		float a = float(i) * TAU / 10.0;
		vec2 p = rot(a) * uv;
		d3 = min(d3, abs(sdVesica(p + vec2(0.0, 0.3), 0.5, shape)) * 80.0);
		//halfpi = halfpi * 2.0;
	}
	float e1 = UNION(d1, d2);
	float e2 = UNION(e1, d3);
	return e2;
}

// COLOR //
vec3 palette (float t, vec3 a, vec3  b, vec3 c, vec3 d)  {
	return a + b * cos(6.28318 * (c*t*d));
}

vec2 colorizeUV(vec2 uv, float speed) {
	vec2 colorizeUV = vec2(sin(uv.x + TIME * speed), cos(uv.y + TIME * speed) );
	return colorizeUV;
}
