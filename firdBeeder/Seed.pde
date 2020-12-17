class Seed {
  PVector pos;
  PVector vel;
  int S;
  int health;

  Seed(float x, float y, int size) {
    S = size;
    pos = new PVector(x, y);
    vel = new PVector(random(0,4),0).rotate(random(TAU));
    health = (int)random(4, 7);
  }

  void draw() {
    //rectMode(CENTER);
    //fill(255);
    //noStroke();
    //rect(pos.x, pos.y, width, width);
    
    R.drawSprite(10, pos.x, pos.y, 6, 5, 6*2 * S, 5*2 * S);
  }

  void update() {
    pos.add(vel);
    vel.setMag(vel.mag() * 0.9);
  }
}
