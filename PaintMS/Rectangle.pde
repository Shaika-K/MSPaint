class Rectangle extends PaintShape{

  public float rectangleWidth, rectangleHeight, topLeftX, topLeftY; 
  public color col;

  Rectangle(float rX, float rY, float rW, float rH, color c) {
    super();
    rectangleWidth = rW;
    rectangleHeight = rH;  
    topLeftX = rX;
    topLeftY = rY;
    col = c;  //colour of our Ellipse
  }

  public void drawRectangle() {
    fill(col);
    noStroke();
    smooth();
    rect(topLeftX, topLeftY, rectangleWidth, rectangleHeight);
  }
}
