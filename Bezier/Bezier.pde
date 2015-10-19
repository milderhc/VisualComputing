
import remixlab.proscene.*;

Scene scene;

boolean entra = false;
float k=0;

class Point{
  
  float x,y,z;
  
  public Point(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Point add( Point p ){
    return new Point(x+p.x, y+p.y, z+p.z);
  }
  
  public Point mult( float m ){
    return new Point(x*m , y*m, z*m);
  }
  
}

void bezierCurve(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4){

  Point P0 = new Point(x1, y1, z1);
  Point P1 = new Point(x2, y2, z2);
  Point P2 = new Point(x3, y3, z3);
  Point P3 = new Point(x4, y4, z4);
  
  for(float t = 0.0; t<=1; t+=0.001){
      Point B = P0.mult(pow((1 - t),3)).add(P1.mult(3.0 * t * pow((1 - t),2))).add(P2.mult(3.0 * pow(t, 2) * (1 - t))).add(P3.mult(pow(t,3)));
      point(B.x, B.y, B.z);
  }
  
}

void setup(){
  size(640, 720, P3D);
  scene = new Scene(this);
  //scene.setVisualHints( Scene.PICKING );
  scene.showAll();
  
}

void draw(){

  background(0);
  noFill();
  boolean inverse = true; 
  for(int i = 10; i <= 100 ; i+=10){
    stroke(255, 102, 0);
    if(inverse){ 
      line(i, i, 0, i+k, i-k ,30-k);
    }else{
      line(i, i, 0, i, i ,30);
    }
    
    if(i == 100) break;
    
    if(inverse){
      stroke(255,255,0);  
      bezierCurve(i, i, 0, i+k, i-k , 30-k, i+10, i+10, 0, i+10, i+10 ,30);
      inverse = false;  
    }else{
      stroke(255,255,0);  
      bezierCurve(i+10, i+10, 0, i+10+k, i+10-k , 30-k, i, i, 0, i, i , 30);
      inverse = true;      
    }
    
    k = (k%100)+0.01;
    
  }
  
}