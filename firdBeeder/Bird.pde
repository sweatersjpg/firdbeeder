float birdSpeed = 3;

class Bird {
  PVector pos;
  PVector vel;
  float H; // height dimention
  float vH; // height dimention velocity
  String state;
  String oldState;
  String newState;
  boolean dir; // false is right, left is true
  int hunger;
  
  int pt; // peck timer
  float mt; // move cycle

  Seed target; // requires seed
  boolean hasTarget;

  Bird(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0,0);
    state = "target";
    pt=0;
    mt=0;
    H = 0;
    vH = 0;
    
    hunger = (int) random(4, 7);
  }

  void update() {
    pos.add(vel);
    H += vH;
    vH -= GRAV/2;
    
    if(H <= 0) {
      vH = 0;
      H = 0;
    }

    newState = state;
    float r = random(1); // picks a random number between 0 and 1;

    if (state == "idle") {
      if (oldState != state) { // runs on only the first frame of the state change
        vel.set(0,0); // clear velocity
      }
      if(hasTarget && H == 0) {
        if(r < 0.1) newState = "peck"; // 10% chance to peck
      } else {
        if(r < 0.06) newState = "peck"; // 2% chance to peck
        if(r < 0.04) newState = "target"; // 2% chance to wander
        if(r < 0.02) newState = "wander"; // 2% chance to target another
      }
      if(game.seeds.size() == 0) if(r > 0.7) newState = "angry";
    } else if (state == "wander") {
      if (oldState != state) { // runs on only the first frame of the state change
        vel = new PVector(birdSpeed,0).rotate(random(0,TAU)); // pick random direction to move
      }
      if(r < 0.03) newState = "idle"; // 3% chance to go idle
    } else if (state == "peck") {
      if (oldState != state) { // runs on only the first frame of the state change
        if(hasTarget) {
          target.health --;
          if(target.health == 0) clearTarget(true);
          //if(!hasTarget) newState = "idle";
        }
        pt = 2;
      }
      if(pt > 0) pt--;
      else newState = "idle";
    } else if (state == "target") {
      if (oldState != state) { // runs on only the first frame of the state change
        targetSeed();
      }
      if(hasTarget) {
        if(pos.dist(target.pos) < 2) newState = "idle";
      }
    } else if(state == "leave") {
      vH = 8;
      if(dir) vel.set(-8,0);
      else vel.set(8,0);
    } else if(state == "angry") {
      if(r < 0.4) {
        PVector dir = new PVector(mouseX, mouseY).sub(pos).setMag(birdSpeed*2);
        vel.set(dir);
        if(dist(mouseX, mouseY, pos.x, pos.y) > 60 && H == 0 && r < 0.2) vH = 4;
      }
      newState = "target";
    }

    oldState = state;
    state = newState;
  }

  void draw() {
    if(hasTarget) target.draw();
    
    if(vel.x > 0) dir = false;
    if(vel.x < 0) dir = true;
    
    int frame = 1;
    if(state == "peck") frame = 2;
    
    if(H > 0) {
      mt += 0.5;
      frame = (int)(8 + mt%2);
    } else if(vel.mag() > 0) { // if moving cycle through
      mt+=0.4;
      frame = (int)(3 + mt%4);
    }
    
    R.drawSprite(frame, pos.x-8*2, pos.y-16*2 - H, 16, 16, 16*2, 16*2, dir);
    
  }
  
  void clearTarget(boolean delete) {
    hasTarget = false;
    if(!delete) game.seeds.add(target);
    else {
      hunger -= 1;
      if(hunger == 0) {
        newState = "leave";
        // CODY increase score here :)
      }
    }
  }

  void targetSeed() {
    if(game.seeds.size() == 0) {
      hasTarget = false;
      newState = "angry";
      return;
    }
    target = game.seeds.get((int)random(game.seeds.size())); // gets random seed (if there are game.seeds)
  
    // tries 20 times to pick a seed closer to the bird
    // this way the birds behavior is a little more random,
    // but it still picks game.seeds a little bit closer to itself
    for(int i = 0; i < game.seeds.size()/2; i++) {
      Seed s = game.seeds.get((int)random(game.seeds.size())); // gets random seed
      if(s.H != 0) continue;
      float distS = pos.dist(s.pos); // gets dist to new seed
      float distT = pos.dist(target.pos); // gets dist to current seed
      if(distS < distT) target = s; // if its smaller set new current seed
    }
    
    if(pos.dist(target.pos) > 60) {
      vH = 6;
    }
    
    vel.set(target.pos.copy().sub(pos).setMag(birdSpeed));
    game.seeds.remove(target); // removes the target seed from the seed list so that no other birds can target it
    hasTarget = true;
  }
}
