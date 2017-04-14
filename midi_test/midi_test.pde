import themidibus.*;

float knob[] = new float[256];
float knob_color[] = new float[256];
float x = width/2;
float y = height/2;
float xSpeed = 1;
float ySpeed = 1;
float boundX, boundY, circleSizeX, circleSizeY;
MidiBus myBus;
int channel, number,value;

void setup(){
  size(750,1000);
  //fullScreen();
  background(105);
  myBus = new MidiBus(this, 0, 1);
  boundX = 1;
  boundY = 1;
}
void draw(){

  // Update x position
  x = x + xSpeed * this.knob[1];
  //println("x: ", x);

  // Update y position
  y = y + ySpeed * this.knob[2];
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
    print("WE AT IT AGAIN!");
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
