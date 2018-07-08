/* 
 ===MS Paint===
 Auhtor Shaika Khan
 2018
 
 This is a very simple version of a MS Paint type sketch made with Processing.
 This sketch has been made for th eProcessing worksop for 'Tech Day For Girls' 2018 hosted by VUWWIT.
 
 What this sketch does: Like MS paint, it draws filled shapes which consists of rectangles, ellipses 
 and lines, draws with a 'brush', picks colours, and erases (white only).
 Additionally it also places a background image to draw or trace over. Undo can also be done via ctrl+z
 
 == BUGS ==
 There are some bugs of course, this sketch was made in 6 hours so thats deffnitley likely.
 
 Gold star to any outreach girls who can fix this or any bugs!
 
 Also forgive my spelling/grammar errors. 
 
 Enjoy :)
 */
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Constants -- things which can be accessed from anywhere in this sketch ////////////////////////////////////////////////////////////////////
private PImage colours, brush, eraser, dropper, tracingImage;  //image objects which are saved in the data folder of this sketch

// ArrayList are a type of 'bag' where objects can be stored
private ArrayList<PaintShape> shapes;   // here we have a ArrayList to store our drawn shapes

// Booleans are hold true or false values
private boolean drawing, rectangleSelected, ellipseSelected, lineSelected, brushSelected, eraserSelected, dropperSelected, pressed;

// float are numbers which include digits after the decimal point
// these button float describe the x and y of the coordinates for the buttons in MS Paint
// the left and right x value are the same for all butons but the Y values change for each button since they have different vertical positions
private float buttonRightX, buttonLeftX, 
  newButtonTopY, newButtonBottomY, 
  rectButtonTopY, rectButtonBottomY, 
  ellipseButtonTopY, ellipseButtonBottomY, 
  lineButtonTopY, lineButtonBottomY, 
  brushButtonTopY, brushButtonBottomY, 
  eraserButtonTopY, eraserButtonBottomY, 
  dropperButtonTopY, dropperButtonBottomY;

// these coordinates describe the mouses start and end points when drawing an object on the canvas
private float topLeftX, topLeftY, bottomRightX, bottomRightY;

//the color object (mind the american spelling!) holds teh value of fill the colour for next object drawn
private color currentSelectedColour, buttonColour, buttonSelectedColour;

