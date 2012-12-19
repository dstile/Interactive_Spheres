/*Bouncing Lightening Balls
 
 
 The idea here is to create a room full of sphere.
 The sphere will bounce of each other and the walls.
 To add cool visual effect, they will also have mutlicolored 
 lightening lines randomly moving in them.
 
 1. Create multiple instances of balls in a sphere class #Complete
 2. Create constructor that builds each new ball #Complete
 3. Add velocity vectors to ball Move function # Complete ? Current Issue - How do I get instances of spheres to rotate around global coordinate system without having to put display function directly into the rotSphere function?
 
 4. create an invisible room and change direction when sphere hits wall #Complete - Sets velocity immediately to zero and reverses direction of constant accelertion
 5. Draw planes for room to make up a box with an open top 
 6.  Need to figure out how to isolate rotations for each instance -# Got the sphere to rotate around its local axis -> How to do this on the global coordinate system
 7. Add lightening within the ball using Max Jitter if possible
 8. Change instance user wants to control
 9. Manipulate shape of object - Make sphere appear to boil with certain gestures
 10. Add in physics models to account for collisions
 
 11. Figure out how to open up sockets so different 
 people can control different balls with their phones
 12a.  Use OscP5 library to communicate with Unity3D and/or Max/MSP for jitter effects
 12.  Integrate Conway's game of life to control spawning of shapes in 3D environment
 */

import processing.opengl.*;
import peasy.*;
PeasyCam cam;
float t=0;
float rotation = 0;
//default sphere color
int red= 10;
int green= 180;
int blue = 200;
int currentFrame=0;
//Definining new objecs with the SPheredef class
Spheredef sphere1; 
Spheredef sphere2;
Spheredef sphere3;
Spheredef sphere4;
Spheredef sphere5;

//Define Room Boundaries Type
PVector boundaryMax;
PVector boundaryMin;

void setup() {
  size(600, 600, OPENGL);
  

  //Constructor (pos_x, pos_y,pos_z,vel_x,vel_y,vel_z,accel_x, accel_y, accel_z, rot_x, rot_y, rot_z);
  sphere1 = new Spheredef(0, 0, 0, 0, 0, 0, 0, 0.01, 0, 0, 0, 0);
  sphere2 = new Spheredef(0, 200, -1000, 1, 0, 0, 0, 0, 0, 0, 0, 0);
  sphere3 = new Spheredef(100, 200, 0, 0, 0, 0, 0.0, 0.0, 0.01, 0, 0, 0);
  sphere4 = new Spheredef(-200, -200, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  sphere5 = new Spheredef(500, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

  //set boundary limits for sketch
  boundaryMax = new PVector(1000, 1000, 1000);
  boundaryMin = new PVector (-1000, -1000, -1000);
  //create a camera - arguments set point to look at and distance from that point
  cam = new PeasyCam (this, 0, 0, 0, 2000);
}

void draw() {
  background(250);
  //Inverting Y and Z directions so processing coordinates match with kinect direction
  rotateX(radians(180));
  //Setting the origin of the sketch to the center
  translate(width/2, -1*(height/2), 1000);
  float xoff=0;
  float yoff=1000;
  float n1 = noise(xoff);
  float n2= noise(yoff);
  xoff+=0.1;
  yoff+=0.1;
  t+=0.1;

  //Check to make sure object is within boundary
 
  //Random Move uses Perlin
  sphere1.movement();
  sphere1.checkBoundaries();
  sphere1.display();
  // sphere1.setColor(red, green, blue);
  //sphere1.update(new PVector(0,0,0));
  //sphere1.display();
  //sphere2.update(new PVector(0,0,0));
  //sphere2.display();
  //moves the sphere along the x-axis according to specified initial x_velocity and x_acceleration
   sphere3.update_rotation();
   sphere3.movement();
   sphere3.checkBoundaries();
  //sphere3.sphererot.y=frameCount;
  sphere3.display();

  //This function uses velocity vectors to control movement

  //sphere4.display(new PVector(0,0,0));
  //sphere5.display(new PVector(0,0,0));
  drawBox();
}

void drawBox() {
  strokeWeight(10);
  fill(100,100,100);
  stroke(0,0,0);
  //Left Side
  beginShape();
  vertex(-1000,1000,-1000);
  vertex(-1000,-1000,-1000);
  vertex(-1000,-1000,1000);
  vertex(-1000,1000,1000);
  endShape();
  //Back Side
  beginShape();
  vertex(-1000,1000,1000);
  vertex(1000,1000,1000);
  vertex(1000,-1000,1000);
  vertex(-1000,-1000,1000);
  endShape();
  //Right Side
   beginShape();
  vertex(1000,1000,-1000);
  vertex(1000,-1000,-1000);
  vertex(1000,-1000,1000);
  vertex(1000,1000,1000);
  endShape();
  //Top
  beginShape();
  vertex(-1000,1000,-1000);
  vertex(1000,1000,-1000);
  vertex(1000,1000,1000);
  vertex(-1000,1000,1000);
  endShape();
  //bottom
  beginShape();
  vertex(-1000,-1000,-1000);
  vertex(1000,-1000,-1000);
  vertex(1000,-1000,1000);
  vertex(-1000,-1000,1000);
  endShape();
  strokeWeight(1);
}

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
      if(sphereCenter.x>boundaryMax.x){
      sphereCenter.x=boundaryMax.x;
    } else{
     sphereCenter.x=boundaryMin.x;
    }
    }
    if (sphereCenter.y >= boundaryMax.y || sphereCenter.y <= boundaryMin.y) {
      acceleration.y= acceleration.y*(-1);
        velocity.y=0;
      if(sphereCenter.y>boundaryMax.y){
      sphereCenter.y=boundaryMax.y;
    } else{
     sphereCenter.y=boundaryMin.y;
    }
    }
    if (sphereCenter.z >= boundaryMax.z || sphereCenter.z <= boundaryMin.z) {
      acceleration.z = acceleration.z*(-1);
        velocity.z=0;
      if(sphereCenter.z>boundaryMax.x){
      sphereCenter.z=boundaryMax.z;
    } else{
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

