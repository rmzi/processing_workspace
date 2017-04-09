import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
int channel, number, value, where_we_at;

void setup() {
  fullScreen();
  //size(500,500);
  background(255);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

  // or for testing you could ...
  //                 Parent  In        Out
  //                   |     |          |
  //myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  myBus = new MidiBus(this, 0, 1);
}

void draw() {

  this.where_we_at++;
  this.where_we_at = this.where_we_at % 1500;
  
  // Debug
  text(this.channel,this.where_we_at, (this.where_we_at * (this.value) * 2) % 1000);
  text(this.number,this.where_we_at, (this.where_we_at * (this.value + 10) * 2) % 1000);
  text(this.value,this.where_we_at, (this.where_we_at * (this.value + 20) * 6) % 1000);
  text("Spaghet",this.where_we_at, (this.where_we_at * (this.value + 30) * 3) % 1000);

  // Draw Rectangle
  fill((this.number + this.value * 1.5) % 255, (this.value * 0.6), this.channel + this.value);
  //rect((this.value * this.number * 2) % 1000, ((this.value * this.number) * 3) % 1000 , (this.value * this.number * 2) % 1000, this.value);

  // Draw 8 Rectangles indicating location of slider
  
  
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  this.channel = channel;
  this.number = number;
  this.value = value;
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}