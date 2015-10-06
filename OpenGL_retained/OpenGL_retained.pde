import processing.opengl.*;

PShape s;
int x_camera = 2000;
int vel = 10; //even number

void setup(){
  size(700,450,OPENGL);
  smooth(2); //do smooth lines
  
  s = createShape();
  s.rotateX(PI/4);
  s.translate(width/2, height/2, -150);
  
  for(int i = 0; i <= 300; i = i + 5){
      drawCylinder( 360, 300 - i, 5, i);
  }
  
}
void draw(){
  
  background(0); //black background
  lights(); //place shadows

  //println(frameRate); //No se

  shape(s,0,0);

  beginCamera();
  
  camera(x_camera,height/2,(height/2)/tan(PI/6),width/2,height/2, 0, 0, 1, 0);
  if(x_camera == -2000) x_camera = 2000; 
  x_camera = x_camera - vel;

  endCamera();
  
}


void drawCylinder( int sides, float r, float h, float m)
{
    s.colorMode(HSB, 360);
  
    float angle = 360 / sides;
    float halfHeight = h / 2;
    
    // draw top of the tube
    s.beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        s.stroke(0);
        s.fill(i,360,360);
        s.vertex( x, y, -halfHeight+m);
    }
    s.endShape(CLOSE);

    // draw bottom of the tube
    s.beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        s.stroke(0);
        s.fill(i,360,360);
        s.vertex( x, y, halfHeight+m);
    }
    s.endShape(CLOSE);
    
    // draw sides
    s.beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        s.noStroke();
        s.fill(i,360,360);
        s.vertex( x, y, halfHeight+m);
        s.vertex( x, y, -halfHeight+m);    
    }
    s.endShape(CLOSE);

}