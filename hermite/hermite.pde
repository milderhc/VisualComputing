import remixlab.proscene.*;
import java.util.Random;


//based on http://quegrande.org/apuntes/EI/OPT/GC/teoria/00-01/apuntes_completos.pdf
Scene scene;


class Point{
  float x,y,z;
  
  public Point(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Point add( Point p ){
    return new Point(x+p.x,y+p.y,z+p.z);
  }
  
  public Point sub( Point p ){
    return new Point(x-p.x,y-p.y,z-p.z);
  }
  
  public Point add( float xd ){
    return new Point(x+xd,y+xd,z+xd);
  }
  
  public Point mult( float xd ){
    return new Point(x*xd,y*xd,z*xd);
  }
}

boolean entra = false;

void setup(){
  size(640, 720, P3D);
  scene = new Scene(this);
  //scene.setVisualHints( Scene.PICKING );
  scene.showAll();
  
}

Point formula( Point p1,Point p4, Point r1, Point r4, float t ){
  float t3 = t*t*t;
  float t2 = t*t;
  Point a = p1.mult(2.0).sub(p4.mult(2.0)).add(r1).add(r4);
  Point b = p1.mult(-3.0).add(p4.mult(3.0)).sub(r1.mult(-2.0)).sub(r4);
  Point c = r1;
  Point d = p1;
  
  return a.mult(t3).add(b.mult(t2)).add(c.mult(t)).add(d);
}

void drawHermiteLine(Point p1,Point p4, Point r1, Point r4){
    for(float t = 0.0; t<=1; t+=0.001){
     Point aux = formula(p1,p4,r1,r4,t);
     point( aux.x, aux.y , aux.z );
  }
}

void draw(){
  
  background(255);
  
  
  float xd =2;
  if( keyPressed && key == '2' )
    xd += 0.5;
  
  if( keyPressed && key == '3' )
    xd -= 0.5;
  
  
  Random rand = new Random();
  for(float i=0; i<=50; i+=xd){
    Point p1 = new Point(i,0,i);
    Point p4 = new Point(100,100,i);
    Point r1 = new Point(5,5,5).sub(p1); // vectores
    Point r4 = new Point(350,150,100).sub(p4); // vectores
    drawHermiteLine(p1,p4,r1,r4);
  }
  
  
}