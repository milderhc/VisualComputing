//global values

float _barWidth=300.0;    //slider-bar width;
float _hueVal=_barWidth/2;  //initial hueValue global value

int n;
float h,s,b;
float x1,x2;
color myColor;
void doPaint(){
  
  noStroke();
  colorMode(HSB, n);
  b = _hueVal;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      h = i;
      s = j;
      
      stroke(h,s,b);
      point(i+10, j+10);
    }
  } 
}


void setup(){
  n = 150;
  background(255);
  size(800,800);
  stroke(0,0,0);
}

void mouseClicked(){
  myColor = get(mouseX,mouseY);
  
  println(myColor);
}
void draw(){
  
  _hueVal= drawSlider(20.0,200.0,_barWidth,30.0,_hueVal);
 doPaint();
}

float drawSlider(float xPos, float yPos, float sWidth, float sHeight,float hueVal){
  fill(255);
  noStroke();
  background(0,0,100);
  rect(xPos-5,yPos-10,sWidth+10,sHeight+20);  //draw white background behind slider
  
  float sliderPos=map(hueVal,0.0,255.0,0.0,sWidth); //find the current sliderPosition from hueVal
  
  for(int i=0;i<sWidth;i++){  //draw 1 line for each hueValue from 0-255
      float hueValue=map(i,0.0,sWidth,0.0,255.0);  //get hueVal for each i position //local variable
      float xd = hue(myColor);
      
      stroke(xd,255,hueValue);
      line(xPos+i,yPos,xPos+i,yPos+sHeight);
  }
  if(mousePressed && mouseX>xPos && mouseX<(xPos+sWidth) && mouseY>yPos && mouseY <yPos+sHeight){
     sliderPos=mouseX-xPos;
     hueVal=map(sliderPos,0.0,sWidth,0.0,255.0);  // get new hueVal based on moved slider
  }
  stroke(100);
  fill(hueVal,255,255);  //either new or old hueVal
  b = hueVal;
  rect(sliderPos+xPos-3,yPos-5,6,sHeight+10);  //this is our slider indicator that moves
  rect(sWidth+40, yPos, sHeight,sHeight); // this rectangle displays the changing color to the right side
  return hueVal;
}