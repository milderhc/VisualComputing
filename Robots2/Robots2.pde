import java.awt.Color;

PFont font;
PGraphics canvas1, canvas2;
String renderer = P3D;

int w = 640;
int h = 720;
float scaleFactor = 1;
float rotateFactor = 0.0;
boolean withMatrixStack = false;

class Polygon {
  ArrayList<Float> x, y;
  float translateX, translateY;
  float rotate;
  Color c;
  Polygon ( Color c, float tx, float ty, float r ) {
    x = new ArrayList<Float>();
    y = new ArrayList<Float>();
    this.c = c;
    translateX = tx;
    translateY = ty;
    rotate = r;
  }
  
  void addPoint(float x, float y) {
    this.x.add(x);
    this.y.add(y);
  }
  
  int size () {
    return x.size();
  }
}


class Robot {
  ArrayList<Polygon> parts;
  
  Robot ( ) {
    parts = new ArrayList<Polygon>();
  }
  
  void addPart ( Polygon p ) { parts.add(p); }
  void draw ( PGraphics pg ) {
    for ( Polygon p : parts ) {
      
      pg.pushMatrix();
      pg.stroke(255);
      translate(pg,p.translateX, p.translateY);
      rotate(pg,p.rotate);
      pg.fill(p.c.getRed(), p.c.getGreen(), p.c.getBlue());
      
      pg.beginShape();
      
      for ( int i = 0; i < p.size(); ++i ) {
        float x = p.x.get(i), y = p.y.get(i);
        pg.vertex(x, y);
      }
      pg.endShape(CLOSE);
      pg.popMatrix();
    }
  }
}

Robot robot;
Polygon head, body, arm1, arm2, leg1, leg2;

void setup() {
  size(640, 720, renderer);
  canvas1 = createGraphics(244, 280, renderer);
  canvas2 = createGraphics(244, 280, renderer);
  font = createFont("Arial", 12);
  textFont(font, 12);
  
  robot = new Robot();
  head = new Polygon(Color.BLACK, 100, 20, 0);
  head.addPoint(0, 0);
  head.addPoint(40, 0);
  head.addPoint(40, 40);
  head.addPoint(0, 40);
  robot.addPart(head);
  
  body = new Polygon(Color.BLACK, 80, 60, 0);
  body.addPoint(0, 0);
  body.addPoint(80, 0);
  body.addPoint(80, 120);
  body.addPoint(0, 120);
  robot.addPart(body);
  
  arm1 = new Polygon(Color.BLACK, 80, 70, PI);
  arm1.addPoint(0, 0);
  arm1.addPoint(80, 0);
  arm1.addPoint(80, 10);
  arm1.addPoint(0, 10);
  robot.addPart(arm1);
  
  arm2 = new Polygon(Color.BLACK, 160, 60, 0);
  arm2.addPoint(0, 0);
  arm2.addPoint(80, 0);
  arm2.addPoint(80, 10);
  arm2.addPoint(0, 10);
  robot.addPart(arm2);
  
  leg1 = new Polygon(Color.BLACK, 90, 180, 0);
  leg1.addPoint(0, 0);
  leg1.addPoint(20, 0);
  leg1.addPoint(20, 90);
  leg1.addPoint(0, 90);
  robot.addPart(leg1);
  
  leg2 = new Polygon(Color.BLACK, 130, 180, 0);
  leg2.addPoint(0, 0);
  leg2.addPoint(20, 0);
  leg2.addPoint(20, 90);
  leg2.addPoint(0, 90);
  robot.addPart(leg2);
}


public void scale(PGraphics pg, float f){
  pg.applyMatrix( f, 0.0, 0.0,  0.0,
                       0.0, f, 0.0,  0.0,
                       0.0, 0.0,  f,  0.0,
                       0.0, 0.0, 0.0,  1.0); 
}

public void rotate(PGraphics pg, float f){
  float ct = cos(f);
  float st = sin(f);    
  pg.applyMatrix( ct, -st, 0.0,  0.0,
                       st, ct, 0.0,  0.0,
                       0.0, 0.0,  1.0,  0.0,
                       0.0, 0.0, 0.0,  1.0);
}

public void translate(PGraphics pg, float x, float y){
   pg.applyMatrix( 1.0, 0.0, 0.0,  x,
                   0.0, 1.0, 0.0,  y,
                   0.0, 0.0, 1.0,  1.0,
                   0.0, 0.0, 0.0,  1.0); 
}



public void draw() {
  
  //########################     Canvas1     ############################################
  
  background(255);
  canvas1.beginDraw();
  
  canvas1.background(255);
  canvas1.pushMatrix();
  
  robot.draw(canvas1);
  
  canvas1.noFill(); //Draws the border
  canvas1.stroke(255,0,0); //Sets the color of the border
  translate(canvas1,canvas1.width/2,canvas1.height/2);
  scale(canvas1,1/scaleFactor); //Scales acording user preferences
  rotate(canvas1,rotateFactor*TWO_PI/360); //Rotates acording user preferences
  translate(canvas1,-canvas1.width/2,-canvas1.height/2);
  canvas1.rect(2, 2, canvas1.width-5, canvas1.height-5); //Draws the border, losing precision?
  canvas1.popMatrix();
  canvas1.endDraw();
  image(canvas1, 0, 0);
  
  //########################     Canvas2     ############################################
  
  canvas2.beginDraw();
  canvas2.background(255);
  canvas2.pushMatrix();
  
  translate(canvas2,canvas2.width/2, canvas2.height/2); 
  scale(canvas2,scaleFactor); //Scales acording user preferences
  rotate(canvas2,rotateFactor*TWO_PI/360); //Rotates acording user preferences
  translate(canvas2,-canvas2.width/2, -canvas2.height/2);
  
  robot.draw(canvas2);
  
  canvas2.popMatrix();
  canvas2.noFill(); //Draws the border
  canvas2.stroke(0,0,0); //Sets the color of the border
  canvas2.rect(0, 0, canvas2.width-1, canvas2.height-1); //Draws the border
  canvas2.endDraw();
  image(canvas2, 0, 360);
  translate(0,0);  
}

void keyPressed() {
  if ( key == '1' ) arm1.rotate += 0.1;
  if ( key == '2' ) arm1.rotate -= 0.1;
  if ( key == '3' ) arm2.rotate += 0.1;
  if ( key == '4' ) arm2.rotate -= 0.1;
  if ( key == '5' ){
    for(int i=0; i<robot.parts.size(); i++){
      robot.parts.get(i).translateX += 4;
    }
  }
  
  if(key == 'z'){
    scaleFactor += 0.01;
  }
  
  if(key == 'x'){
    scaleFactor -= 0.01;
  }
  
  if(key == 'c'){
    rotateFactor += 0.3;
  }
  
  if(key == 'v'){
    rotateFactor -= 0.3;
  }
  
  if ( key == '6' ){
    for(int i=0; i<robot.parts.size(); i++){
      robot.parts.get(i).translateX -= 4;
    }
  }
}