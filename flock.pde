import java.util.concurrent.CopyOnWriteArrayList;

class Flock {
  CopyOnWriteArrayList<Boid> boids; // An ArrayList for all the boids
  Boolean speedLimit = true;
  float pushSpeed = 0;
  float r = 150;
  float density = 0.0005;
  float count = int(2 * PI * r * r * density);
  //float count = 1;
  Stone s;

  Flock() {
    // Test TODO
    Vec3D a = new Vec3D(1, 1, 1);
    Vec3D b = a.getRotatedY(radians(45));
    b.rotateX(radians(45));
    b.rotateY(radians(160));

    println("==");
    println(a);
    println(b);
    Vec3D axis = Vec3DHelper.normalVector(a, b);
    float angle = a.normalize().angleBetween(b.normalize());
    println(degrees(angle));
    a.rotateAroundAxis(axis, angle);

    println(a.x/b.x, a.y/b.y, a.z/b.z);
    println("==");

    boids = new CopyOnWriteArrayList<Boid>();
    createSphere();
    s = new Stone();
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);
    }

    //Vec3D mouse = new Vec3D(mouseX - center.x, mouseY - center.y, 10);
    //pushMatrix();
    //translate(center.x, center.y, center.z);
    //stroke(red);
    //line(0, 0, 0, mouse.x, mouse.y, mouse.z);
    //s.rotateTo(mouse);
    //s.render();
    //popMatrix();
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
    //body.rotate3D(Vec3DHelper.getAngle3D(body.getPointVec(), v));
    //float[][] rotationMatrix = Vec3DHelper.getRotationMatrix(body.getPointVec(), v);
    //Debugger.printMatrix(rotationMatrix);
    //body.applyMatrix(rotationMatrix);
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
