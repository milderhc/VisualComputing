#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;
uniform vec3 myLightPosition;

uniform vec3 lightAmbient;
uniform vec3 lightDiffuse;
uniform vec3 lightSpecular;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 I;
varying vec4 S;
varying vec3 L;
varying vec3 N;
varying vec3 V;

void main() {
  gl_Position = transform * vertex;    
  vec3 ecVertex = vec3(modelview * vertex);  
  vec3 ecNormal = normalize(normalMatrix * normal);
  N = ecNormal;
  vec3 observadorPos = vec3(10, 10, 10);
  V = observadorPos;
  vec3 direction = normalize(myLightPosition.xyz - ecVertex);
  L = direction;    
  float intensity = max(0.0, dot(direction, ecNormal));
  I = vec4(intensity, intensity, intensity, 1);
  S = color;             
}