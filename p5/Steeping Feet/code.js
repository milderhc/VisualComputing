
/*
  Steeping Feet
  @author: Andres Felipe Cruz
*/

var cols;

var rect1, rect2, delta, paused, colsRectWitdhRelation ;

function drawBackground(){
  background(0,0,0);
  cols = width/(rect1.width/colsRectWitdhRelation);
  var xd = width/cols;

  noStroke();
  for(var i=0; i<cols; i++){
    if( i % 2 ) continue;
    fill(255,255,255);
    rect(xd*i, 0, xd, height);  
  }  

}


function setup(){

  

  var rectHeight = 25;
  var rectWidth = rectHeight*2;
  delta = 1;
  dir = 1;

  rect1 = {
    x : 60,
    y : 100,
    width : rectWidth,
    height : rectHeight,
    color : { r : 255, g : 255, b : 0 },
    draw : function(){
      fill( this.color.r, this.color.g, this.color.b );
      rect(this.x,this.y,this.width,this.height);
    }
  };

  rect2 = {
    x : rect1.x,
    y : rect1.y + rect1.height + 70,
    width : rectWidth,
    height : rectHeight,
    color : { r : 0, g : 0, b : 128 },
    draw : function(){
      fill( this.color.r, this.color.g, this.color.b );
      rect(this.x,this.y,this.width,this.height);
    }
  };  

  width = 700;
  height = 350;
  colsRectWitdhRelation = 4;
  cols = width/(rectWidth/colsRectWitdhRelation);
  paused = false;

  createCanvas(width,height);

  input = createInput();
  input.position(0, height+15);

  changeSpeedButton = createButton('Change speed');
  changeSpeedButton.position(0, input.height+height+15);

  changeSpeedButton.mousePressed(function(){
    if( !isNaN(input.value()) && input.value() != ""  )
      delta = parseFloat(input.value());  
    }
  );


  pauseButton = createButton('Toogle animation');
  pauseButton.position(0,changeSpeedButton.height+15+height+input.height);
  pauseButton.mousePressed( function(){
      paused = !paused;
  } );

  
  relationInput = createInput();
  relationInput.position( input.x + input.width + 50 , input.y );

  changeRelationButton = createButton("Change relation cols - rectWidth");
  changeRelationButton.position( relationInput.x, relationInput.y + relationInput.height );
  changeRelationButton.mousePressed( function(){
      if( !isNaN(relationInput.value()) && relationInput.value() != "" )
        colsRectWitdhRelation = relationInput.value();
  } );
 
   
}

function draw(){
  drawBackground();

  rect1.draw();
  rect2.draw();

  if( paused == false ){
    if( rect1.x + rect1.width - width >= delta  ) dir = -1;
    if( rect1.x <= delta ) dir = 1;


    rect1.x += dir*delta;
    rect2.x += dir*delta;
  
  }
  
  
}