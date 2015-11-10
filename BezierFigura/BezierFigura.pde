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
import remixlab.bias.core.*;
import remixlab.bias.event.*;

Scene scene;
ArrayList buttons;
float h;
PFont buttonFont;

float tam = 100;

class Point{
  
  float x,y,z;
  
  public Point(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Point add( Point p ){
    return new Point(x+p.x, y+p.y, z+p.z);
  }
  
  public Point mult( float m ){
    return new Point(x*m , y*m, z*m);
  }
  
}

void bezierCurve(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4){

  Point P0 = new Point(x1, y1, z1);
  Point P1 = new Point(x2, y2, z2);
  Point P2 = new Point(x3, y3, z3);
  Point P3 = new Point(x4, y4, z4);
  
  strokeWeight(2);
  for(float t = 0.0; t<=1; t+=0.01){
      Point B = P0.mult(pow((1 - t),3)).add(P1.mult(3.0 * t * pow((1 - t),2))).add(P2.mult(3.0 * pow(t, 2) * (1 - t))).add(P3.mult(pow(t,3)));
      point(B.x, B.y, B.z);
  }
  
}

void setup() {
  size(640, 360, P3D);
  scene = new Scene(this);

  //create a camera path and add some key frames:
  //key frames can be added at runtime with keys [j..n]
    scene.camera().setPosition(120,0,0);
  scene.camera().lookAt( scene.camera().sceneCenter() );
  scene.camera().addKeyFrameToPath(1);

  scene.camera().setPosition(50,50,120);
  scene.camera().lookAt( scene.camera().sceneCenter() );
  scene.camera().addKeyFrameToPath(1);

  scene.camera().setPosition(-50,-50,130);
  scene.camera().lookAt( scene.camera().sceneCenter() );
  scene.camera().addKeyFrameToPath(1);

  scene.camera().setPosition(-80,10,10);
  scene.camera().lookAt( scene.camera().sceneCenter() );
  scene.camera().addKeyFrameToPath(1);
  
  for(int i= 40; i <= 140; i+=40){
      scene.camera().setPosition(-i,i*2,i);
      scene.camera().lookAt( scene.camera().sceneCenter() );
      scene.camera().addKeyFrameToPath(1);
  }

  //re-position the camera:
  scene.camera().setPosition(0,0,1);
  scene.camera().lookAt( scene.camera().sceneCenter() );
  
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

void draw() {
  background(0);

  if(keyPressed && key == '2') tam++;
  if(keyPressed && key == '3') tam--;

         for(int x = 0; x <= 360; x++){
           noStroke();
           rotate(1);
           stroke(255,255,255);
           strokeCap(ROUND);
           //line(0, 0, tam ,0, 0, 0);
           line(0, 0, 0, tam, tam, 0);
           noFill();
           stroke(0,130,255);
           bezierCurve(0, 0, tam ,0, 0, 0,
                     0, 0, 0, tam, tam, 0);  
         }

  updateButtons();
  displayButtons();
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