import java.util.concurrent.CopyOnWriteArrayList;

class Flock {
  CopyOnWriteArrayList<Boid> boids; // An ArrayList for all the boids
  float maxAngVel = radians(0.4);
  Vec3D angVel = Vec3D.randomVector().normalizeTo(maxAngVel);
  Vec3D angAcc = Vec3D.randomVector().normalizeTo(radians(0.01));
  Boolean speedLimit = true;
  float pushSpeed = 0;
  float r = 150;
  //float density = 0.001;
  //float count = int(2 * PI * r * r * density);
  // just use count.
  float count = 100;
  float maxStoneSize = 100;
  float minStoneSize = 10;
  float locJitter = 60;

  Flock() {
    boids = new CopyOnWriteArrayList<Boid>();
    createSphere();
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
    float step = exp(maxStoneSize/10) / count;
    for (int i = 0; i < count; i++) {
      float avgSize = 10 * log((i + 1) * step);
      addBoidRandomInSphere(min(minStoneSize, avgSize - 10), avgSize + 10);
    }
  }

  void rotate3D() {
    for(Boid b: boids) {
      Vec3DHelper.rotate3D(angVel, angAcc).normalizeTo(maxAngVel);
      Vec3DHelper.rotate3D(b.loc, angVel);
    }
  }

  void addBoidRandomInSphere(float start, float end) {
    Stone body = new Stone(random(start, end));

    Vec3D v = Vec3D.randomVector().normalizeTo(r);
    Vec3D loc = v.jitter(locJitter);
    Boid b = new Boid(loc.x, loc.y, loc.z, body);

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
