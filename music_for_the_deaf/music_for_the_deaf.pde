import themidibus.*;

// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

MidiBus myBus; // The MidiBus

float knob[], note[];
Note currentNote;
String[] noteNames;

PFont f;

boolean debugMode = true;
int lastVelocity;

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).
Minim minim;
AudioOutput out;
Oscil wave;
Oscil fm;

// keep track of the current Frequency so we can display it
Frequency  currentFreq;

void setup() {
  size(900, 700);
  //fullScreen();
  background(0,0,100);
  colorMode(HSB, 100);

  // Store Midi Values from Novation Midi Controller
  knob = new float[8];
  note = new float[127];
  noteNames = new String[127];
  lastVelocity = 0; 
  
  knob[0] = 0;
  knob[1] = 0;
  knob[2] = 0;

  // Initialize MidiBus
  myBus = new MidiBus(this, 0, 1); 
  
  // Configure Font
  f = createFont("Arial",16,true);
  
  // initialize the minim and out objects
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO, 2048);
  currentFreq = Frequency.ofPitch("A4");
  wave = new Oscil(currentFreq, 0.6f, Waves.SQUARE);
  
  // WAVY MODE
  //fm = new Oscil(10,2, Waves.SINE);
  //fm.offset.setLastValue(200);
  //fm.patch(wave.frequency);
}

void draw() {
  
  // Clear BG
  background(map(knob[0], 0, 127, 0, 100), map(knob[1], 0, 127, 0, 100), map(lastVelocity, 0, 127, 0, 100));
  
  // DEBUG
  if(debugMode) {
    
    // Draw the knob locations
    fill(100,100,100);
    for(int i = 0; i < knob.length; i++){
      rect(i * 10, knob[i], 10, 10);
    }
    
    // Draw the Frequency
    // draw using a beige stroke
    stroke( 255, 238, 192 );
    
    text( "Current Frequency in Hertz: " + currentFreq.asHz(), 5, 200 );
    text( "Current Frequency as MIDI note: " + currentFreq.asMidiNote(), 5, 215);
    
    // draw the waveforms
    for( int i = 0; i < out.bufferSize() - 1; i++ )
    {
      // find the x position of each buffer value
      float x1  =  map(i, 0, out.bufferSize(), 0, width);
      float x2  =  map(i+1, 0, out.bufferSize(), 0, width);
      
      // draw a line from one buffer position to the next for both channels
      line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
      line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
    }  
  }
  
  //Draw the note locations
    for(int i = 0; i < note.length; i++){
      float x = map(i, 0, 127, 0, width);
      float y = height - map(note[i], 0, 127, 0, height);
      float hue = map(note[i], 0, 127, 0, 100);
      
      fill(hue,100,100);
      ellipse(x, y, 60, 60);
      
      int textOffsetX = 9;
      int textOffsetY = 9;
      
      // Draw Note names
      fill(0,0,100);
      textFont(f,24);
      if(noteNames[i] == null) {
        // No note played yet.
        // TODO: fill in notes
      } else {
        if(noteNames[i].length() > 1){
          textOffsetX += 3;
        }
        text(noteNames[i], map(i, 0, 127, 0, width) - textOffsetX, height - map(note[i], 0, 127, 0, height) + textOffsetY); 
      }
    }
}

void noteOn(Note midiNote) {  
  
  if(midiNote.channel() == 9){
    debugMode = !debugMode;
  } else {
    // Turn on the note
    wave.patch(out);
    
    currentNote = midiNote;
    currentFreq = Frequency.ofMidiNote(midiNote.pitch());
    wave.setFrequency(currentFreq);
    lastVelocity = currentNote.velocity();
    
    note[midiNote.pitch] = midiNote.velocity();
    noteNames[midiNote.pitch] = midiNote.name();
    printDebug("Changed note[" + (midiNote.pitch() - 21) + "] to velocity " + midiNote.velocity(), true);
  }
}

void noteOff(Note midiNote) {  
  
  if(midiNote.channel() == 9){
    // Send Midi back to controller to change color notifying debug mode
    printDebug("Turning off Debug Mode", true);
  } else {
    
    // Turn off the note
    wave.unpatch(out);
    
    // Send note back to zero & empty out currentNote
    note[midiNote.pitch()] = 0;
    currentNote = null;
    
  }
}

void controllerChange(ControlChange change) {
  // Set knob values
  knob[change.number() - 21] = change.value();
  printDebug("Changed knob[" + (change.number() - 21) + "] to " + change.value(), true);
  
  // Modulate Wave
  float modulateAmount = map(knob[3], 0, 127, 220, 1);
  float modulateFrequency = map(knob[4], 0, 127, 0.1, 100);
  fm.setFrequency(modulateFrequency);
  fm.setAmplitude(modulateAmount);
  
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void printDebug(String message, boolean extraLine){
   if(debugMode) {
     if(extraLine){
       println(); 
     }
     println(message); 
   }
}