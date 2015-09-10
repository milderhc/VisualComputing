/*
  Size Circle
  @author: Maikol Bonilla
*/

function  setup(){
  createCanvas(600,300);
}

function draw(){ 

  var x = document.getElementById("myCheck").checked;
  
  background(255,255,255);
  strokeWeight(2);
  
  /*Se crean dos circulos del mismo tamano*/
  fill(0,0,0);
  ellipse(150,150,40,40);
  ellipse(450,150,40,40);
  
  /*El primer circulo se rodea con circulos mas grandes*/
  /*El segundo circulo se rodea con circulos mas pequeños*/
  if(x == false){
    noFill();
    stroke(0,0,0);
    ellipse(150,110,30,30);
    ellipse(150,190,30,30);
    ellipse(115,130,30,30);
    ellipse(115,170,30,30);
    ellipse(185,130,30,30);
    ellipse(185,170,30,30);
    
    ellipse(450,95,50,50);
    ellipse(450,205,50,50);
    ellipse(400,123,50,50);
    ellipse(400,177,50,50);
    ellipse(500,123,50,50);
    ellipse(500,177,50,50);
  }

}