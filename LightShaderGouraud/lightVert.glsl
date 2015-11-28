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

varying vec4 vertColor;

vec4 Ia;
vec4 Ip;
vec4 Ie;

vec4 S;
vec3 La;
vec3 L;
vec3 N;
vec3 V;

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

  /*
  //AUTOLUMINOSO
  vertColor = S;
  */

  /*
  //AMBIENTAL
  float K_a = 0.5;

  float intensityAmb = max(0.0, dot(La, N));
  Ia = vec4(intensityAmb, intensityAmb, intensityAmb, 1);

  vertColor = Ia * K_a * S;
  */

  /*
  //DIFUSA
  float K_a = 0.5;
  float K_d = 0.5;

  float intensityAmb = max(0.0, dot(La, N));
  Ia = vec4(intensityAmb, intensityAmb, intensityAmb, 1);

  float intensity = max(0.0, dot(L, N));
  Ip = vec4(intensity, intensity, intensity, 1);

  vertColor = (Ia * K_a * S) + (Ip * K_d * S *  dot(normalize(N),normalize(L)));
  */

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

  vertColor = (Ia * K_a * S) + (Ip * K_d * S *  dot(normalize(N),normalize(L))) + (Ie * K_s * dot(normalize(V),R)); 

}