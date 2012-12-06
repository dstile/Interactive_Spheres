/*Bouncing Lightening Balls
 
 
 The idea here is to create a room full of sphere.
 The sphere will bounce of each other and the walls.
 To add cool visual effect, they will also have mutlicolored 
 lightening lines randomly moving in them.
 
 1. Create multiple instances of balls in a sphere class #Complete
 2. Create constructor that builds each new ball #Complete
 3. Add velocity vectors to ball Move function # Complete ? Current Issue - How do I get rotations to work without having to put display directly into the rotSphere function?

 4.  Need to figure out how to isolate rotations for each instance - Why does PVector rot keep resetting after being passed to the display function?
 5. Add lightening within the ball
 6. Change instance user wants to control
 7. Manipulate shape of object - Make sphere appear to boil with certain gestures
 8. Add in physics models to account for collisions
 9. create an invisible room
 10. Figure out how to open up sockets so different 
 people can control different balls with their phones
 9a.  Use OscP5 library to communicate with Unity3D and/or Max/MSP for jitter effects
 11.  Integrate Conway's game of life to control spawning of shapes in 3D environment
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




void setup() {
  size(600, 600, OPENGL);
  //initialize all new instances
  //sphere1 = new Spheredef(int(random(0,width)), int(random(0,height)),-1000);
 
  //Constructor (pos_x, pos_y,pos_z,vel_x,vel_y,vel_z,accel_x, accel_y, accel_z, rot_x, rot_y, rot_z);
  sphere1 = new Spheredef(0,0,0,0,0,0,0,0,0,0,0,0);
  sphere2 = new Spheredef(0, 200, -1000,0,0,0,0,0,0,0,0,0);
  sphere3 = new Spheredef(100,200,0, 1,1,0, 0.001,0,0, 0,0, 0);
  sphere4 = new Spheredef(-200,-200,500,0,0,0,0,0,0,0,0,0);
  sphere5 = new Spheredef(500,100,0,0,0,0,0,0,0,0,0,0);
  
  //create a camera - arguments set point to look at and distance from that point
  cam = new PeasyCam (this,0,0,0,2000);
  //cam.setMinimumDistance(50);
  //cam.setMaximumDistance(500);
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
  
  
 
 
  //Random Move uses Perlin
  //sphere1.randomMove(n1,n2);
 // sphere1.setColor(red, green, blue);
  //sphere1.update(new PVector(0,0,0));
  //sphere1.display();
  //sphere2.update(new PVector(0,0,0));
  //sphere2.display();
  //moves the sphere along the x-axis according to specified initial x_velocity and x_acceleration
  sphere3.movement();
  //sphere3.sphererot.y=frameCount;
  sphere3.display();
  
  //This function uses velocity vectors to control movement
 
  //sphere4.display(new PVector(0,0,0));
  //sphere5.display(new PVector(0,0,0));
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
 
 // Draws Sphere
  void display() {
    //Save copy of current world
    pushMatrix(); 
    translate(sphereCenter.x, sphereCenter.y, -1*(sphereCenter.z));
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    rotateZ(radians(frameCount));
    fill(red(fillColor), blue(fillColor), green(fillColor), 255);
    sphere(sphereRadius);
    popMatrix();
  }
  
  //Generates movement of sphere based on random functions and perlin noise
  void randomMove(float n_x, float n_y) {
  
    float directionX = n_x;
    float directionY = n_y;
    float directionZ = 0;
     //This method creates too much of a standard deviation - unnatural
    //int stepSize = 11;
    //int directionX = int(random(-1*stepSize,stepSize));
    //int directionY = int(random(-1*stepSize,stepSize));
    //int directionZ = int(random(-1*stepSize,stepSize));
    sphereCenter.x += directionX;
    sphereCenter.y += directionY;
    sphereCenter.z += directionZ;
     //randomly generates step based on probability
     /*float check_prob(step) {
       prob=random(1);
      if(step<prob)
      { return step;
      }else {
        return 0;
      }
    }*/
  }

  void setColor(float red, float blue, float green) {
    fillColor=strokeColor=color(red, blue, green);
  }
  
  void setRadius(int radius) {
    sphereRadius = radius;
  }
}

