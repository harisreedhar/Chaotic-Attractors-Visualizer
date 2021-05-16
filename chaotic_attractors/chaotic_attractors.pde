// Simple visualization of chaotic attractors
// Author: Harisreedhar
// References:
// https://youtu.be/f0lkz2gSsIk (Lorenz attractor by Daniel Shiffman)
// http://www.3d-meier.de/ (Attractor math and equations)

import peasy.*;
import controlP5.*;

PeasyCam cam;
ControlP5 cp5;

int frameCount = 0;
int buttonValue = 1;

void setup() {
  frameRate(30);
  size(800, 600, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 100);
  cp5 = new ControlP5(this);
  cp5.addButton("Lorenz", 10, 20, 20, 80, 20).setId(1);
  cp5.addButton("Rossler", 4, 110, 20, 80, 20).setId(2);
  cp5.addButton("Aizawa", 4, 200, 20, 80, 20).setId(3);
  //cp5.addSlider("param_A").setPosition(20, 60).setRange(-100, 100).setValue(10);
  //cp5.addSlider("param_B").setPosition(20, 90).setRange(-100, 100).setValue(28);
  //cp5.addSlider("param_C").setPosition(20, 120).setRange(-100, 100).setValue(2.6667);
  cp5.setAutoDraw(false);
}
void draw() {
  background(0);
  frameCount += 1;
  //float a = cp5.getController("param_A").getValue();
  //float b = cp5.getController("param_B").getValue();
  //float c = cp5.getController("param_C").getValue();
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  if(buttonValue == 1) {
    Lorenz attractor =  new Lorenz(0.1, 0, 0.1, 10, 28, 2.6667, frameCount * 5);
    attractor.generate();
    points = attractor.points;
  }
  
  if(buttonValue == 2) {
    Rossler attractor =  new Rossler(0.1, 0, 0.1, 0.2, 0.2, 5.7, frameCount * 5);
    attractor.generate();
    attractor.scalePoints(3);
    points = attractor.points;
  }
  
  if(buttonValue == 3) {
    Aizawa attractor = new Aizawa(0.1, 0, 0, 0.95, 0.7, 0.6, 3.5, 0.25, 0.1, frameCount * 7);
    attractor.generate();
    attractor.scalePoints(14);
    points = attractor.points;
  }
  
  translate(0, 0, -80);
  scale(2);
  stroke(255);
  noFill();
  float hue = 0;
  beginShape();
  for (PVector v : points) {
    stroke(hue, 255, 255);
    vertex(v.x, v.y,v.z);
    hue += 0.1;
    if (hue > 255) {
        hue = 0;
    }
  }
  endShape();
 
  gui();
}

void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void controlEvent(ControlEvent theEvent) {
  /*
  if (theEvent.isController()) { 
    if (theEvent.getController().getName()=="param_A") {
      println(theEvent.getController().getValue());
      println(cp5.getController("param_A").getValue());
    } 
  }  */
  buttonValue = theEvent.getController().getId();
  frameCount = 0;
  //cp5.getController("sides").setValue(11);
}

void button(float theValue) {
  println("a button event. "+theValue);
}

void mousePressed(){
  if (mouseX > 10 && mouseX < 220 && mouseY > 10 && mouseY < 30) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}
