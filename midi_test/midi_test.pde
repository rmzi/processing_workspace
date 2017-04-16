import themidibus.*;
import processing.sound.*;

// Keep Track of Knob Values
float knob[] = new float[256];
float knob_color[] = new float[256];

// X & Y Positions
float x = width/2;
float y = height/2;

// X & Y Velocities
float xSpeed = 1;
float ySpeed = 1;

// Bounds on X and Y, and bounding the circleSizes.
float boundX, boundY, circleSizeX, circleSizeY;

// Midi Info
MidiBus myBus;
int channel, number,value;

// Sine Wave Oscillators
SinOsc[] sineWaves;
float[] sineFreq;
int numSines = 5;

// Oscillator Parameters
float frequency;
float detune;

void setup(){
  
  // Screen Setup
  size(750,1000);
  //fullScreen();
  background(105);
  
  // Initialize Midi
  myBus = new MidiBus(this, 0, 1);
  
  // Initialize Bounds
  boundX = 1;
  boundY = 1;
  
  // Sine Wave Instantiation
  sineWaves = new SinOsc[numSines];
  sineFreq = new float[numSines];
  
  for (int i = 0; i < numSines; i++) {
    // Calculate the amplitude for each oscillator
    float sineVolume = (1.0 / numSines) / (i + 1);
    // Create the oscillators
    sineWaves[i] = new SinOsc(this);
    // Start Oscillators
    sineWaves[i].play();
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);
  }
}
void draw(){

  // Update x position
  //x = x + xSpeed * this.knob[1];
  x = width * 2 * (float)Math.random();
  //println("x: ", x);

  // Update y position
  //y = y + ySpeed * this.knob[2];
  y = height * (float)Math.random(); 
  //println("y: ", y);

  //no stroke on shapes
  //noStroke();

  // Color the Circles
  fill(this.knob_color[3],this.knob_color[4],this.knob_color[5]);

  //control shape stroke
  if(this.knob[43]== 1){
    noStroke();
  }

  // Fill the page with shapes!

  for(int i = 0; i < knob[6]; i++){
    ellipse((x * (float)Math.random()),(y * (float)Math.random()),(float)Math.random() * knob[7] * 100,(float)Math.random() * knob[7] * 100);
  }

  fill(this.knob_color[21],this.knob_color[22],this.knob_color[23]);

  // Fill the page with shapes!

  for(int i = 0; i < knob[24]; i++){
    //ellipse((x * (float)Math.random()),(y * (float)Math.random()),(float)Math.random() * knob[7] * 100,(float)Math.random() * knob[7] * 100);
    rect((x * (float)Math.random()),(y * (float)Math.random()),(float)Math.random() * knob[25] * 100,(float)Math.random() * knob[26] * 100);
  }

  // "Bounce" Logic
  if (x > (width-boundX) || x < boundX){
    xSpeed = xSpeed *-1;
  }

  if (y > (height-boundY) || y < boundY) {
    ySpeed = ySpeed * -1;
  }

  // clear the board
  if(this.knob[42] == 1){
    background(105);
  }

  // Sound Stuff
  frequency = pow(1000,knob[5]) + 150;
  detune = map(knob[22], 0, 1, -0.5, 0.5);
  
  for (int i = 0; i < numSines; i++) { 
    sineFreq[i] = frequency * (float)Math.random() * (i + 1 * detune);
    // Set the frequencies for all oscillators
    sineWaves[i].freq(sineFreq[i]);
  }
}

void controllerChange(int channel, int number, int value){
  this.channel = channel;
  this.number = number;
  this.value = value;

  println("channel: ", channel);
  println("number: ", number);
  println("value: ", value);

  this.knob[number] = map(value, 0, 127, 0,1);
  this.knob_color[number] = map(value, 0, 127, 0, 255);
}