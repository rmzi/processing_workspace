// Daily Sketch
// 2/5/17

// Page Properties
int width=1000;
int height=1000;
Cat kitty;

void setup() {
  // colors
  colorMode( RGB, width, height, height );
  size(1000,1000);
  surface.setResizable(true);
  
  // initialize Cat
  kitty = new Cat(0,0,10);
}

void draw() {
  
  // Change BG w/ Mouse Movement
  background(mouseX,mouseY,(mouseY * 3) % 255);
    
  // Show pmouse and mouse points
  fill(0);
  ellipse(pmouseX,pmouseY,10,10);
  fill(255);
  ellipse(mouseX,mouseY,10,10);

  // The Cat follows the Mouse 
  kitty.update(new PVector(mouseX,mouseY));
 
  // Show velocity
  stroke(0,255,0);
  line(mouseX, mouseY, mouseX + kitty.velocity.x * kitty.vector_len, mouseY + kitty.velocity.y * kitty.vector_len);
}

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
}