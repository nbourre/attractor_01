Attractor attractor;
Mover[] movers = new Mover[20];

int nbMovers = 20;

void setup() {
  size (640, 480);
  
  for (int i = 0; i < nbMovers; i++) {
    movers[i] = new Mover();
    movers[i].setShape(ShapeType.SQUARE);
  }
  
  attractor = new Attractor();
}

void draw() {
  update();
  display();
}

void update() {
  
  for (int i = 0; i < nbMovers; i++) {
    Mover current = movers[i];
    PVector f = attractor.attractionForce(current);
    
    current.applyForce(f);
    current.update();
  }
}

void display() {
  background (255);
  
  attractor.display();
  
  for (int i = 0; i < nbMovers; i++) {
    movers[i].display();
  }
}