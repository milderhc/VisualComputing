
/*
  Cafe-Wall
  @author: Maikol Bonilla Gil
*/

/*Esta variabe redimensiona el tamño de los cuadros*/
var t = 40;

function setup(){
  
  createCanvas(t*2*7,t*10);
  
  input = createInput();
  input.position(0, height+15);

  changeSpeedButton = createButton('Change Size');
  changeSpeedButton.position(0, input.height+height+15);

  changeSpeedButton.mousePressed(function(){
    if( !isNaN(input.value()) && input.value() != ""  )
      t = parseFloat(input.value());  
    }
  );

}

function draw(){
 
  background(0);

  var h = 0;  
  var sum = true;
  
  /*Estas sentencias colcan un cuadro negro y un cudro blaco para despues replicarlos por columnas y seguido este resultado se replica por fila*/
  
  for(var i = 0; i < t*90; i = i + t){
    for(var j = -t*2; j < t*2*50; j = j + t*2){
      fill(0,0,0);
      stroke(115,115,115);
      strokeWeight(2);
      rect(j+h,i,t,t);
      
      fill(255,255,255);
      stroke(115,115,115);
      strokeWeight(2);
      rect(j+h+t,i,t,t);
    }
    
    /*Estas sentencias hacen la condicion para que los cuadros se corran en las filas*/
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