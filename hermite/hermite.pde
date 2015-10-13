
import remixlab.proscene.*;
//based on http://quegrande.org/apuntes/EI/OPT/GC/teoria/00-01/apuntes_completos.pdf
Scene scene;

class Point{
  float x,y;
  
  public Point(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public Point add( Point p ){
    return new Point(x+p.x,y+p.y);
  }
  
  public Point sub( Point p ){
    return new Point(x-p.x,y-p.y);
  }
  
  public Point add( float xd ){
    return new Point(x+xd,y+xd);
  }
  
  public Point mult( float xd ){
    return new Point(x*xd,y*xd);
  }
}

boolean entra = false;
float t=0;

Point p1,p4, r1, r4;

void setup(){
  size(640, 720, P3D);
  //scene = new Scene(this);
  //scene.setVisualHints( Scene.PICKING );
//  scene.showAll();
  float stx = 0, sty = 0;
  
  p1 = new Point(0,0);
  p4 = new Point(100,100);
  
  r1 = new Point(50,50).sub(p1); // vectores
  r4 = new Point(-350,150).sub(p4); // vectores
  
  
  Point offset = new Point(stx,sty);
  p1 = p1.add(offset);
  p4 = p4.add(offset);
  r1 = r1.add(offset);
  r4 = r4.add(offset);  
  
}

Point formula( float t ){
  float t3 = t*t*t;
  float t2 = t*t;
  Point a = p1.mult(2.0).sub(p4.mult(2.0)).add(r1).add(r4);
  Point b = p1.mult(-3.0).add(p4.mult(3.0)).sub(r1.mult(-2.0)).sub(r4);
  Point c = r1;
  Point d = p1;
  
  return a.mult(t3).add(b.mult(t2)).add(c.mult(t)).add(d);
}
void draw(){
//  background(0);

  for(float t = 0.0; t<=1; t+=0.001){
     Point aux = formula(t);
     point( aux.x, aux.y , aux.y );
   //  println(aux.x+"\t"+aux.y);
  }
  
}