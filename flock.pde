import java.util.concurrent.CopyOnWriteArrayList;

class Flock {
  CopyOnWriteArrayList<Boid> boids; // An ArrayList for all the boids
  float maxAngVel = radians(0.3);
  Vec3D angVel = Vec3D.randomVector().normalizeTo(maxAngVel);
  Vec3D angAcc = Vec3D.randomVector().normalizeTo(radians(0.01));
  Boolean speedLimit = true;
  float pushSpeed = 0;
  float r = 150;
  float density = 0.0005;
  float count = int(2 * PI * r * r * density);
  float locJitter = 60;
  Stone s;

  Flock() {
    boids = new CopyOnWriteArrayList<Boid>();
    createSphere();
    s = new Stone();
    println(angAcc, angVel);
  }

  void run() {
    update();
    render();
    for (Boid b : boids) {
      b.run(boids);
    }
  }

  void update() {
    rotate3D();
  }

  void render() {
  }
  
  void createSphere() {
    for (int i = 0; i < count; i++) {
      addBoidRandomInSphere();
    }
  }

  void rotate3D() {
    for(Boid b: boids) {
      Vec3DHelper.rotate3D(angVel, angAcc).normalizeTo(maxAngVel);
      Vec3DHelper.rotate3D(b.loc, angVel, center);
    }
  }

  void addBoidRandomInSphere() {
    Vec3D v = Vec3D.randomVector().normalizeTo(r);
    Vec3D loc = v.add(center).jitter(locJitter);
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
