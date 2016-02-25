Attractor attractor;
Mover[] movers = new Mover[50];

int lineInterval = 5000;
int lineAcc = 0;
long currentTime;
long previousTime = 0;
int moverIndex = 0;

int nbMovers = 50;

float attractorToCorner;

void setup() {
  fullScreen(1);
  
  for (int i = 0; i < nbMovers; i++) {
    movers[i] = new Mover();
    movers[i].setShape(ShapeType.SQUARE);
  }
  
  attractor = new Attractor();
  
  attractorToCorner = PVector.sub(attractor.location, new PVector()).mag();
}

void draw() {
  currentTime = millis();
  lineAcc += currentTime - previousTime;
  
  update();
  display();
  previousTime = currentTime;
}

void update() {
  
  for (int i = 0; i < nbMovers; i++) {
    Mover current = movers[i];
    PVector f = attractor.attractionForce(current);
    
    for (int j = 0; j < nbMovers; j++) {
      if (j != i) {
        PVector f2 = current.attractionForce(movers[j]);
        current.applyForce(f2);
      }      
    }
    
    current.applyForce(f);
    current.update();
  }
  
  if (lineAcc > lineInterval) {
    lineAcc = 0;
    moverIndex = (moverIndex + 1) % nbMovers;
  }
}

void display() {
  
  
  background (255);
  
  attractor.display();
  
  for (int i = 0; i < nbMovers; i++) {
    movers[i].display();
  }
  
  displayLine();

}

void displayLine() {
  PVector loc = movers[moverIndex].location;
  float mag = PVector.sub(attractor.location, loc).mag();
  
  strokeWeight(map (mag, 0, width, .1, movers[moverIndex].radius * 2));
  stroke (color(0, 200, 0, map (mag, 0, attractorToCorner, 20, 255)));
  line (attractor.location.x, attractor.location.y, loc.x, loc.y);
  
  strokeWeight(1);
  stroke (color(0, 0, 0, 255));
  textSize(16);
  text(" d = " + mag, (loc.x - attractor.location.x) / 2 + attractor.location.x, (loc.y - attractor.location.y) / 2 + attractor.location.y);
}