// canvas coordinates describe the boundaries for the objects so they don't get drawn over the buttons and colour picker.
private float canvasTopLeftX, canvasTopLeftY, canvasBottomRightX, canvasBottomRightY;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// setup() is for setting up the sketch such as its size and also initialising the constants with valuess
void setup() {
  size(1000, 700);  // size of sketch
  background(255);  // white background colour for sketch
  tracingImage = loadImage("background.png");  // the image to trace on the canvas

  // Buttons sidebars
  noStroke(); // meaning no outline
  // buttons
  fill(70);  // meaning the filled in colour
  rect(0, 0, 115, 700);  // makes a rectangle object. In this case, the grey sidebar for the buttons
  // loadImage loads and image given a path which looks like "/C:/Home/Desktop/image1.jpg" 
  //     or just "image1.jpg" if its in the data folder of this sketch
  brush = loadImage("brush.png");  // the image used on the brush button
  eraser = loadImage("eraser.png");  // the image used on the eraser button
  dropper = loadImage("dropper.png");  // the image used on the eye dropper button

  // Colour picker sidebar
  colours = loadImage("colours.jpg");  //rainbow gradient colour picker
  buttonColour = 180;
  buttonSelectedColour = #71E0D8;

  // Constants' with values
  shapes = new ArrayList<PaintShape>();

  // these booleans are for the buttons on the sidebar. They are all FALSE meaning they haven't been clicked on.
  drawing = false;
  rectangleSelected = false;
  ellipseSelected = false;
  lineSelected = false;
  brushSelected = false;
  eraserSelected = false;
  dropperSelected = false;
  
  pressed = false;

  currentSelectedColour = 0;  // the current colour is 0 menaing BLACK

  //Our canvas boundary coordinates
  canvasTopLeftX = 115;
  canvasTopLeftY = 0;
  canvasBottomRightX = 1000;
  canvasBottomRightY = 580;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// draw() draws everything on the sketch 60 frames per second
void draw() {
  noStroke();  // no outline
  image(tracingImage, 115, 0, 885, 580);  //background image to draw over
  fill(255, 255, 255, 100);  // semi transparent colour
  rect(115, 0, 885, 580);  // semi transparent coloured rectangle overlayes the image so its easier to distinguish image form paint

  //draw painted shapes
  for (PaintShape shape : shapes) {  // for (all the 'PaintShape', called 'shape', in the ArrayList 'shapes')
    if (shape instanceof Ellipse) {   // if this shape is a Ellipse   
      Ellipse ellipseShape = (Ellipse) shape;  // call it ellipseShape 
      ellipseShape.drawEllipse();  // draw
    } else if (shape instanceof Rectangle) {   // if this shape is a Rectangle     
      Rectangle rectangleShape = (Rectangle) shape;
      rectangleShape.drawRectangle();
    } else if (shape instanceof Line) {      // if this shape is a Line 
      Line lineShape = (Line) shape;
      lineShape.drawLine();
    }
  }

  image(colours, 115, 580, 885, 120);  // draw image of rainbow gradient colour picker 

  // Sidebar of buttons  
  buttonLeftX = 16;
  buttonRightX = 102; 

  // new button
  fill(buttonColour);
  noStroke();
  rect(15, 15, 85, 45);  
  newButtonTopY = 15;  // top and bottom boundaries of the button
  newButtonBottomY = 58;
  fill(0);  //text colour
  text("New Picture", 25, 43);

  // rectangle button
  fill(checkButtonState("rectangle"));
  noStroke();
  rect(15, 75, 85, 85);  
  rectButtonTopY = 74;  // top and bottom boundaries of the button
  rectButtonBottomY = 159;
  noFill();
  stroke(0);
  strokeWeight(5);
  rect(25, 85, 65, 65);

  // ellipse button
  fill(checkButtonState("ellipse"));
  noStroke();
  rect(15, 180, 85, 85);
  ellipseButtonTopY = 181;  // top and bottom boundaries of the button
  ellipseButtonBottomY = 265;
  noFill();
  stroke(0);  
  strokeWeight(5);
  ellipseMode(CENTER);
  ellipse(58, 222, 65, 65);

  //line button
  fill(checkButtonState("line"));
  noStroke();
  rect(15, 285, 85, 85);
  lineButtonTopY = 283;  // top and bottom boundaries of the button
  lineButtonBottomY = 370;
  stroke(0);
  strokeWeight(5);
  line(25, 295, 90, 360);

  // brush button
  fill(checkButtonState("brush"));
  noStroke();
  rect(15, 390, 85, 85);
  brushButtonTopY = 390;  // top and bottom boundaries of the button
  brushButtonBottomY = 475;  
  image(brush, buttonLeftX+10, brushButtonTopY+10, 65, 65);  // image of paint brush

  // eraser button
  fill(checkButtonState("eraser"));
  noStroke();
  rect(15, 495, 85, 85);  // our button
  eraserButtonTopY = 494;  // top and bottom boundaries of the button
  eraserButtonBottomY = 580;  
  image(eraser, buttonLeftX+10, eraserButtonTopY+10, 65, 65);  // image of eraser

  // eye dropper button
  fill(checkButtonState("dropper"));
  noStroke();
  rect(15, 600, 85, 85);
  dropperButtonTopY = 600;  // top and bottom boundaries of the button
  dropperButtonBottomY = 684; 
  image(dropper, buttonLeftX+10, dropperButtonTopY+10, 65, 65);  // image of dropper
  
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// In built processing //

// keypressed is a Processing inbuilt method which detects any keys pressed
void keyPressed() {
  if (key == 26) {  // 26 collerates to ctrl+z i.e Undo
    if (shapes.size() > 0) {
      shapes.remove(shapes.size()-1);  // delete the last object in the shapes ArrayList
    }
  }
}

//// mousePressed is a Processing inbuilt method which detects if the mouse is pressed and not let released
void mousePressed() {
  if (overCanvas()) {  // if mouse is pressed on the canvas
    drawing = true;  // then drawing has started
    if (rectangleSelected == true) {  // if rectangle button is selected
      topLeftX = setBoundary(mouseX, true);  // set the x and y values of the top left corner aka the starting point
      topLeftY = setBoundary(mouseY, false);
      pressed = true;   
    } else if (ellipseSelected == true) {      
      topLeftX = setBoundary(mouseX, true);
      topLeftY = setBoundary(mouseY, false);
    } else if (lineSelected == true) {      
      topLeftX = setBoundary(mouseX, true);
      topLeftY = setBoundary(mouseY, false);
    } else if (brushSelected == true) {     // if the brush button is selected
      // the brush is made up of many small rectangles
      // when the mouse is pressed, create a Rectagle shape and add to the shapes ArrayList
      shapes.add(new Rectangle(setBoundary(mouseX, true), setBoundary(mouseY, false), 20, 15, currentSelectedColour));
    } else if (eraserSelected == true) {      
      // the brush is made up of many small ellipse
      // when the mouse is pressed, create a Ellipse shape and add to the shapes ArrayList
      shapes.add(new Ellipse(setBoundary(mouseX, true), setBoundary(mouseY, false), 20, 20, 255));
    }
  }
}

// mouseDragged is a Processing inbuilt method which detects if the mouse is pressed and moved but not let released
void mouseDragged() {
  if (drawing == true) { // if mouse is pressed on the canvas and drawing has started
    if (rectangleSelected == true && (pressed == true)) {    // if rectangle button is selected
      bottomRightX = setBoundary(mouseX, true);   // set the x and y values of the bottom right corner aka the end point
      bottomRightY = setBoundary(mouseY, false);
      //draw temporary rectangles to see how the final one will look before the mouse is released
      fill(currentSelectedColour);
      noStroke();
      smooth();
      rect(topLeftX, topLeftY, (bottomRightX - topLeftX), (bottomRightY - topLeftY));
    } else if (ellipseSelected == true) {
      bottomRightX = setBoundary(mouseX, true);
      bottomRightY = setBoundary(mouseY, false);

      //draw temporary ellipse to see how the final one will look before the mouse is released
      fill(currentSelectedColour);
      ellipseMode(CORNER);
      noStroke();
      smooth();
      ellipse(topLeftX, topLeftY, (bottomRightX - topLeftX), (bottomRightY - topLeftY));
    } else if (lineSelected == true) {
      bottomRightX = setBoundary(mouseX, true);
      bottomRightY = setBoundary(mouseY, false);

      //draw temporary lines to see how the final one will look before the mouse is released
      stroke(currentSelectedColour);
      smooth();
      line(topLeftX, topLeftY, bottomRightX, bottomRightY);
    } else if (brushSelected == true) {
      shapes.add(new Rectangle(setBoundary(mouseX, true), setBoundary(mouseY, false), 20, 15, currentSelectedColour));
    } else if (eraserSelected == true) {       
      shapes.add(new Ellipse(setBoundary(mouseX, true), setBoundary(mouseY, false), 20, 20, 255));
    }
  }
}

// mouseReleased is a Processing inbuilt method which detects if the mouse is released after having being pressed/dragged
void mouseReleased() {
  if (drawing == true) {
    if (rectangleSelected == true) {  
      // add new Rectangle shape to the shapes ArrayList
      pressed = false;
      shapes.add(new Rectangle(topLeftX, topLeftY, (bottomRightX - topLeftX), (bottomRightY - topLeftY), currentSelectedColour));
    } else if (ellipseSelected == true) {      
      shapes.add(new Ellipse(topLeftX, topLeftY, (bottomRightX - topLeftX), (bottomRightY - topLeftY), currentSelectedColour));
    } else if (lineSelected == true) {      
      shapes.add(new Line(topLeftX, topLeftY, bottomRightX, bottomRightY, currentSelectedColour));
    } else if ((dropperSelected == true) && onColourPicker()) {
      currentSelectedColour = get(mouseX, mouseY);  // get the pixel at coordinate mouseX, mouseY
    }
  }
}

// mouseClicked is a Processing inbuilt method which detects if the mouse is pressed and released very quickly aka clicked
void mouseClicked() { 
  if (overNewButton()) {    
    selectInput("Select a image to trace:", "imageSelected");
  } else if (overRectButton()) {    
    drawing = false;
    rectangleSelected = true;
    ellipseSelected = false;
    lineSelected = false;
    brushSelected = false;
    eraserSelected = false;
    dropperSelected = false;
  } else if (overEllipseButton()) {    
    drawing = false;
    rectangleSelected = false;
    ellipseSelected = true;
    lineSelected = false;
    brushSelected = false;
    eraserSelected = false;
    dropperSelected = false;
  } else if (overLineButton()) {    
    drawing = false;
    rectangleSelected = false;
    ellipseSelected = false;
    lineSelected = true;
    brushSelected = false;
    eraserSelected = false;
    dropperSelected = false;
  } else if (overBrushButton()) {    
    drawing = false;
    rectangleSelected = false;
    ellipseSelected = false;
    lineSelected = false;
    brushSelected = true;
    eraserSelected = false;
    dropperSelected = false;
  } else if (overEraserButton()) {    
    drawing = false;
    rectangleSelected = false;
    ellipseSelected = false;
    lineSelected = false;
    brushSelected = false;
    eraserSelected = true;
    dropperSelected = false;
  } else if (overDropperButton()) {    
    drawing = true;
    rectangleSelected = false;
    ellipseSelected = false;
    lineSelected = false;
    brushSelected = false;
    eraserSelected = false;
    dropperSelected = true;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// Custom helper methods //

// checkButtonState method return the colour of the sidebar button the name of the button
color checkButtonState(String button) {
  if (button.equals("rectangle") == true) {  // if the button is a rectangle
    if (rectangleSelected == true) {  // if the rectangle button is clicked on 
      return buttonSelectedColour;  // the colour returned for the button is cyan
    } else {
      return buttonColour;  // otherwise the button colour is grey
    }
  } else if (button.equals("ellipse") == true) {
    if (ellipseSelected == true) {
      return buttonSelectedColour;
    } else {
      return buttonColour;
    }
  } else if (button.equals("line") == true) {
    if (lineSelected == true) {
      return buttonSelectedColour;
    } else {
      return buttonColour;
    }
  } else if (button.equals("brush") == true) {
    if (brushSelected == true) {
      return buttonSelectedColour;
    } else {
      return buttonColour;
    }
  } else if (button.equals("eraser") == true) {
    if (eraserSelected == true) {
      return buttonSelectedColour;
    } else {
      return buttonColour;
    }
  } else {  // otherwise the if the button name is a dropper
    if (dropperSelected == true) {
      return buttonSelectedColour;
    } else {
      return buttonColour;
    }
  }
}

// set boundary checks if the number is outside the width and height of the canvas so shapes aren't painted on the colour picker or sidebar
// isX tells the method if the width is being checked or the height.
float setBoundary(float number, boolean isX) {
  if (canvasTopLeftX > number && (isX == true)) {   // if the number IS outside the canvas, then make the number the canvas
    return canvasTopLeftX;
  } else if (canvasTopLeftY > number && (isX == false)) { 
    return canvasTopLeftY;
  } else if (canvasBottomRightX < number && (isX == true)) { 
    return canvasBottomRightX;
  } else if (canvasBottomRightY < number && (isX == false)) { 
    return canvasBottomRightY;
  }
  return number;
}

// imageSelected method checks the validity of the file selected and if its an image that can be opened
void imageSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else { // otherwise load the image form the file selected  
    String extension = (selection.getAbsolutePath()).substring((selection.getAbsolutePath()).length()-4, (selection.getAbsolutePath()).length());
    if (!(extension.equals(".JPG")) && !(extension.equals(".jpg")) && !(extension.equals(".PNG")) && !(extension.equals(".png"))) {
      println("Not an image! Please select a JPG or PNG!");
    } else {
      tracingImage = loadImage(selection.getAbsolutePath());  //new picture to trace
      shapes.clear();  // clear the canvas of all the shapes
    }
    println("User selected " + selection.getAbsolutePath());
  }
}


// the on___ methods are to ckeck whether or not the mosue is within the parameter of the ___ button or canvas
boolean onColourPicker() {
  if ((mouseX >= 115 && mouseX <= 1000 && 
    mouseY >= 580 && mouseY <= 700)) {
    return true;
  }
  return false;
}

boolean overNewButton() {
  if (mouseX >= buttonLeftX && mouseX <= buttonRightX && 
    mouseY >= newButtonTopY && mouseY <= newButtonBottomY) {    
    return true;
  } else {
    return false;
  }
}

boolean overRectButton() {
  if (mouseX >= buttonLeftX && mouseX <= buttonRightX && 
    mouseY >= rectButtonTopY && mouseY <= rectButtonBottomY) {        
    return true;
  } else {
    return false;
  }
}

boolean overEllipseButton() {  
  if (mouseX >= buttonLeftX && mouseX <= buttonRightX && 
    mouseY >= ellipseButtonTopY && mouseY <= ellipseButtonBottomY) {  
    return true;
  } else {
    return false;
  }
}

boolean overLineButton() {
  if (mouseX >= buttonLeftX && mouseX <= buttonRightX && 
    mouseY >= lineButtonTopY && mouseY <= lineButtonBottomY) {    
    return true;
  } else {
    return false;
  }
}

boolean overBrushButton() {
  if (mouseX >= buttonLeftX && mouseX <= buttonRightX && 
    mouseY >= brushButtonTopY && mouseY <= brushButtonBottomY) {    
    return true;
  } else {
    return false;
  }
}

boolean overEraserButton() {
  if (mouseX >= buttonLeftX && mouseX <= buttonRightX && 
    mouseY >= eraserButtonTopY && mouseY <= eraserButtonBottomY) {    
    return true;
  } else {
    return false;
  }
}

boolean overDropperButton() {
  if (mouseX >= buttonLeftX && mouseX <= buttonRightX && 
    mouseY >= dropperButtonTopY && mouseY <= dropperButtonBottomY) { 
    return true;
  } else {
    return false;
  }
}

boolean overCanvas() {
  if (mouseX >= 115 && mouseX <= 1000 && 
    mouseY >= 0 && mouseY <= 580) {
    return true;
  } else {
    return false;
  }
}
