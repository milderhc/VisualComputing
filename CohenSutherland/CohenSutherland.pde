/*
 * Coher Sutherland algorithm 
 */


class Point {
  float x, y;
  
  public Point ( float x, float y ) {
    this.x = x;
    this.y = y;
  }
}

class Line {
  Point from, to;
  public Line ( Point from, Point to ) {
    this.from = from;
    this.to = to;
  }
  
  float getY ( float x ) {
    float m = (from.y - to.y) / (from.x - to.x);
    return m * x - to.x * m + to.y;
  }
  
  float getX ( float y ) {
    float m = (from.x - to.x) / (from.y - to.y);
    return m * y - to.y * m + to.x;
  } 
  
  void cutByHorizontal ( float y, Point p ) {
    float newX = getX(y);
    float newY = getY(newX);
    p.x = newX; p.y = newY;
  } 
  
  void cutByVertical ( float x, Point p ) {
    float newY = getY(x);
    float newX = getX(newY);
    p.x = newX; p.y = newY;
  }
}

ArrayList<Line> lines, acceptedLines;
float top, bottom, left, right;
boolean click;
void setup ( ) {
  size(640, 720);
  lines = new ArrayList<Line>();
  acceptedLines = new ArrayList<Line>();
  int dx = width/4, dy = height/4;
  bottom = dy; top = height - dx; right = dx; left = width - dx;
  click = true;
  
  println("Top ", top);
  println("Bottom ", bottom);
  println("Left", left);
  println("Right", right);
}

void draw ( ) {
  background(0);
  drawRectangle();
  drawLines();
  
  if ( keyPressed && key == 'r' ) {
    cutLines();
  }
}

void drawRectangle ( ) {
  stroke(255, 255, 0);
  line(right, bottom, left, bottom);
  line(right, top, left, top);
  line(right, bottom, right, top);
  line(left, bottom, left, top);
}

void drawLines ( ) {
  stroke(255);
  for ( int i = 0; i < lines.size(); ++i ) {
    Line l = lines.get(i);
    line(l.from.x, l.from.y, l.to.x, l.to.y);
  }
  stroke(0, 255, 255);
  for ( int i = 0; i < acceptedLines.size(); ++i ) {
    Line l = acceptedLines.get(i);
    line(l.from.x, l.from.y, l.to.x, l.to.y);
  }
}

void cutLines ( ) {
  for ( int i = 0; i < lines.size(); ++i ) {
    cohenSutherland(lines.get(i)); 
  }
  lines = new ArrayList<Line>();
}

int makeCod ( Point p ) {
  int cod = 0;
  if ( p.y > top ) cod |= 8;
  if ( p.y < bottom ) cod |= 4;
  if ( p.x < right ) cod |= 2;
  if ( p.x > left ) cod |= 1;
  return cod;
}

void cohenSutherland ( Line l ) {
  int cod1 = makeCod(l.from);
  int cod2 = makeCod(l.to);
  
  int r = cod1 & cod2;
  
  println(l.from.x, l.from.y, " - ", l.to.x, l.to.y);
  
  //Trivial cases
  if ( r == 0 && cod1 == 0 && cod2 == 0 ) {
    acceptedLines.add(l);
    return;
  }
  if ( r != 0 ) return;
  
  
  if ( (cod1 & 8) > 0 ) {
    l.cutByHorizontal(top, l.from);
    cohenSutherland(l); return;
  }
  if ( (cod2 & 8) > 0 ) {
    l.cutByHorizontal(top, l.to);
    cohenSutherland(l); return;
  }
  if ( (cod1 & 4) > 0 ) {
    l.cutByHorizontal(bottom, l.from);
    cohenSutherland(l); return;
  }
  if ( (cod2 & 4) > 0 ) {
    l.cutByHorizontal(bottom, l.to);
    cohenSutherland(l); return;
  }
  if ( (cod1 & 2) > 0 ) {
    l.cutByVertical(right, l.from);
    cohenSutherland(l); return;
  }
  if ( (cod2 & 2) > 0 ) {
    l.cutByVertical(right, l.to);
    cohenSutherland(l); return;
  }
  if ( (cod1 & 1) > 0 ) {
    l.cutByVertical(left, l.from);
    cohenSutherland(l); return;
  }
  if ( (cod2 & 1) > 0 ) {
    l.cutByVertical(left, l.to);
    cohenSutherland(l); return;
  }
  
  println(l.from.x, l.from.y, " - ", l.to.x, l.to.y);
}

Point from, to;
void mousePressed ( ) {
  if ( click ) from = new Point(mouseX, mouseY);
  else {
    to = new Point(mouseX, mouseY);
    lines.add(new Line(from, to));
  }
  click = !click;
} 