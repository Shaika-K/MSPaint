class Ellipse extends PaintShape{

  public float ellipseWidth, ellipseHeight, topLeftX, topLeftY; 
  public color col;

  Ellipse(float eX, float eY, float eW, float eH, color c) {
    super();
    ellipseWidth = eW;
    ellipseHeight = eH;
    topLeftX = eX;
    topLeftY = eY;
    col = c;  //colour of our Ellipse
  }

  public void drawEllipse() {
    fill(col);
    noStroke();
    ellipseMode(CORNER);
    smooth();
    ellipse(topLeftX, topLeftY, ellipseWidth, ellipseHeight);
  }
}
