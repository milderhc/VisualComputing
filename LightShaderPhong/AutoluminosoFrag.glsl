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
	
	//AUTOLUMINOSO
	gl_FragColor = S;

}