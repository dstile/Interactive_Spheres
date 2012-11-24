/*Bouncing Lightening Balls
 
 
 The idea here is to create a room full of sphere.
 The sphere will bounce of each other and the walls.
 To add cool visual effect, they will also have mutlicolored 
 lightening lines randomly moving in them.
 
 1. Create multiple instances of balls in a sphere class
 a. Create constructor that builds each new ball
 2. Add velocity vectors to ball
 3. Add lightening within the ball
 */

import processing.opengl.*;

float rotation = 0;
//default sphere color
int red= 10;
int green= 180;
int blue = 200;
//a vector holding the center of the sphere
Spheredef sphere1; 
Spheredef sphere2;
Spheredef sphere3;
Spheredef sphere4;
Spheredef sphere5;



void setup() {
  size(600, 600, OPENGL);
  sphere1 = new Spheredef(0, 0, 0);
  sphere2 = new Spheredef(0, 200, -1000);
  sphere3 = new Spheredef(-200, 200, 500);
  sphere4 = new Spheredef(-200, -200, 500);
  sphere5 = new Spheredef(500, 100, 0);
  background(250);
}

void draw() {

  rotateX(radians(180));
  translate(width/2, -1*(height/2), 1000);
  /*rotateX(radians(frameCount));
   rotateY(radians(frameCount));
   rotateZ(radians(frameCount));*/

  //sphere.move();
  //sphere5.color();
  sphere1.setColor(red,green,blue);
  sphere1.setRadius(100);
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
  float sphereRadius;

  Spheredef(int x, int y, int z) {
    centerX=x;
    centerY=y;
    centerZ=z;
    sphereRadius=random(200);
    fillColor=strokeColor=color(random(255), random(255), random(255));
    sphereCenter= new PVector(centerX, centerY, centerZ);
    
  }

  void display() {

    //Save copy of current world
    pushMatrix(); 
    translate(sphereCenter.x, sphereCenter.y, -1*(sphereCenter.z));
    fill(red(fillColor),blue(fillColor),green(fillColor),255);
    sphere(sphereRadius);
    popMatrix();
  }


  void move() {
    int choice = int(random(24));
  }

  void rotSphere() {

    rotateY(radians(frameCount));
  }

  void setColor(float red, float blue, float green) {
    fillColor=strokeColor=color(red, blue, green);
  }
  
  void setRadius(float radius) {
      sphereRadius = random(radius);
}
}

