
function setup(){
  
  createCanvas(520,520);

}

function draw(){

  var x = document.getElementById("myCheck").checked;
  background(255,255,255);

  if(x == false){
    stroke(68,35,255);
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
  }
  
  //stroke(0,255,0);
  strokeWeight(2);
  stroke(255,0,0,200);
  line(10,210,510,210);
  line(10,310,510,310);

}