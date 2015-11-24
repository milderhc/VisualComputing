import java.awt.Color;
import java.util.List;
PFont font;
PGraphics canvas1, canvas2;
String renderer = P2D;

int w = 640;
int h = 720;
float scaleFactor = 1;
float rotateFactor = 0.0;
boolean withMatrixStack = false;

class Polygon {
  ArrayList<Float> x, y;
  ArrayList<Float[]> points;
  float translateX, translateY;
  float rotate;
  Color c;
  Polygon ( Color c, float tx, float ty, float r ) {
    x = new ArrayList<Float>();
    y = new ArrayList<Float>();
    points = new ArrayList<Float[]>();
    this.c = c;
    translateX = tx;
    translateY = ty;
    rotate = r;
  }
  
  Polygon ( ArrayList<Float[]> p, Color c, float tx, float ty, float r ){
    
    x = new ArrayList<Float>();
    y = new ArrayList<Float>();
    this.points = p;
    
    println(points.size());
    for(Float[] point : points){
      x.add( point[0] );
      y.add( point[1] );
    }
    this.c = c;
    this.translateX = tx;
    this.translateY = ty;
    this.rotate = r;
  }
  
  void addPoint(float x, float y) {
    this.x.add(x);
    this.y.add(y);
    points.add(new Float[]{x,y});
  }
  
  int size () {
    return x.size();
  }
  

}

public Polygon sutherlandHodgmanAlgorithm(Polygon subjectPolygon, Polygon clipperPolygon){
      
      
      ArrayList<Float[]> subject = new ArrayList<Float[]>();
      
      for(Float[] f : subjectPolygon.points){
        subject.add(new Float[]{ new Float(f[0] + subjectPolygon.translateX), new Float(f[1] + subjectPolygon.translateY) });
      }
      
      ArrayList<Float[]> result  = new ArrayList<Float[]>();
      
      for(Float[] f : subject){
        result.add(new Float[]{ new Float(f[0]), new Float(f[1]) });
      }
      
      ArrayList<Float[]> clipper = new ArrayList<Float[]>();
      
      for(Float[] f : clipperPolygon.points){
        clipper.add(new Float[]{ new Float(f[0]), new Float(f[1]) });
      }
      
      for(Float[] f : subject){
        println(f[0] + " " + f[1]);
      }
      println("######");
      for(Float[] f : clipper){
        println(f[0] + " " + f[1]);
      }
      
      int len = clipper.size();
        for (int i = 0; i < len; i++) {
       
            int len2 = result.size();
            List<Float[]> input = new ArrayList<Float[]>(result);
            result = new ArrayList<Float[]>(len2);
       
            Float[] A = clipper.get((i + len - 1) % len);
            Float[] B = clipper.get(i);
       
            for (int j = 0; j < len2; j++) {
       
                Float[] P = input.get((j + len2 - 1) % len2);
                Float[] Q = input.get(j);
       
                if (isInside(A, B, Q)) {
                    if (!isInside(A, B, P))
                        result.add(intersection(A, B, P, Q));
                    result.add(Q);
                } else if (isInside(A, B, P))
                    result.add(intersection(A, B, P, Q));
            }
            println(" -> " + result.size());
        }
      
      
      return new Polygon(result, subjectPolygon.c, subjectPolygon.translateX, subjectPolygon.translateY, subjectPolygon.rotate );
    }
    
    private boolean isInside(Float[] a, Float[] b, Float[] c) {
            return (a[0] - c[0]) * (b[1] - c[1]) > (a[1] - c[1]) * (b[0] - c[0]);
        }
     
    private Float[] intersection(Float[] a, Float[] b, Float[] p, Float[] q) {
        Float A1 = b[1] - a[1];
        Float B1 = a[0] - b[0];
        Float C1 = A1 * a[0] + B1 * a[1];
     
        Float A2 = q[1] - p[1];
        Float B2 = p[0] - q[0];
        Float C2 = A2 * p[0] + B2 * p[1];
     
        Float det = A1 * B2 - A2 * B1;
        Float x = (B2 * C1 - B1 * C2) / det;
        Float y = (A1 * C2 - A2 * C1) / det;
     
        return new Float[]{x, y};
    }





class Robot {
  ArrayList<Polygon> parts;
  
  Robot ( ) {
    parts = new ArrayList<Polygon>();
  }
  
  void addPart ( Polygon p ) { parts.add(p); }
  void draw ( PGraphics pg ) {
    for ( Polygon p : parts ) {
      Polygon aux = sutherlandHodgmanAlgorithm(p,visibleArea);
      //Polygon aux = p;
      pg.pushMatrix();
      pg.stroke(255);
      pg.translate(aux.translateX, aux.translateY);
      pg.rotate(aux.rotate);
      pg.fill(aux.c.getRed(), aux.c.getGreen(), aux.c.getBlue());
      
      pg.beginShape();
      
      for ( int i = 0; i < aux.size(); ++i ) {
        float x = aux.x.get(i), y = aux.y.get(i);
        pg.vertex(x, y);
      }
      pg.endShape(CLOSE);
      pg.popMatrix();
    }
  }
}


Robot robot;
Polygon head, body, arm1, arm2, leg1, leg2;
Polygon visibleArea;

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
  
  visibleArea = new Polygon(Color.BLACK,0,0,0);
  visibleArea.addPoint(0,0);
  visibleArea.addPoint(100,0);
  visibleArea.addPoint(100,100);
  visibleArea.addPoint(0,100);
  
}

void mouseReleased() {
  println(mouseX + " " + mouseY);
}


public void draw() {
  background(255);
  canvas1.beginDraw();
  //canvas1.scale(0.7);
  canvas1.background(255);
  canvas1.pushMatrix();
  robot.draw(canvas1);
  canvas1.noFill(); //Draws the border
  canvas1.stroke(255,0,0); //Sets the color of the border
  canvas1.translate(canvas1.width/2,canvas1.height/2);
  canvas1.scale(1/scaleFactor);
  canvas1.rotate(rotateFactor*TWO_PI/360);
  canvas1.translate(-canvas1.width/2,-canvas1.height/2);
  canvas1.rect(0, 0, canvas1.width-1, canvas1.height-1); //Draws the border
  canvas1.popMatrix();
  
  
  
  canvas1.endDraw();
  image(canvas1, 0, 0);
  
  
  
  canvas2.beginDraw();
  canvas2.background(255);
  canvas2.pushMatrix();
  
  canvas2.translate(canvas2.width/2, canvas2.height/2);
  canvas2.scale(scaleFactor);
  
  canvas2.rotate(rotateFactor*TWO_PI/360);
  
  canvas2.translate(-canvas2.width/2, -canvas2.height/2);
 
  robot.draw(canvas2);
  canvas2.popMatrix();
  canvas2.noFill(); //Draws the border
  canvas2.stroke(0,0,0); //Sets the color of the border
  canvas2.rect(0, 0, canvas2.width-1, canvas2.height-1); //Draws the border
  canvas2.rect(visibleArea.x.get(0), visibleArea.y.get(0), 
  visibleArea.x.get(1) - visibleArea.x.get(0), 
  visibleArea.y.get(3) - visibleArea.y.get(0)); //Draws the border
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