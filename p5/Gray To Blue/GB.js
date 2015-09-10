
/*
  Gray To Blue
  @author: Maikol Bonilla Gil
  @reference: https://www.youtube.com/watch?v=M7-z_ZRcKEE
*/

var t = 255;

function setup(){
  
  createCanvas(550,400);
  dark_light = parseInt(random(0, 200));

}

function draw(){

	background(141,139,141);

	/*Se crea el rectangulo naraja*/
	strokeWeight(15);
	fill(255,125,0);
	rect(-15,-15,250,300);
	point(480,330);

	if(t == 0){
		t = 255;
		dark_light = light_dark; 
	}

	/*Esta sentencia se ejecuta mientras el rectangulo gris aun tenga transparencia*/
	if(t == 255){
		do{
			light_dark = parseInt(random(0, 200));
		}while(abs(light_dark-dark_light)<= 50);
	}

	/*Se crean los rectangulos que estan cambiando la transparencia*/
	/*A me dida que uno se va volviendo mas transparente el otro se va oscureciendo*/
	noStroke();
	fill(141,139,141,t);
	rect(0,dark_light,228,50);
	
	fill(141,139,141,254-t);
	rect(0,light_dark,228,50);

	t = t - 15;
}