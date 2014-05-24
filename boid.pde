// Rewrite to 3D version from:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


class Boid {
  Vec3D loc = new Vec3D(0, 0, 0);
  Vec3D vel = new Vec3D(0, 0, 0);
  Vec3D acc = new Vec3D(0, 0, 0);
  float origR;
  float freqAmp;
  Stone body;

  Boid(float x, float y, float z) {
    body = new Stone();

    initialize(x, y, z);
  }

  Boid(float x, float y, float z, Stone _body) {
    body = _body;

    initialize(x, y, z);
  }

  void initialize(float x, float y, float z) {
    acc = new Vec3D(0, 0, 0);
    vel = new Vec3D(random(0.5,1), random(-1,1), random(-2,2));
    loc = new Vec3D(x, y, z);

    origR = loc.magnitude();
  }

  void run(CopyOnWriteArrayList<Boid> boids) {
    update();
    render();
  }

  void update() {
    //locJitter();
    body.update();
  }

  void locJitter() {
    float locByAmp = 100 * log(freqAmp + 1);
    if (locByAmp > origR) {
      loc.normalizeTo(locByAmp);
    } else {
      loc.normalizeTo(origR);
    }
  }

  void render() {
    pushMatrix();

    translate(loc.x + center.x, loc.y + center.y, loc.z + center.z);
    if (debug) {
      stroke(red);
      lineV(loc, new Vec3D());
    }
    body.render();

    popMatrix();
  }
}
