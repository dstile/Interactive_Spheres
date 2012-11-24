/*Bouncing Lightening Balls
 
 
 The idea here is to create a room full of sphere.
 The sphere will bounce of each other and the walls.
 To add cool visual effect, they will also have mutlicolored 
 lightening lines randomly moving in them.
 
 1. Create multiple instances of balls in a sphere class #Complete
 3. Create constructor that builds each new ball #Complete
 3. Add velocity vectors to ball Move function
 4. Add lightening within the ball
 5. Change instance user wants to control
 6. Manipulate shape of object
 7. Add in physics models to account for collisions
 8. Figure out how to open up sockets so different 
 people can control different balls with their phones
 8a.  Use OscP5 library to communicate with Unity3D and/or Max/MSP for jitter effects
 9.  Integrate Conway's game of life to control spawning of shapes in 3D environment
  */

import processing.opengl.*;
import peasy.*;

PeasyCam cam;
float rotation = 0;
//default sphere color
int red= 10;
int green= 180;
int blue = 200;
//Definining new objecs with the SPheredef class
Spheredef sphere1; 
Spheredef sphere2;
Spheredef sphere3;
Spheredef sphere4;
Spheredef sphere5;



void setup() {
  size(600, 600, OPENGL);
  //initialize all new instances
  sphere1 = new Spheredef(0, 0, 0);
  sphere2 = new Spheredef(0, 200, -1000);
  sphere3 = new Spheredef(-200, 200, 500);
  sphere4 = new Spheredef(-200, -200, 500);
  sphere5 = new Spheredef(500, 100, 0);

  //create a camera
  //arguments set point to look at and distance from that point
  cam = new PeasyCam (this,0,0,0,1000);
  //cam.setMinimumDistance(50);
  //cam.setMaximumDistance(500);
 
}

void draw() {
  background(250);
  rotateX(radians(180));
  translate(width/2, -1*(height/2), 1000);
  /*rotateX(radians(frameCount));
   rotateY(radians(frameCount));
   rotateZ(radians(frameCount));*/

  sphere1.move();
  sphere1.setColor(red, green, blue);
  sphere1.display();
  sphere2.rotSphere();
  sphere2.display();
  sphere3.display();
  sphere4.display();
  sphere5.rotSphere();
  sphere5.display();
}

//Sphere constructor
class Spheredef {
  PVector sphereCenter;
  PVector sphereColor;
  int centerX;
  int centerY;
  int centerZ;
  color fillColor;
  color strokeColor;
  int red;
  int green;
  int blue;
  int sphereRadius;

  Spheredef(int x, int y, int z) {
    centerX=x;
    centerY=y;
    centerZ=z;
    sphereRadius=int(random(200));
    fillColor=strokeColor=color(random(255), random(255), random(255));
    sphereCenter= new PVector(centerX, centerY, centerZ);
  }

  void display() {

    //Save copy of current world
    pushMatrix(); 
    translate(sphereCenter.x, sphereCenter.y, -1*(sphereCenter.z));
    fill(red(fillColor), blue(fillColor), green(fillColor), 255);
    sphere(sphereRadius);
    popMatrix();
  }


  void move() {
    int stepSize = 11;
    
    //This method creates too much of a standard deviation - unnatural
    int directionX = int(random(-1*stepSize,stepSize));
    int directionY = int(random(-1*stepSize,stepSize));
    int directionZ = int(random(-1*stepSize,stepSize));
    println(directionX);
    
    sphereCenter.x += directionX;
    sphereCenter.y += directionY;
    sphereCenter.z += directionZ;
    
    }

    void rotSphere() {

      rotateY(radians(frameCount));
    }

    void setColor(float red, float blue, float green) {
      fillColor=strokeColor=color(red, blue, green);
    }

    void setRadius(int radius) {
      sphereRadius = radius;
    }
  }

