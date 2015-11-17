PShape can;
float angle;

PShader lightShader;

void setup() {
  size(640, 360, P3D);
  can = createCan(100, 200, 32);
  lightShader = loadShader("lightFrag.glsl", "lightVert.glsl");
}

void draw() {    
  background(0);
  
  if(keyPressed && key == '1' ){
    lightShader = loadShader("AutoluminosoFrag.glsl", "lightVert.glsl");
  }
  if(keyPressed && key == '2' ){
    lightShader = loadShader("AmbientalFrag.glsl", "lightVert.glsl");
  }
  if(keyPressed && key == '3' ){
    lightShader = loadShader("DifusaFrag.glsl", "lightVert.glsl");
  }
  if(keyPressed && key == '4' ){
    lightShader = loadShader("EspecularFrag.glsl", "lightVert.glsl");
  }
  
  shader(lightShader);
  pointLight(255, 255, 255, width/2, height, 200);

  translate(width/2, height/2);
  rotateY(angle);  
  shape(can);  
  angle += 0.01;
}

PShape createCan(float r, float h, int detail) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}