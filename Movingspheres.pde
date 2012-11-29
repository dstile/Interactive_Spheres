/*Bouncing Lightening Balls
 
 
 The idea here is to create a room full of sphere.
 The sphere will bounce of each other and the walls.
 To add cool visual effect, they will also have mutlicolored 
 lightening lines randomly moving in them.
 
 1. Create multiple instances of balls in a sphere class #Complete
 3. Create constructor that builds each new ball #Complete
 3. Add velocity vectors to ball Move function
 5.  Need to figure out how to isolate rotations for each instance
 4. Add lightening within the ball
 5. Change instance user wants to control
 6. Manipulate shape of object - Make sphere appear to boil with certain gestures
 7. Add in physics models to account for collisions
 8. create an invisible room
 9. Figure out how to open up sockets so different 
 people can control different balls with their phones
 9a.  Use OscP5 library to communicate with Unity3D and/or Max/MSP for jitter effects
 10.  Integrate Conway's game of life to control spawning of shapes in 3D environment
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
 
  
  sphere1 = new Spheredef(0,0,0);
  sphere2 = new Spheredef(0, 200, -1000);
  sphere3 = new Spheredef(0, 0, 0);
  sphere4 = new Spheredef(-200, -200, 500);
  sphere5 = new Spheredef(500, 100, 0);

  //create a camera - arguments set point to look at and distance from that point
  cam = new PeasyCam (this,0,0,0,2000);
  //cam.setMinimumDistance(50);
  //cam.setMaximumDistance(500);
}

void draw() {
  background(250);
  rotateX(radians(180));
  translate(width/2, -1*(height/2), 1000);
  float xoff=0;
  float yoff=1000;
  float n1 = noise(xoff);
  float n2= noise(yoff);
  xoff+=0.1;
  yoff+=0.1;
  t+=0.1;
  
  //Random Move uses Perlin
  sphere1.randomMove(n1,n2);
  sphere1.setColor(red, green, blue);
  sphere1.display();
  float vi_x=1;
  float a_x= 3;
  
   sphere3.vMove(t, vi_x,a_x);
  sphere3.display();
  sphere2.rotSphere();
  sphere2.display();
  

  
  //This function uses velocity vectors to control movement
 
  sphere4.display();
  sphere5.display();
}

//Sphere Class
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
  float vi_x;
  float a_x;
  
  //Constructor
  Spheredef(int x, int y, int z) {
    centerX=x;
    centerY=y;
    centerZ=z;
    sphereRadius=int(random(200));
    fillColor=strokeColor=color(random(255), random(255), random(255));
    sphereCenter= new PVector(centerX, centerY, centerZ);
  }

 // Draws Sphere
  void display() {
    //Save copy of current world
    pushMatrix(); 
    translate(sphereCenter.x, sphereCenter.y, -1*(sphereCenter.z));
    fill(red(fillColor), blue(fillColor), green(fillColor), 255);
    sphere(sphereRadius);
    popMatrix();
  }
  
  //Generates movement of sphere based on controlled paramteres
  void vMove(float t,float vi_x,float a_x){
    sphereCenter.x=vi_x*t+0.5*a_x*pow(t,2);
    println(sphereCenter.x);
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

