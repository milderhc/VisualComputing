#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

vec4 Ia;
vec4 Ip;
vec4 Ie;

varying vec4 S;
varying vec3 La;
varying vec3 L;
varying vec3 N;
varying vec3 V;

void main() {
	
  	//ESPECULAR
  	float K_a = 0.5;
  	float K_d = 0.5;
  	float K_s = 0.5;

  	float intensityAmb = max(0.0, dot(La, N));
  	Ia = vec4(intensityAmb, intensityAmb, intensityAmb, 1);

	float intensity = max(0.0, dot(L, N));
  	Ip = vec4(intensity, intensity, intensity, 1);

  	vec3 R = dot(2 * normalize(N), normalize(L)) * N - L;
  	float specularIntensity = max(0.0, dot(R,V));
	Ie = vec4(specularIntensity, specularIntensity, specularIntensity, 1);

  	gl_FragColor = (Ia * K_a * S) + (Ip * K_d * S *  dot(normalize(N),normalize(L))) + (Ie * K_s * dot(normalize(V),R)); 

}