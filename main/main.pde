PImage earth_img, background;
PShape earth;
float angleX, angleY, rotX, rotY;
float earth_r_real = 6400, earth_r = 200;

ArrayList<Satellite> satellites = new ArrayList<Satellite>();


void setup() {
  size(600, 600, P3D); 
  noStroke();
  earth_img = loadImage("world.jpg");
  background = loadImage("space.jpg");
  earth = createShape(SPHERE, 200);
  earth.setTexture(earth_img);
  
  satellites.add(new Satellite("25544"));  // ISS
  satellites.add(new Satellite("39574"));  // Random satellite #1
  satellites.add(new Satellite("39227"));  // Random satellite #2
  satellites.add(new Satellite("28647"));  // Random satellite #3
  for (Satellite s : satellites) s.update();  // Load data on each satellite
  
}

void draw() {
  background(background);
  
  // Translate to center
  translate(width/2, height/2);
  angleX += rotX;
  angleY += rotY;
  
  rotateX(angleX);
  rotateY(angleY);
  
  fill(255);
  noStroke();
  shape(earth);
  
  for (Satellite s : satellites) {
    s.display();
  }
  if (frameCount%120 == 0) thread("updateSats");  // Every 2 seconds, update position
}



// Made this a function so that we could thread it
void updateSats() {
  for (Satellite s : satellites) s.update();
}




void keyPressed() {
  if (key == 'a' || key == 'A') rotY = -0.01;
  if (key == 'd' || key == 'D') rotY = 0.01;
  if (key == 'w' || key == 'W') rotX = 0.01;
  if (key == 's' || key == 'S') rotX = -0.01;
}

void keyReleased() {
  if (key == 'a' || key == 'A') rotY = 0;
  if (key == 'd' || key == 'D') rotY = 0;
  if (key == 'w' || key == 'W') rotX = 0;
  if (key == 's' || key == 'S') rotX = 0;
}
