//global values

PFont f = createFont("Century Gothic",16,true); // Arial, 16 point, anti-aliasing on

float _barWidth=300.0;    //slider-bar width;
float _value = 300;  //initial hueValue global value
float _lightness  = 300/2;

int n;
color myColorHSV;
color myColorHSL;

void setup(){
  n = 300;
  size(671,565);
  background(255,255,255);
  
  fill(0);
  textFont(f,36);
  text("HSV",140,50);
  text("HSL",475,50);
  textFont(f,24);
  
  myColorHSV = 0;
  myColorHSL = 0;
  doPaintHSV();
  doPaintHSL();
}

void draw(){
  HSV();
  HSL();
}

void mouseClicked(){
  if(mouseX >= 20 && mouseX <= 320 && mouseY >= 75 && mouseY <= 375){
    myColorHSV = get(mouseX,mouseY);
  }else if(mouseX >= 350 && mouseX <= 650 && mouseY >= 75 && mouseY <= 375){
    myColorHSL = get(mouseX,mouseY);
  }
}

void doPaintHSV(){
 
  noStroke();
  colorMode(HSB, n);
 
  for (int i = 0; i <= n; i++) {
    for (int j = 0; j <= n; j++) {
      stroke(i,j,n);
      point(i+20, j+75);
    }
  }
  
  stroke(100);
  noFill();
  rect(20, 75, n, n); 
  
}

void HSV(){

  _value = drawSliderHSV(20,390,_barWidth,30,_value);
  
  stroke(100);
  fill(hue(myColorHSV),saturation(myColorHSV), _value);
  rect(20, 435, 100 , 110); // this rectangle displays the changing color to the down side 
  
  noStroke();
  fill(0,0,300);
  rect(140, 435, 180 , 110);
  
  float H = map(hue(myColorHSV),0,300,0,360); 
  fill(0);
  text("H: "+parseInt(H)+" º",140,460);
  
  float S = map(saturation(myColorHSV),0,262.3,0,100); 
  fill(0);
  text("S: "+parseInt(S)+" %",140,500);
  
  float V = map(_value,0,300,0,100); 
  fill(0);
  text("V: "+parseInt(V)+" %",140,540);
  
}

float drawSliderHSV(float xPos, float yPos, float sWidth, float sHeight,float value){
  
  noStroke();
  fill(0,0,300);
  rect(xPos-5,yPos-10,sWidth+10,sHeight+20);  //draw white background behind slider
  
  float sliderPos = map(value,0.0,300,0.0,sWidth); //find the current sliderPosition from value
  
  for(int i=0;i<sWidth;i++){  //draw 1 line for each value from 0-300
      float val = map(i,0.0,sWidth,0.0,300.0);  //get value for each i position
      
      stroke(hue(myColorHSV),saturation(myColorHSV),val);
      line(xPos+i,yPos,xPos+i,yPos+sHeight);
  }
  
  noFill();
  stroke(100);
  rect(xPos,yPos,sWidth,sHeight);  //Paint edge of slider
  
  if(mousePressed && mouseX>xPos && mouseX<(xPos+sWidth) && mouseY>yPos && mouseY <yPos+sHeight){
     sliderPos = mouseX-xPos;
     value = map(sliderPos,0.0,sWidth,0.0,300.0);  // get new value based on moved slider
  }
  
  stroke(100);
  fill(hue(myColorHSV),saturation(myColorHSV),300);  //either new or old value
  rect(sliderPos+xPos-3,yPos-5,6,sHeight+10);  //this is our slider indicator that moves
    
  return value;
}

void doPaintHSL(){
 
  noStroke();
  colorMode(HSB, n);
  
  for (int i = 0; i <= n; i++) {
    for (int j = 0; j <= n; j++) {
      float h = map(i,0,n,0,1);
      float s = map(j,0,n,0,1);      
      float[] hsv = hsl_to_hsv(h,s,0.5);
      float hh = map(hsv[0],0,1,0,n);
      float ss = map(hsv[1],0,1,0,n);
      float vv = map(hsv[2],0,1,0,n);
      stroke(parseInt(hh),parseInt(ss),parseInt(vv));
      point(i+350, j+75);
    }
  }
  
  stroke(100);
  noFill();
  rect(350, 75, n, n); 
  
}

