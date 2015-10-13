/*
 * Apple with Cubic Splines (Continuous spline curves) 
 * using Cylindrical coordinates system
 *
 */
 
import remixlab.proscene.*;
Scene scene;

void setup ( ) {
  size(640, 720, P3D);
  scene = new Scene(this);
  scene.showAll();
}

/*
 * Defining points for a single curve line to draw an apple 
 * and constants to draw the figures
 */

int N_BODY = 25; 
float p_body[] = {0, 0, 5, 10, 15, 20, 30, 40, 45, 43, 41, 38, 35, 35, 32, 30, 28, 25, 22, 20, 15, 10, 5, 0, 0};
float z_body[] = {80, 80, 85, 88, 90, 91, 92, 80, 70, 60, 50, 40, 30, 30, 20, 15, 10, 8, 7, 7, 7, 9, 11, 13, 13};

int N_LEAVE = 5;
float p_leave[] = {0, 0, 5, 15, 15};
float z_leave[] = {80, 80, 95, 105, 105};
float PHI_LEAVE = 3.1416;

float DENSITY = 0.004;
float SIZE = 1;

void draw ( ) {
  background(0);
  noFill();
  
  // Drawing leave
  stroke(0, 64, 0);
  strokeWeight(10);
  beginShape();
  for ( int i = 0; i < N_LEAVE; ++i )
    curveVertex(p_leave[i] * cos(PHI_LEAVE) * SIZE, p_leave[i] * sin(PHI_LEAVE) * SIZE, z_leave[i] * SIZE);
  endShape();
  
  // Drawing body
  stroke(255,8,0);
  strokeWeight(2);
  for ( float phi = 0; phi < 6.28; phi += DENSITY ) {
    beginShape();
    for ( int i = 0; i < N_BODY; ++i )
      curveVertex(p_body[i] * cos(phi) * SIZE, p_body[i] * sin(phi) * SIZE, z_body[i] * SIZE);
    endShape();
  }
}