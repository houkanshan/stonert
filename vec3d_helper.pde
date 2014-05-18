static class Vec3DHelper {

  static Vec3D rotate3D(Vec3D v, Vec3D angle3D) {
    v.rotateX(angle3D.x);
    v.rotateY(angle3D.y);
    v.rotateZ(angle3D.z);
    return v;
  }

  static Vec3D normalVector(Vec3D l1, Vec3D l2) {
    return l1.cross(l2).normalize();
  }

  static Vec3D getAngle3D(Vec3D a, Vec3D b) {
    a = a.normalize();
    b = b.normalize();
    Vec3D aproj;
    Vec3D bproj;
    Vec3D normalV;
    int direction;


    aproj = new Vec3D(0, a.y, a.z);
    bproj = new Vec3D(0, b.y, b.z);
    normalV = aproj.cross(bproj);
    direction = normalV.x >= 0 ? 1 : -1;
    float angleX = aproj.angleBetween(bproj) * direction;

    aproj = new Vec3D(a.x, 0, a.z);
    bproj = new Vec3D(b.x, 0, b.z);
    normalV = aproj.cross(bproj);
    direction = normalV.y >= 0 ? 1 : -1;
    float angleY = aproj.angleBetween(bproj) * direction;

    aproj = new Vec3D(a.x, a.y, 0);
    bproj = new Vec3D(b.x, b.y, 0);
    normalV = aproj.cross(bproj);
    direction = normalV.z >= 0 ? 1 : -1;
    float angleZ = aproj.angleBetween(bproj) * direction;

    return new Vec3D(angleX, angleY, angleZ);
  }

  static float[][] getRotationMatrix(Vec3D a, Vec3D b) {
    a = a.normalize();
    b = b.normalize();

    float[][] rotatedMatrix = new float[3][3];
    Vec3D axis = b.cross(a).normalize();
    float angle = a.angleBetween(b);

    rotatedMatrix[0][0] = cos(angle) + axis.x * axis.x * (1 - cos(angle));
    rotatedMatrix[0][1] = axis.x * axis.y * (1 - cos(angle) - axis.z * sin(angle));
    rotatedMatrix[0][2] = axis.y * sin(angle) + axis.x * axis.z * (1 - cos(angle));

    rotatedMatrix[1][0] = axis.z * sin(angle) + axis.x * axis.y * (1 - cos(angle));
    rotatedMatrix[1][1] = cos(angle) + axis.y * axis.y * (1 - cos(angle));
    rotatedMatrix[1][2] = -axis.x * sin(angle) + axis.y * axis.z * (1 - cos(angle));
      
    rotatedMatrix[2][0] = -axis.y * sin(angle) + axis.x * axis.z * (1 - cos(angle));
    rotatedMatrix[2][1] = axis.x * sin(angle) + axis.y * axis.z * (1 - cos(angle));
    rotatedMatrix[2][2] = cos(angle) + axis.z * axis.z * (1 - cos(angle));
    return rotatedMatrix;
  }

  static Vec3D getApplyMatrix(Vec3D a, float[][] matrix) {
    return new Vec3D(
          a.x * matrix[0][0] + a.y * matrix[1][0] + a.z * matrix[2][0]
        , a.x * matrix[0][1] + a.y * matrix[1][1] + a.z * matrix[2][1]
        , a.x * matrix[0][2] + a.y * matrix[1][2] + a.z * matrix[2][2]
        );
  }

  static void applyMatrix(Vec3D a, float[][] matrix) {
    float x = a.x * matrix[0][0] + a.y * matrix[1][0] + a.z * matrix[2][0];
    float y = a.x * matrix[0][1] + a.y * matrix[1][1] + a.z * matrix[2][1];
    float z = a.x * matrix[0][2] + a.y * matrix[1][2] + a.z * matrix[2][2];

    a.x = x;
    a.y = y;
    a.z = z;
  }

  static float getRotationAngle(Vec3D from, Vec3D to) {
    return asin((from.cross(to).x / from.magnitude() / to.magnitude()) / from.cross(to).normalize().x);
  }
}

void lineV(Vec3D v) {
  line(0, 0, 0, v.x, v.y, v.z);
}


// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

void renderImage(PImage img, Vec3D _loc, float _diam, color _col, float _alpha ) {
  pushMatrix();
  translate( _loc.x, _loc.y, _loc.z );
  tint(red(_col), green(_col), blue(_col), _alpha);
  imageMode(CENTER);
  image(img,0,0,_diam,_diam);
  popMatrix();
}

