#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 I;
varying vec4 S;
varying vec3 L;
varying vec3 N;
varying vec3 V;

void main() {
	
  	//AMBIENTAL
  	float K_a = 0.5;
  	gl_FragColor = I * K_a * S;

}