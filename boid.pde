// Rewrite to 3D version from:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


class Boid {
  Vec3D loc = new Vec3D(0, 0, 0);
  Vec3D vel = new Vec3D(0, 0, 0);
  Vec3D acc = new Vec3D(0, 0, 0);
  Stone body;

  Boid(float x, float y, float z) {
    body = new Stone();

    acc = new Vec3D(0, 0, 0);
    vel = new Vec3D(random(0.5,1), random(-1,1), random(-2,2));
    loc = new Vec3D(x, y, z);
  }

  void run(CopyOnWriteArrayList<Boid> boids) {
    update();
    render();
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(CopyOnWriteArrayList<Boid> boids) {
  }

  void update() {
    body.update();
  }

  void render() {
    stroke(red);
    line(center.x, center.y, center.z,
        loc.x, loc.y, loc.z);
    pushMatrix();

    translate(loc.x, loc.y, loc.z);
    body.render();

    popMatrix();
  }
}
