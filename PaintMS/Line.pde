class Line extends PaintShape{

  public float startX, startY, endX, endY; 
  public color col;

  Line(float x, float y, float eX, float eY, color c) {
    super();
    startX = x;
    startY = y;
    endX = eX;
    endY = eY;
    col = c;  //colour of our line
  }

  public void drawLine() {
    noFill();
    stroke(col);
    smooth();
    line(startX, startY, endX, endY);
  }
}
