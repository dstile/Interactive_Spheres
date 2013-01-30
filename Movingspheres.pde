/*Bouncing Lightening Balls
 
 
 The idea here is to create a room full of sphere.
 The sphere will bounce of each other and the walls.
 To add cool visual effect, they will also have mutlicolored 
 lightening lines randomly moving in them.
 
 1. Create multiple instances of balls in a sphere class #Complete
 2. Create constructor that builds each new ball #Complete
 3. Add velocity vectors to ball Move function # Complete ? Current Issue - How do I get instances of spheres to rotate around global coordinate system without having to put display function directly into the rotSphere function?
 
 4. create an invisible room and change direction when sphere hits wall #Complete - Sets velocity immediately to zero and reverses direction of constant accelertion
 4a. Build in radius so that spheres stop
 5. Draw planes for room to make up a box with an open top #complete
 6.  Need to figure out how to isolate rotations for each instance -# Got the sphere to rotate around its local axis -> How to do this on the global coordinate system
 7. Add lightening within the ball using Max Jitter if possible
 8. Change instance user wants to control -> Build control into the movements of the sphere
 9. Manipulate shape of object - Make sphere appear to boil with certain gestures
 10. Add in physics models to account for collisions and size of sphere when it hits walls
 
 11. Figure out how to open up sockets so different 
 people can control different balls with their phones
 12a.  Use OscP5 library to communicate with Unity3D and/or Max/MSP for jitter effects
 12.  Integrate Conway's game of life to control spawning of shapes in 3D environment
 13. Create textures a. with images  b. later with movies
 14. spawn new instances when clicking
 15. left arrow goes to instance before
 16.  right arrow goes to instance after
 */

import processing.opengl.*;


float t=0;
float rotation = 0;
//default sphere color
int red= 10;
int green= 180;
int blue = 200;
int spawn = 0;
int currentFrame=0;
//Definining new objecs with the SPheredef class
Spheredef sphere1; 
Spheredef sphere2;
Spheredef sphere3;
Spheredef sphere4;
Spheredef sphere5;
ArrayList spheres;

//Define Room Boundaries Type
PVector boundaryMax;
PVector boundaryMin;

void setup() {
  size(600, 600, OPENGL);
  spheres = new ArrayList();  //creation of empty array list

    //Constructor (pos_x, pos_y,pos_z,vel_x,vel_y,vel_z,accel_x, accel_y, accel_z, rot_x, rot_y, rot_z);
  spheres.add(new Spheredef(0, 0, 0, 0, 0, 0, 0, 0.01, 0, 0, 0, 0));
  spheres.add(new Spheredef(0, 200, -1000, 1, 0, 0, 0, 0, 0, 0, 0, 0));
  spheres.add(new Spheredef(100, 200, 0, 0, 0, 0, 0.0, 0.0, 0.01, 0, 0, 0));
  spheres.add(new Spheredef(-200, -200, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0));
  spheres.add(new Spheredef(500, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));


  //set boundary limits for sketch
  boundaryMax = new PVector(1000, 1000, 1000);
  boundaryMin = new PVector (-1000, -1000, -1000);
  //create a camera - arguments set point to look at and distance from that point
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
  float n2 = noise(yoff);
  xoff += 0.1;
  yoff += 0.1;
  t+=0.1;


  for (int i = spheres.size()-1; i >=0; i--) {
    Spheredef sphere = (Spheredef) spheres.get(i);
    sphere.go();
  }
  // sphere1.setColor(red, green, blue);
  //sphere1.update(new PVector(0,0,0));
  //sphere1.display();
  //sphere2.update(new PVector(0,0,0));
  //sphere2.display();
  //moves the sphere along the x-axis according to specified initial x_velocity and x_acceleration

  //This function uses velocity vectors to control movement
  //sphere4.display(new PVector(0,0,0));
  //sphere5.display(new PVector(0,0,0));
  drawBox();
}

//mouse dragged will determine the direction and magnitude of acceleration
void mouseDragged() {

  //Inputs: sphere_instance
  //1. calculate the distance between the mouseX, mouseZ and the sphereCenter
  //2. After experimentation come up with a factor to multiply it by
  //3. subtract the mouse position by the sphere to get the direction vector and normalize it
  //4. reset the override the previous acceleration value
}

//mouseClicked will spawn a new instance
void mouseClicked() {
  // 1.  Need a constructor and a naming system for each new sphere that is created
  // 2.  To kill a sphere I'll have to think through how this gets removed from the count 

  //concatenates the instance with a number to give it a unique name
  //Constructor (pos_x, pos_y,pos_z,vel_x,vel_y,vel_z,accel_x, accel_y, accel_z, rot_x, rot_y, rot_z);
  spheres.add(new Spheredef(mouseX, mouseY, 0, 0, 1, 0, 0, 0.01, 0, 0, 0, 0));
}


//key pressed left key the instance before, right arrow key the instance after in count
void keyPressed() {
  //1.  Use modulus to reset count based on number of instances
  //2.  append the index to the name of the sphere
}


