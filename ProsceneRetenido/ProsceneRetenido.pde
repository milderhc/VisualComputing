/**
 * Camera Interpolation.
 * by Jean Pierre Charalambos.
 * 
 * This example (together with Frame Interpolation) illustrates the
 * KeyFrameInterpolator functionality.
 * 
 * KeyFrameInterpolator smoothly interpolate its attached Camera Frames over time
 * on a path defined by Frames. The interpolation can be started/stopped/reset,
 * played in loop, played at a different speed, etc...
 * 
 * In this example, a Camera path is defined by four InteractiveFrames
 * which are attached to the first Camera path (the Camera holds five such paths).
 * The Frames can be moved with the mouse, making the path editable. The Camera
 * interpolating path is played with the shortcut '1'.
 * 
 * Press CONTROL + '1' to add (more) key frames to the Camera path.
 * 
 * Press ALT + '1' to delete the Camera path.
 *
 * The displayed texts are interactive. Click on them to see what happens.
 * 
 * The Camera holds 5 KeyFrameInterpolators, binded to [1..5] keys. Pressing
 * CONTROL + [1..5] adds key frames to the specific path. Pressing ALT + [1..5]
 * deletes the specific path. Press 'r' to display all the key frame camera paths
 * (if any). The displayed paths are editable.
 * 
 * Press 'h' to display the key shortcuts and mouse bindings in the console.
 */

import remixlab.proscene.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.core.*;
import remixlab.bias.core.*;
import remixlab.bias.event.*;
import java.util.*;
import processing.core.PShape;

PFont f = createFont("Century Gothic",11,true); // Arial, 16 point, anti-aliasing on
ArrayList<Ball> balls;
final int ballWidth = 1;
boolean pressed = false;
int T = 1000;

PShape[] shape = new PShape[T];
Scene scene;
PGraphics canvas; 

ArrayList buttons;
int h;
PFont buttonFont;


int X[],Y[],Z[],SZ;


int randInt(int min, int max) {

    // NOTE: This will (intentionally) not run as written so that folks
    // copy-pasting have to think about how to initialize their
    // Random instance.  Initialization of the Random instance is outside
    // the main scope of the question, but some decent options are to have
    // a field that is initialized once and then re-used as needed or to
    // use ThreadLocalRandom (if using at least Java 1.7).
    Random rand =  new Random();

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
}

void setupBoxes(int sz){
    X = new int[T];
    Y = new int[T];
    Z = new int[T];
    SZ = sz;
    Random r = new Random();
   for(int i=0; i<T; i++){
     X[i] = randInt(-200,200);
     Y[i] = randInt(-200,200);
     Z[i] =  randInt(-200,200);
     
     shape[i] = createShape(BOX, X[i], Y[i], Z[i]);
     //shape[i] = createShape(BOX, sz, sz, sz); 
     //shape[i].translate(X[i]+SZ/2,Y[i]+SZ/2,Z[i]-SZ/2);
 
   }
  
}

void setupChart(){
  // Create an empty ArrayList
  balls = new  ArrayList();
  for (int i=0; i < 170; i++) {
    balls.add(new Ball(0, 20, 0, color ( 0, 0, 0)));
  }
}

void setup() {
  
  size(640, 360, P3D);
  
  canvas = createGraphics(640, 360, P3D);
  scene = new Scene(this, canvas);
  setupBoxes(10);
  scene.showAll();
  scene.setPathsVisualHint(true);
  
  setupChart();

  //create a camera path and add some key frames:
  //key frames can be added at runtime with keys [j..n]
  for(int i=-1000; i<=-200; i+=100){
    scene.camera().setPosition(new Vec(i,-300,-300));
    scene.camera().lookAt( scene.camera().sceneCenter() );
    scene.camera().addKeyFrameToPath(1);
  }
  
  for(int i=-200; i<=1000; i+=100){
    scene.camera().setPosition(new Vec(i/3,i,i/2));
    scene.camera().lookAt( scene.camera().sceneCenter() );
    scene.camera().addKeyFrameToPath(1);
  }
  
  scene.showAll();

  //drawing of camera paths are toggled with key 'r'.
  scene.setPathsVisualHint(true);

  buttons = new ArrayList(6);
  for (int i=0; i<5; ++i)
    buttons.add(null);
    
  buttonFont = loadFont("FreeSans-16.vlw");
  
  Button2D button = new ClickButton(scene, new PVector(10,5), buttonFont, 0);
  h = button.myHeight;
  buttons.set(0, button);
}

void drawBlock(int x, int y, int z,  int xSz, int ySz, int zSz){
  //pushMatrix();
  //translx/2,z-zSz/2);
  //box(xSz, ySz, zSz);
  //popMatrix();
}

void drawBoxes(){
   for(int i=0; i<X.length; i++){
       drawBlock(X[i],Y[i],Z[i],SZ,SZ,SZ);
   }
}

void drawChart(){

  fill(0);
  noStroke();
  rect(435, 200, 200, 150);
  
  fill(255);
  stroke(255,255,255);
  line(460, 331, 630, 331); //Y
  line(630, 329, 630, 333);
  
  line(459, 331, 459, 205); //X
  
  for(int i = 0; i < 100; i += 10){
    line(457, 205+map(i,0,100,0,126), 461, 205+map(i,0,100,0,126));
  }
  
  textFont(f,11);
  text("Camera Time",505,343);
  pushMatrix();
  rotate(-HALF_PI);
  text("Frame Rate",-305,455);
  popMatrix();
  text("0",450, 340);
  text("100",437,210); 
 

  println(frameRate);
  Ball ball;
  balls.add(new Ball(0, map(100-frameRate, 0, 100, 205, 330), ballWidth, color(255, 255, 0, 130)));
  for (int i=0; i < balls.size(); i++) {
    ball = balls.get(i);
    ball.display(460+i);
  }

  if (balls.size()>0)
    balls.remove(0);
      
}


void draw() {
  
  canvas.beginDraw();
  scene.beginDraw();
  canvas.background(0);
  for(int i=0; i<T; i++){
    canvas.shape(shape[i],0,0);
  }
  updateButtons();
  displayButtons();
  scene.endDraw();
  canvas.endDraw();
  
  image(canvas, 0, 0);
  
  drawChart();
 
}

void updateButtons() {
  for (int i = 1; i < buttons.size(); i++) {
    // Check if CameraPathPlayer is still valid
    if ((buttons.get(i) != null) && (scene.camera().keyFrameInterpolator(i) == null ) )
      buttons.set(i, null);
    // Or add it if needed
    if ((scene.camera().keyFrameInterpolator(i) != null) && (buttons.get(i) == null))
      buttons.set(i, new ClickButton(scene, new PVector(10, + ( i ) * ( h + 7 )), buttonFont, i));
  }
}

void displayButtons() {
  for (int i = 0; i < buttons.size(); i++) {
    Button2D button = (Button2D) buttons.get(i);
    if ( button != null )
      button.display();
  }
}

// =====================================================================
// Simple ball class
class Ball {
  float x;
  float y;
  color myColor;
  float w;
  Ball(float tempX, float tempY, float tempW, color tempmyColor1) {
    x = tempX;
    y = tempY;
    w = tempW;
    myColor=tempmyColor1;
  }
  void display(float i) {
    // Display the ball
    fill(myColor);
    stroke(myColor);
    ellipse(i, y, w, w);
    point(i, y);
  }
} 
// =====================================================