
var t = 40;

function setup(){
  
  // x = t*2*7
  // y = t*10
  createCanvas(560,400);
 
  var h = 0;  
  var sum = true;
  
  for(var i = 0; i < t*10; i = i + t){
    for(var j = -t*2; j < t*2*7; j = j + t*2){
      fill(0,0,0);
      stroke(115,115,115);
      strokeWeight(2);
      rect(j+h,i,t,t);
      
      fill(255,255,255);
      stroke(115,115,115);
      strokeWeight(2);
      rect(j+h+t,i,t,t);
    }
    
    if(h == 0){
      sum = true;
    }
    if(h == 30){
      sum = false;
    }
    
    if(sum){
      h = h + 15;
    }else{
      h = h - 15;
    }    
    
  }
  
}

function draw(){
 
}