/*
  Based in Penrose staircase with a slight modification
  Inspired in https://www.youtube.com/watch?v=7pPPWei2oEA
  and in: http://timvandevall.com/wp-content/uploads/2014/03/Endless-Staircase-Optical-Illusion1.jpg
*/


import remixlab.proscene.*;
import remixlab.dandelion.geom.*;

Scene scene;
String renderer = P3D;

void sceneStuff(){
   //Scene instantiation
  scene = new Scene(this);
  // when damping friction = 0 -> spin
  scene.eye().frame().setDampingFriction(0);
}

//Draws a single blocl
void drawBlock(int x, int y, int z,  int xSz, int ySz, int zSz){
  pushMatrix();
  translate(x+xSz/2,y+ySz/2,z-zSz/2);
  box(xSz, ySz, zSz);
  popMatrix();
}

//Draws a block sequence used to make the stairs
void drawblockSequence(int x, int y, int z, int n,  int xSz, int ySz, int zSz, char growingSide){
  for(int i=0; i<n; i++){
    if( growingSide == 'x' )
      drawBlock(x+i*xSz, y, z, xSz, ySz, zSz);
    else if( growingSide == 'y' )
      drawBlock(x, y+i*ySz, z, xSz, ySz, zSz);
  }
}

//Draws the whole object (The stairs)
void drawStuff(int cols, int firstBase){
  lights();

  int stX = 0;
  int stY = 0;
  int stZ = 0;
  int comp = cols/2;

  int xSz = 25, ySz = 25, zSz = 5;

  for(int c=0,h=firstBase; c<cols; c++, h++){
    for(int j=0; j<h; j++){
      drawBlock(stX, stY, stZ + j*zSz, xSz, ySz, zSz);
    }

    stX += xSz;
  }

  stX -= xSz;
  stY -= ySz;


  for(int c=0, h=firstBase+cols; c<comp; c++, h++){
    for(int j=0; j<h; j++){
      drawBlock(stX, stY, stZ + j*zSz, xSz, ySz, zSz);
    }

    stY -= ySz;
  }

  stY += ySz;
  stX -= xSz;

  for(int c=0, h = firstBase + cols + comp; c<comp; c++, h++){
    for(int j=0; j<h; j++){
      if( c != comp-1)
        drawBlock(stX, stY, stZ + j*zSz, xSz, ySz, zSz);
      else if( j == h-1 ){
        int p = 1;
        int lel = stZ + j*zSz-p;

        drawBlock(stX + xSz, stY, lel, 0, ySz, zSz-p);
        //int xd = 10;
        //drawBlock(stX, stY - xd/2, stZ + j*zSz + zSz/2 - delta, xSz, ySz - xd, 0);
        beginShape();
        int dd = 0;
        int initX = stX;
        noStroke();
        vertex(initX,stY,lel);
        vertex(initX,stY+ySz-dd,lel);
        vertex(initX+xSz,stY+ySz,lel);
        vertex(initX + xSz,stY,lel);
        endShape(CLOSE);
        stroke(1);

      }
    }

    stX -= xSz;
  }

  stX = 0;
  stY = -ySz;

  //ySz *= 1.9;

  for(int j=0; j<firstBase-1; j++){
    drawBlock(stX, stY, stZ + j*zSz, xSz, ySz, zSz);
  }

  int extra = (firstBase-1)/2+1;
  stZ -= extra*zSz + 2*zSz;
  stY -= ySz;
  for(int i=0; i<cols-3; i++){
    for(int j=0; j<firstBase+extra; j++){
      drawBlock(stX, stY, stZ + j*zSz, xSz, ySz, zSz);
    }

    stY -= ySz;
    stZ -= zSz;
  }

  //camera  [ 132.92488, 57.02342, 187.9417 ]


}

void setup() {
  size(800,600,renderer);
  background(0);
  sceneStuff();
  //Vec pos = new Vec(132.92488, 57.02342, 187.9417 );
  //scene.eye().fitBall(pos,100);
}

void draw() {
  background(0);

  drawStuff(5,9);

}

void keyPressed() {

  println("Camera damping friction now is " + scene.center());
}
