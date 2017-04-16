  
import processing.sound.*;
Amplitude amp;
AudioIn in;

float min, max;
float x;
float how_wiggly;

void setup() {
  size(640, 360);
  //fullScreen();
  colorMode(HSB);
  noStroke();
  background(0,0,100);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  
  max = 0;
  min = 0;
  x = 0;
  how_wiggly = 255;
}      

void draw() {  
  println(amp.analyze());
  x++;
  x = x % width;
  
  if(x == 0){
    background(0,0,100);
  }
  
  float value = amp.analyze();
  
  if(value == Float.NaN) {
    value = 0; 
  }
    
  if(value < min) {
    min = value;
  }
  
  if(value > max) {
    max = value; 
  }
   
  float y = map(value, min, max, 0, height);
  y = height - y;
   
  for(int i = 0; i < 200; i++){
    // Calc wiggle room
    float wiggle = (float)Math.random() * how_wiggly;
  
    // Make it colorful
    float hue = map(value, min, max, 0, 360);
    float saturation = 100;
    float brightness = 100;
    
    //fill((wiggle * (float)Math.random()) % 255,(wiggle * (float)Math.random()) % 255,(wiggle * (float)Math.random()) % 255);
    fill(hue, saturation, brightness);
  
    // Draw the ellipses a bit offset
    ellipse(x,y,10,10);
    //point(x,y);
  }
}