void HSL(){
    
  _lightness = drawSliderHSL(350,390,_barWidth,30,_lightness);
  
  float h = map(hue(myColorHSL),0,n,0,1);
  float s = map(saturation(myColorHSL),0,n,0,1);      
  float[] hsv = hsl_to_hsv(h,s,_lightness/300);
  float hh = map(hsv[0],0,1,0,n);
  float ss = map(hsv[1],0,1,0,n);
  float vv = map(hsv[2],0,1,0,n);
  
  stroke(100);
  fill(parseInt(hh),parseInt(ss),parseInt(vv));
  rect(350, 435, 100 , 110); // this rectangle displays the changing color to the down side 
  
  noStroke();
  fill(0,0,300);
  rect(470, 435, 180 , 110);
  
  float H = map(hue(myColorHSL),0,300,0,360); 
  fill(0);
  text("H: "+parseInt(H)+" º",470,460);
  
  float S = map(saturation(myColorHSL),0,262.3,0,100); 
  fill(0);
  text("S: "+parseInt(S)+" %",470,500);
  
  float V = map(_lightness,0,300,0,100); 
  fill(0);
  text("L: "+parseInt(V)+" %",470,540);
  
}

float drawSliderHSL(float xPos, float yPos, float sWidth, float sHeight,float lightness){
  
  noStroke();
  fill(0,0,300);
  rect(xPos-5,yPos-10,sWidth+10,sHeight+20);  //draw white background behind slider
  
  float sliderPos = map(lightness,0.0,300.0,0.0,sWidth); //find the current sliderPosition from lightness
  
  for(int i=0;i<sWidth;i++){  //draw 1 line for each value from 0-300
      float light = map(i,0.0,sWidth,0.000001,300.0);  //get value for each i position
      
      float h = map(hue(myColorHSL),0,n,0,1);
      float s = map(saturation(myColorHSL),0,n,0,1);      
      float[] hsv = hsl_to_hsv(h,s,light/300);
      float hh = map(hsv[0],0,1,0,n);
      float ss = map(hsv[1],0,1,0,n);
      float vv = map(hsv[2],0,1,0,n);
      
      stroke(parseInt(hh),parseInt(ss),parseInt(vv));
      line(xPos+i,yPos,xPos+i,yPos+sHeight);
  }
  
  noFill();
  stroke(100);
  rect(xPos,yPos,sWidth,sHeight);  //Paint edge of slider
  
  if(mousePressed && mouseX>xPos && mouseX<(xPos+sWidth) && mouseY>yPos && mouseY <yPos+sHeight){
     sliderPos = mouseX-xPos;
     lightness = map(sliderPos,0.0,sWidth,0.0,300.0);  // get new lightness based on moved slider
  }
  
  float h = map(hue(myColorHSL),0,n,0,1);
  float s = map(saturation(myColorHSL),0,n,0,1);      
  float[] hsv = hsl_to_hsv(h,s,0.5);
  float hh = map(hsv[0],0,1,0,n);
  float ss = map(hsv[1],0,1,0,n);
  float vv = map(hsv[2],0,1,0,n);
  
  stroke(100);
  fill(parseInt(hh),parseInt(ss),parseInt(vv));  //either new or old value
  rect(sliderPos+xPos-3,yPos-5,6,sHeight+10);  //this is our slider indicator that moves
    
  return lightness;
}

float[] hsv_to_hsl(float h, float s, float v){
     float hh, ss, ll;
     hh = h;
     ll = (v*(2-s))/2;
     ss = (v*s)/(1-abs(2*ll-1));
     float[] hsl = {hh,ss,ll};
     return hsl;
}

float[] hsl_to_hsv(float h, float s, float l){
     float hh, ss, vv;
     hh = h;
     vv = (2*l+s*(1-abs(2*l-1)))/2;
     ss = (2*(vv-l))/vv;
     float[] hsv = {hh,ss,vv};
     return hsv;
}