import java.util.concurrent.CopyOnWriteArrayList;

class Flock {
  CopyOnWriteArrayList<Boid> boids; // An ArrayList for all the boids
  Boolean speedLimit = true;
  float pushSpeed = 0;
  float r = 150;
  float density = 0.0005;
  float count = int(2 * PI * r * r * density);
  Stone s;

  Flock() {
    boids = new CopyOnWriteArrayList<Boid>();
    createSphere();
    s = new Stone();
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);
    }
  }
  
  void createSphere() {
    for (int i = 0; i < count; i++) {
      addBoidRandomInSphere();
    }
  }

  void addBoidRandomInSphere() {
    Vec3D v = Vec3D.randomVector().normalizeTo(r);
    Vec3D loc = v.add(center);
    Boid b = new Boid(loc.x, loc.y, loc.z);

    Stone body = b.body;
    body.rotateTo(v);
    addBoid(b);
  }

  void forceSpeed(float speed) {
    speedLimit = false;
    pushSpeed = speed;
  }

  void stopSpeedForce() {
    speedLimit = true;
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
}
