
/*
  Hering
  @author: Maikol Bonilla Gil
*/

function setup(){
  
  createCanvas(520,520);

}

function draw(){

  var x = document.getElementById("myCheck").checked;
  background(255,255,255);

  /*Estas sentencias colocan las lineas de fondo*/
  if(x == false){
    stroke(68,35,255);
    strokeWeight(1);
    
    var i = 0;
    var j = 0;
    /*Estas sentencias colocan las lineas que se extienden sobre el eje y*/
    while(i != 220){
      line(40+j,260-i,480-j,260+i);
      line(40+j,260+i,480-j,260-i);
      i = i + 20;
      j = j + 1;
    }
    

    i = 0;
    j = 0;
    /*Estas sentencias colocan las lineas que se extienden sobre el eje x*/
    while(i != 220){
      line(260-i,40+j,260+i,480-j);
      line(260+i,40+j,260-i,480-j);
      i = i + 20;
      j = j + 1;
    }
  }
  
  /*Se colocan las dos lineas a las cuales se van a ver con la ilusion*/
  strokeWeight(2);
  stroke(255,0,0,200);
  line(10,210,510,210);
  line(10,310,510,310);

}