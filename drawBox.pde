void drawBox() {
  strokeWeight(10);
  fill(100, 100, 100);
  stroke(0, 0, 0);
  //Left Side
  beginShape();
  vertex(-1000, 1000, -1000);
  vertex(-1000, -1000, -1000);
  vertex(-1000, -1000, 1000);
  vertex(-1000, 1000, 1000);
  endShape();
  //Back Side
  beginShape();
  vertex(-1000, 1000, 1000);
  vertex(1000, 1000, 1000);
  vertex(1000, -1000, 1000);
  vertex(-1000, -1000, 1000);
  endShape();
  //Right Side
  beginShape();
  vertex(1000, 1000, -1000);
  vertex(1000, -1000, -1000);
  vertex(1000, -1000, 1000);
  vertex(1000, 1000, 1000);
  endShape();
  //Top
  beginShape();
  vertex(-1000, 1000, -1000);
  vertex(1000, 1000, -1000);
  vertex(1000, 1000, 1000);
  vertex(-1000, 1000, 1000);
  endShape();
  //bottom
  beginShape();
  vertex(-1000, -1000, -1000);
  vertex(1000, -1000, -1000);
  vertex(1000, -1000, 1000);
  vertex(-1000, -1000, 1000);
  endShape();
  strokeWeight(1);
}

