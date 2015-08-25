
var t = 255;

function setup(){
  
  createCanvas(550,400);
  dark_light = parseInt(random(0, 200));

}

function draw(){

	background(141,139,141);
	//frameRate(10000);

	strokeWeight(15);
	fill(255,125,0);
	rect(-15,-15,250,300);
	point(480,330);

	if(t == 0){
		t = 255;
		dark_light = light_dark; 
	}

	if(t == 255){
		do{
			light_dark = parseInt(random(0, 200));
		}while(abs(light_dark-dark_light)<= 50);
	}

	noStroke();
	fill(141,139,141,t);
	rect(0,dark_light,228,50);
	
	fill(141,139,141,254-t);
	rect(0,light_dark,228,50);

	t = t - 15;
}