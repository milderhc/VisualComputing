
int x_camera = 2000;
int vel = 10; //even number
PShape s;

void setup(){
  size(700,450,P3D);
  smooth(2); //do smooth lines
  s = createShape();
  s.rotateX(PI/4);
  s.translate(width/2, height/2, -150);
  for(int i = 0; i <= 400; i = i + 20){
      drawCylinder( 360, 400 - i, 20, i);
  }

}
void draw(){
  
  background(0); //black background
  lights(); //place shadows
  shape(s,0,0);

  //println(frameRate); //No se

  beginCamera();
  camera(x_camera,x_camera,(height/2)/tan(PI/6),width/2,height/2, 0, 0, 1, 0);
  if(x_camera == -2000) x_camera = 2000; 
  x_camera = x_camera - vel;
  endCamera();
  
}


void drawCylinder( int sides, float r, float h, float m)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    
    s.colorMode(HSB, 360);
    
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

    // draw top of the tube
    s.beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        s.stroke(0);
        s.fill(i,360,360);
        s.vertex( x, y, -halfHeight-m);
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
    
        // draw bottom of the tube
    s.beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        s.stroke(0);
        s.fill(i,360,360);
        s.vertex( x, y, halfHeight-m);
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
    
        // draw sides
    s.beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        s.noStroke();
        s.fill(i,360,360);
        s.vertex( x, y, halfHeight-m);
        s.vertex( x, y, -halfHeight-m);    
    }
    s.endShape(CLOSE);

}