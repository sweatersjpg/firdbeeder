class Seed {
  PVector pos;
  PVector vel;
  float H;
  float vH;
  int S;
  int health;

  Seed(float x, float y, int size) {
    S = size;
    pos = new PVector(x, y);
    vel = new PVector(random(0,7),0).rotate(random(TAU));
    H = 50;
    vH = 0;
    health = (int)random(4, 7);
    
  }

  void draw() {
    //rectMode(CENTER);
    //fill(255);
    //noStroke();
    //rect(pos.x, pos.y, width, width);
    
    R.drawSprite(10, pos.x - 6, pos.y - 5 - H, 6, 5, 6*2 * S, 5*2 * S);
  }

  void update() {
    pos.add(vel);
    vel.setMag(vel.mag() * 0.9);
    H += vH;
    vH -= GRAV/2;
    
    if(H <= 0.5) {
      vH = -vH*0.4;
      H = 0;
    }
    
  }
}