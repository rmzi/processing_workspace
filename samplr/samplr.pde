import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

/**
*
*  Samplr
*  Author: Ramzi Abdoch
*  Date: 2/4/2017
*
* / 

void setup() {
  size(512, 200, P3D);
  
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  player = minim.loadFile("this_is_how_we_do_it.mp3");
}

void draw() {
  
}

void keyPressed() {
  
}

void startSammple(sample) {
  
}