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

varying vec4 S;
varying vec3 La;
varying vec3 L;
varying vec3 N;
varying vec3 V;

void main() {
  gl_Position = transform * vertex;    

  vec3 ecVertex = vec3(modelview * vertex);  
  vec3 ecNormal = normalize(normalMatrix * normal);
  N = ecNormal;
  
  vec3 observadorPos = normalize(0 - ecVertex);
  V = observadorPos;

  vec3 direction = normalize(myLightPosition.xyz - ecVertex);
  L = direction;

  vec3 directionAmb = normalize(lightAmbient.xyz - ecVertex); 
  La = directionAmb;

  S = color;    
}