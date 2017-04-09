// Daily Sketch
// 2/14/17

// Objective:
//  - Use velocity from Cat class to send "streaks" of paw prints across the screen.

// Page Properties
PGraphics canvas;

Cat luzi;
PImage pprint;

// Constants
int Y_AXIS = 1;
int X_AXIS = 2;
//color b1, b2; 
color c1, c2;

void setup() {
  
  
  
  // window setup
  size(1000,1000);
  surface.setResizable(true);
  
  // colors
  colorMode( RGB, width, height, height );
  c1 = (255);
  c2 = (209);
  
  // initialize Cat
  luzi = new Cat(0,0,10);
  
  // load paw_print
  pprint = loadImage("paw_print.png");
}

void draw() {
  // Draw gradient in the background
  setGradient(0,0,width,height,c1,c2,Y_AXIS);
  
  // Show pmouse and mouse points
  fill(0);
  ellipse(pmouseX,pmouseY,10,10);
  fill(255);
  ellipse(mouseX,mouseY,10,10);
  
  // The Cat follows the Mouse 
  luzi.update(new PVector(mouseX,mouseY));
  
  // Show velocity
  stroke(0,255,0);
  line(mouseX, mouseY, mouseX + luzi.velocity.x * luzi.vector_len, mouseY + luzi.velocity.y * luzi.vector_len);
}

// The Cat follows the Mouse
class Cat {
  PVector velocity, accel, curr_point, prev_point;
  int vector_len;
   
  Cat(int x, int y, int vl) {
    curr_point = new PVector(x,y); 
    vector_len = vl;
  }
  
  void update(PVector point){
    
    // Update prev_point
    prev_point = curr_point;
    
    // Copy new point into curr_point
    curr_point = new PVector(point.x, point.y);
    velocity = new PVector(point.x, point.y);
    
    // Calculate velocity
    velocity.sub(prev_point);
  }
  
  void shootSteps() {
      
  }
}

// Creating Gradients
void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}