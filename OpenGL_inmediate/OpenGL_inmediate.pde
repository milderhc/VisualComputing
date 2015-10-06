import processing.opengl.*;

int x_camera = 2000;
int vel = 10; //even number

void setup(){
  size(700,450,OPENGL);
  smooth(2); //do smooth lines
}
void draw(){
  colorMode(HSB, 360);
  background(0); //black background
  lights(); //place shadows

  //println(frameRate); //No se

  beginCamera();
  
  camera(x_camera,height/2,(height/2)/tan(PI/6),width/2,height/2, 0, 0, 1, 0);
  if(x_camera == -2000) x_camera = 2000; 
  x_camera = x_camera - vel;
  rotateX(PI/4);
  translate(width/2, height/2, -150);
  
  for(int i = 0; i <= 300; i = i + 5){
      drawCylinder( 360, 300 - i, 5, i);
  }

  endCamera();
  
}


void drawCylinder( int sides, float r, float h, float m)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    
    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        stroke(0);
        fill(i,360,360);
        vertex( x, y, -halfHeight+m);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        stroke(0);
        fill(i,360,360);
        vertex( x, y, halfHeight+m);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        noStroke();
        fill(i,360,360);
        vertex( x, y, halfHeight+m);
        vertex( x, y, -halfHeight+m);    
    }
    endShape(CLOSE);

}