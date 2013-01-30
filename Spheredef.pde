//Sphere Class
class Spheredef {
  PVector sphereCenter, sphereColor, rotation, velocity, acceleration;
  color fillColor, strokeColor;
  int red, green, blue, sphereRadius;
  float topSpeed=10;
  //float vi_x;
  //float a_x;


  //Constructor
  Spheredef(int x_, int y_, int z_, int vel_x, int vel_y, int vel_z, float accel_x, float accel_y, float accel_z, int rot_x, int rot_y, int rot_z) {
    sphereRadius=int(random(200));
    fillColor=strokeColor=color(random(255), random(255), random(255));
    sphereCenter= new PVector(x_, y_, z_);
    rotation= new PVector(rot_x, rot_y, rot_z);
    velocity = new PVector(vel_x, vel_y, vel_z);
    acceleration = new PVector(accel_x, accel_y, accel_z);
  }
  void go() {
    update_rotation();
    movement();
    checkBoundaries();
    display();
  }

  //Update location coordinate
  //Generates movement of sphere based on accel and vel
  void movement() {
    velocity.limit(topSpeed);
    velocity.add(acceleration);
    sphereCenter.add(velocity);
    //sphereCenter.x=v_i.x*t+0.5*a.x*pow(t,2); Time function does not work here the same
  }

  void update_rotation() {
    rotation.x = frameCount;
    rotation.y=frameCount;
    rotation.z=0;
  }

  // Draws Sphere
  void display() {
    //Save copy of current world
    pushMatrix(); 
    translate(sphereCenter.x, sphereCenter.y, -1*(sphereCenter.z));
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    rotateZ(radians(rotation.z));
    fill(red(fillColor), blue(fillColor), green(fillColor), 255);
    sphere(sphereRadius);
    popMatrix();
  }


  void setColor(float red, float blue, float green) {
    fillColor=strokeColor=color(red, blue, green);
  }

  void setRadius(int radius) {
    sphereRadius = radius;
  }

  void checkBoundaries() {

    if (sphereCenter.x >= boundaryMax.x || sphereCenter.x <= boundaryMin.x) {
      acceleration.x=acceleration.x*(-1);
      velocity.x=0;
      if (sphereCenter.x>boundaryMax.x) {
        sphereCenter.x=boundaryMax.x;
      } 
      else {
        sphereCenter.x=boundaryMin.x;
      }
    }
    if (sphereCenter.y >= boundaryMax.y || sphereCenter.y <= boundaryMin.y) {
      acceleration.y= acceleration.y*(-1);
      velocity.y=0;
      if (sphereCenter.y>boundaryMax.y) {
        sphereCenter.y=boundaryMax.y;
      } 
      else {
        sphereCenter.y=boundaryMin.y;
      }
    }
    if (sphereCenter.z >= boundaryMax.z || sphereCenter.z <= boundaryMin.z) {
      acceleration.z = acceleration.z*(-1);
      velocity.z=0;
      if (sphereCenter.z>boundaryMax.x) {
        sphereCenter.z=boundaryMax.z;
      } 
      else {
        sphereCenter.z=boundaryMin.z;
      }
    }
  }
  //Generates movement of sphere based on random functions and perlin noise
  void randomMove(float n_x, float n_y) {

    float directionX = n_x;
    float directionY = n_y;
    float directionZ = 0;

    sphereCenter.x += directionX;
    sphereCenter.y += directionY;
    sphereCenter.z += directionZ;
  }
}

