import processing.opengl.*;


void setup()
{
    size(400, 400, OPENGL);
    
}

void draw()
{
    background(0, 0, 155);
    lights();
    
    pushMatrix();    
    translate( 200, 200, 80 );
    rotateX( PI/3 );
    rotateY( radians( frameCount ) );
    rotateZ( radians( frameCount ) );
    drawCylinder( 360, 50, 100 );
    popMatrix();
    
}

void drawCylinder( int sides, float r, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    
    colorMode(HSB, 360);
    
    fill(0,0,360);
    
    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    fill(0,0,0);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        noStroke();
        fill(i,360,360);
        vertex( x, y, halfHeight);
        vertex( x, y, -halfHeight);    
    }
    endShape(CLOSE);

}