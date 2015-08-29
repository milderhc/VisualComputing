
/*
	http://www.openprocessing.org/sketch/168577
*/

function setup() {
  createCanvas(510, 220);
}
 
var angle = 0;
 
function draw() {

  var c = (cos(angle + PI/2) * width/2) + width/2;
  angle += 0.02;
  for (var i=0; i<510; i++) {
    stroke(i/2);
    line(i, 0, i, 320);
  }

  noStroke();
  fill(255,255,255);
  rectMode(CORNER);
  rect(0, 0, c, 220);
  fill(150);
  rectMode(CENTER);
  rect(width/2, height/2, 300, 40);

}
