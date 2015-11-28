import remixlab.proscene.*;
import remixlab.dandelion.geom.*;

Scene scene;
InteractiveFrame iFrame;
Vec ecLight;

PShape can;
float angle;

PShader lightShader;

void setup() {
  size(640, 360, P3D);
  scene = new Scene(this); 
  iFrame = new InteractiveFrame(scene);
  iFrame.setGrabsInputThreshold(scene.radius()/3, true); //Radio de captura
  iFrame.translate(0, 0, 40);
  scene.setNonSeqTimers(); // comment it to use sequential timers instead (default)
  can = createCan(100, 200, 32);
  lightShader = loadShader("lightFrag.glsl", "lightVert.glsl");
}

void draw() {    
  background(0);
     
  if(keyPressed && key == '1' ){
    lightShader = loadShader("lightFrag.glsl", "AutoluminosoVert.glsl");
  }
  if(keyPressed && key == '2' ){
    lightShader = loadShader("lightFrag.glsl", "AmbientalVert.glsl");
  }
  if(keyPressed && key == '3' ){
    lightShader = loadShader("lightFrag.glsl", "DifusaVert.glsl");
  }
  if(keyPressed && key == '4' ){
    lightShader = loadShader("lightFrag.glsl", "EspecularVert.glsl");
  }
  
  pushMatrix();
  shader(lightShader);
  //pointLight(255, 255, 255, width/2, height, 200);
  pointLight(255, 255, 255, 0, 0, 0);

  translate(0, 0, -100);
  rotateY(angle);  
  shape(can);  
  angle += 0.01;
  
  popMatrix();
  
  
  // Save the current model view matrix
  pushMatrix();
 
  // Multiply matrix to get in the frame coordinate system.
  // applyMatrix(Scene.toPMatrix(iFrame.matrix())); //is possible but inefficient
  iFrame.applyTransformation();//very efficient
  // Draw an axis using the Scene static function
  //scene.drawAxes(20);
  noLights( );

  // Draw a second torus
  if (scene.motionAgent().defaultGrabber() == iFrame) {
    noStroke();
    fill(0, 255, 255);
    sphere(16);
  }
  else if (iFrame.grabsInput()) {
    noStroke();
    fill(0, 0, 255);
    sphere(16);
  }
  else {
    noStroke();
    fill(255, 255, 255);
    sphere(16);
  }
  
  ecLight = scene.eye().frame().transformOf(iFrame.position()); //Pasa a las coordenadas de la camara
  lightShader.set("myLightPosition", ecLight.x(),  ecLight.y(), ecLight.z());

  popMatrix();

}


PShape createCan(float r, float h, int detail) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.fill(80,208,218);
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