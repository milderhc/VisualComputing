//global values

PFont f = createFont("Century Gothic",16,true); // Arial, 16 point, anti-aliasing on

float _barWidth=300.0;    //slider-bar width;
float _value =_barWidth/2;  //initial hueValue global value

int n;
float h,s,b;
float x1,x2;
color myColor;

void doPaintHSV(){
 
  noStroke();
  colorMode(HSB, n);
  b = n;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      h = i;
      s = j;
      stroke(h,s,b);
      point(i+20, j+75);
    }
  }
  
  stroke(100);
  noFill();
  rect(20, 75, n, n); 
  
}


void setup(){
  n = 300;
  size(800,600);
  background(255,255,255);
  
  fill(0);
  textFont(f,36);
  text("HSV",130,50);
  textFont(f,24);
  
  myColor = 255/2;
  doPaintHSV();
  
}

void draw(){
 
  _value = drawSlider(20,390,_barWidth,30,_value);
  
  stroke(100);
  fill(hue(myColor),255, _value);
  rect(20, 435, 100 , 110); // this rectangle displays the changing color to the down side 

  noStroke();
  fill(0,0,300);
  rect(140, 435, 180 , 110);
  
  float H = map(hue(myColor),0,300,0,360); 
  fill(0);
  text("H: "+nf(H, 3, 2)+" º",140,460);
  
  float S = map(hue(myColor),0,255,0,100); 
  fill(0);
  text("S: "+"-"+" %",140,500);
  
  float V = map(_value,0,255,0,100); 
  fill(0);
  text("V: "+nf(V, 3, 2)+" %",140,540);
}

void mouseClicked(){
  myColor = get(mouseX,mouseY);  
}

float drawSlider(float xPos, float yPos, float sWidth, float sHeight,float value){
  
  noStroke();
  fill(0,0,300);
  rect(xPos-5,yPos-10,sWidth+10,sHeight+20);  //draw white background behind slider
  
  float sliderPos = map(value,0.0,255.0,0.0,sWidth); //find the current sliderPosition from value
  
  for(int i=0;i<sWidth;i++){  //draw 1 line for each value from 0-255
      float val = map(i,0.0,sWidth,0.0,255.0);  //get value for each i position
      
      stroke(hue(myColor),255,val);
      line(xPos+i,yPos,xPos+i,yPos+sHeight);
  }
  
  noFill();
  stroke(100);
  rect(xPos,yPos,sWidth,sHeight);  //Paint edge of slider
  
  if(mousePressed && mouseX>xPos && mouseX<(xPos+sWidth) && mouseY>yPos && mouseY <yPos+sHeight){
     sliderPos = mouseX-xPos;
     value = map(sliderPos,0.0,sWidth,0.0,255.0);  // get new value based on moved slider
  }
  
  stroke(100);
  fill(hue(myColor),255,255);  //either new or old value
  rect(sliderPos+xPos-3,yPos-5,6,sHeight+10);  //this is our slider indicator that moves
    
  return value;
}