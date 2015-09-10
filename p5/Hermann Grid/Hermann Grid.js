/*
  Hermann Grid
  @author: Milder Hernandez
*/

var WIDTH = 800;
var HEIGHT = 600;
var SIZE = 50;
var SPACE = 12;

function setup ( ) {
	createCanvas(WIDTH, HEIGHT);

	input = createInput();
  	input.position(0, height+15);

  	changeSpeedButton = createButton('Change Size');
  	changeSpeedButton.position(0, input.height+height+15);

  	changeSpeedButton.mousePressed(function(){
    if( !isNaN(input.value()) && input.value() != ""  )
      SIZE = parseFloat(input.value());  
    }
  );
}

function draw ( ) { 

	background(255);
	fill(0);
	SPACE = SIZE / 5;
	for ( var i = 0; i < HEIGHT - SPACE; i += SIZE + SPACE ) 
		for ( var j = 0; j < WIDTH - SPACE; j += SIZE + SPACE ) 
			rect(i, j, SIZE, SIZE);


}