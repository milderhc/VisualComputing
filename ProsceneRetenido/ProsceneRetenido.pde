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
Scene scene;
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

void setupBoxes(int T, int sz){
    X = new int[T];
    Y = new int[T];
    Z = new int[T];
    SZ = sz;
    Random r = new Random();
    shape = createShape();
   for(int i=0; i<T; i++){
     X[i] = randInt(-200,200);
     Y[i] = randInt(-200,200);
     Z[i] =  randInt(-200,200);
     
     drawBox2(X[i],Y[i],Z[i],sz);
     
   }
   //drawBox2(0,0,0,100);
  
}

void drawBox2(int x, int y, int z, int sz){
  shape.beginShape(QUADS);
  
  shape.vertex(x,y,z);
  shape.vertex(x,y+sz,z);
  shape.vertex(x+sz,y+sz,z);
  shape.vertex(x+sz,y,z);
 
  
  shape.endShape();
}


void setup() {
  size(640, 360, P3D);
  scene = new Scene(this);
  setupBoxes(10000,10);

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
PShape shape ;
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


void draw() {
  background(0);
  fill(204, 102, 0, 150);
  //scene.drawTorusSolenoid();  
  //drawBlock(0,0,0,10,10,10);
  //drawBoxes();
  shape(shape,0,0);
  updateButtons();
  displayButtons();
  println(frameRate);
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