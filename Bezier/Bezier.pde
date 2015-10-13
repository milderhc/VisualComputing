
import remixlab.proscene.*;

Scene scene;
InteractiveFrame interactiveFrame;

boolean entra = false;
float t=0;

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
      line(i, i, 0, i+t, i-t ,30-t);
    }else{
      line(i, i, 0, i, i ,30);
    }
    
    if(i == 100) break;
    
    if(inverse){
      stroke(255,255,0);  
      bezier(i, i, 0, i+t, i-t , 30-t, i+10, i+10, 0, i+10, i+10 ,30);
      inverse = false;  
    }else{
      stroke(255,255,0);  
      bezier(i+10, i+10, 0, i+10+t, i+10-t , 30-t, i, i, 0, i, i , 30);
      inverse = true;      
    }
    
    t = (t%100)+0.01;
    
  }
  
}