
function setup(){
  
  createCanvas(520,520);
  background(255,255,255);
  strokeWeight(1);
  
  var i = 0;
  var j = 0;
  while(i != 220){
    line(40+j,260-i,480-j,260+i);
    line(40+j,260+i,480-j,260-i);
    i = i + 20;
    j = j + 1;
  }
  

  i = 0;
  j = 0;
  while(i != 220){
    line(260-i,40+j,260+i,480-j);
    line(260+i,40+j,260-i,480-j);
    i = i + 20;
    j = j + 1;
  }
  
  //stroke(0,255,0);
  strokeWeight(1);
  line(10,200,510,200);
  line(10,320,510,320);
  
}

function draw(){

}