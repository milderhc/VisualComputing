var WIDTH = 800;
var HEIGHT = 600;
var SIZE = 50;
var SPACE = 12;

function setup ( ) {
	createCanvas(WIDTH, HEIGHT);
	background(255);
	fill(0);
	for ( var i = 0; i < HEIGHT - SPACE; i += SIZE + SPACE ) 
		for ( var j = 0; j < WIDTH - SPACE; j += SIZE + SPACE ) 
			rect(i, j, SIZE, SIZE);
}

function draw ( ) { }