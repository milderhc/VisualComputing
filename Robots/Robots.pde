import java.awt.Color;

PFont font;
PGraphics canvas1, canvas2;
String renderer = P2D;

int w = 640;
int h = 720;
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
      pg.translate(p.translateX, p.translateY);
      pg.rotate(p.rotate);
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
  canvas1 = createGraphics(width, height/2, renderer);
  canvas2 = createGraphics(width, height/2, renderer);
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

public void draw() {
  background(255);
  canvas1.beginDraw();
  canvas1.background(255);
  robot.draw(canvas1);
  canvas1.endDraw();
  image(canvas1, 0, 0);

  canvas2.beginDraw();
  canvas2.background(255);
  robot.draw(canvas2);
  canvas2.endDraw();
  image(canvas2, 0, 360);
}

void keyPressed() {
  if ( key == '1' ) arm1.rotate += 0.1;
  if ( key == '2' ) arm1.rotate -= 0.1;
  if ( key == '3' ) arm2.rotate += 0.1;
  if ( key == '4' ) arm2.rotate -= 0.1;
}