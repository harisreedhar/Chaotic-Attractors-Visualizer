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
