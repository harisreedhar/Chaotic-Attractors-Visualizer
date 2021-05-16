// Simple visualization of chaotic attractors
// Author: Harisreedhar
// References:
// https://youtu.be/f0lkz2gSsIk (Lorenz attractor by Daniel Shiffman)
// http://www.3d-meier.de/ (Attractor math and equations)

////////////////////////////////////////////////////////// Attractor Code Begin //////////////////////////////////////////////////////////

class AttractorBase {
  int iterations;
  float x, y, z;
  float dt = 0.01;
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  void attractorFunction() {}
  
  void generate() {
    for (int i = 0; i < iterations; i++) {
      attractorFunction();
      points.add(new PVector(x, y, z));
    }
  }
  
  void scalePoints(float scale) {
    for (PVector v : points) {
      v.x *= scale;
      v.y *= scale;
      v.z *= scale;
    }
  }  
}

class Lorenz extends AttractorBase {
  float a, b, c;
  
  Lorenz(float _x, float _y, float _z, float _a, float _b, float _c, int _iterations) {
    x = _x;
    y = _y;
    z = _z;
    a = _a;
    b = _b;
    c = _c;
    iterations = _iterations;
  }
  
  void attractorFunction() {
    x += (a * (y - x)) * dt;
    y += (x * (b - z) - y) * dt;
    z += (x * y - c * z) * dt;
  }    
}

class Rossler extends AttractorBase {
  float a, b, c;
  
  Rossler(float _x, float _y, float _z, float _a, float _b, float _c, int _iterations) {
    x = _x;
    y = _y;
    z = _z;
    a = _a;
    b = _b;
    c = _c;
    iterations = _iterations;
    dt = 0.05;
  }
  
  void attractorFunction() {
    x += -(y + z) * dt;
    y += (x + a * y) * dt;
    z += (b + z * (x - c)) * dt;
  }    
}

class Aizawa extends AttractorBase {
  float a, b, c, d, e, f;
  
  Aizawa(float _x, float _y, float _z, float _a, float _b, float _c, float _d, float _e, float _f, int _iterations) {
    x = _x;
    y = _y;
    z = _z;
    a = _a;
    b = _b;
    c = _c;
    d = _d;
    e = _e;
    f = _f;
    iterations = _iterations;
    dt = 0.01;
  }
  
  void attractorFunction() {
    x += ((z - b) * x - d * y) * dt;
    y += (d * x + (z - b) * y) * dt;
    z += (c + a * z - ((z * z * z) / 3) - (x * x + y * y) * (1 + e * z) + f * z * x * x * x) * dt;
  }    
}

////////////////////////////////////////////////////////// Attractor Code End ///////////////////////////////////////////////////////////

import peasy.*;

PeasyCam cam;

int count = 0;

void setup() {
  frameRate(30);
  size(800, 600, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  count += 1;
  
  float scale = 1;
  
  //Lorenz attractor =  new Lorenz(0.1, 0, 0.1, 10, 28, 2.6667, count);
  //Rossler attractor =  new Rossler(0.1, 0, 0.1, 0.2, 0.2, 5.7, count * 5);
  Aizawa attractor = new Aizawa(0.1, 0, 0, 0.95, 0.7, 0.6, 3.5, 0.25, 0.1, count * 5);
  scale = 20;
  
  attractor.generate();
  attractor.scalePoints(scale);
  ArrayList<PVector> points = attractor.points;

  translate(0, 0, -80);
  scale(5);
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

}
