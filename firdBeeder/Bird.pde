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

  Bird() {
    PVector spawn = new PVector(width, 0).rotate(random(TAU)); // get random direction
    // birds spawn randomly in a radius around the middle of the screen
    pos = new PVector(game.camera.x+width/2,game.camera.y+height/2).add(spawn);
    vel = new PVector();
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

    if (H <= 0) {
      vH = 0;
      H = 0;
    }

    newState = state;
    float r = random(1); // picks a random number between 0 and 1;

    if (state == "idle") {
      if (oldState != state) { // runs on only the first frame of the state change
        vel.set(0, 0); // clear velocity
      }
      if (hasTarget && H == 0) {
        if (r < 0.1) newState = "peck"; // 10% chance to peck
      } else {
        if (r < 0.06) newState = "peck"; // 2% chance to peck
        if (r < 0.04) newState = "target"; // 2% chance to wander
        if (r < 0.02) newState = "wander"; // 2% chance to target another
      }
      if (game.seeds.size() == 0) if (r > 0.7) newState = "angry";
    } else if (state == "wander") {
      if (oldState != state) { // runs on only the first frame of the state change
        vel = new PVector(birdSpeed, 0).rotate(random(0, TAU)); // pick random direction to move
      }
      if (r < 0.03) newState = "idle"; // 3% chance to go idle
    } else if (state == "peck") {
      if (oldState != state) { // runs on only the first frame of the state change
        if (hasTarget) {
          target.health --;
          if (target.health == 0) clearTarget(true);
        }
        pt = 2; // start peck timer (so it animates for two frames)
      }
      if (pt > 0) pt--; // decrease pt
      else newState = "idle"; // if its 0 go back to idle 
    } else if (state == "target") {
      if (oldState != state) { // runs on only the first frame of the state change
        targetSeed(); // target a new seed
      }
      if (hasTarget) if (pos.dist(target.pos) < 2) newState = "idle"; // if has a target and is pretty close turn idle
    } else if (state == "leave") {
      vH = 8; // set height velocity so the bird 'fly's' away
      if (dir) vel.set(-8, 0); // move it in the direction it's looking
      else vel.set(8, 0);
      if(dist(game.camera.x+width/2, game.camera.y + height/2, pos.x, pos.y) > width) { // if the bird is out of the feild of view
        game.birds.remove(this); // remove itself from the list
        return;
      }
    } else if (state == "angry") {
      if (r < 0.4) {
        PVector dir = new PVector(game.mouse.x, game.mouse.y).sub(pos).setMag(birdSpeed*2);
        vel.set(dir);
        if (dist(game.mouse.x, game.mouse.y, pos.x, pos.y) > 60 && H == 0 && r < 0.2) vH = 4;
      }
      newState = "target";
    }

    oldState = state;
    state = newState;
  }

  void draw() {
    if (hasTarget) target.draw(); // draw the target seed to the screen if it has one (since it was removed from seed list)

    if (vel.x > 0) dir = false; // adjust direction based on x velicity
    if (vel.x < 0) dir = true;
    // if 0 it does not change directions 

    int frame = 1;
    if (state == "peck") frame = 2; // peck frame if pecking

    if (H > 0) { // if in the air cycle through flapping sprites
      mt += 0.5;
      frame = (int)(8 + mt%2);
    } else if (vel.mag() > 0) { // if moving cycle through hopping sprites
      mt+=0.4;
      frame = (int)(3 + mt%4);
    }

    R.setLayer((int)map(pos.y - game.camera.y, 0, width, 0, R.buffer.size())); // sets layer bassed on actual position (not just on screen position)
    R.drawSprite(frame, pos.x-8*2, pos.y-16*2 - H, 16, 16, 16*2, 16*2, dir); // draw the bird
  }

  void clearTarget(boolean delete) {
    hasTarget = false;
    if (!delete) game.seeds.add(target); // if we're not deleting it, add it back to the seeds list
    else {
      hunger -= 1; // decrease hunger level
      if (hunger == 0) { // if it has no hunger
        newState = "leave"; // set state to leave
        game.score = game.score + 1; //if a bird is satisfied from eating the seeds, then the score would increase
        new Coin(pos);
      }
    }
  }

  void targetSeed() {
    if (game.seeds.size() == 0) { // if no seeds in the list
      hasTarget = false; // set has target to false
      newState = "angry"; // turn angry
      return;
    }

    target = game.seeds.get((int)random(game.seeds.size())); // gets random seed (if there are game.seeds)

    // tries 20 times to pick a seed closer to the bird
    // this way the birds behavior is a little more random,
    // but it still picks game.seeds a little bit closer to itself
    for (int i = 0; i < game.seeds.size()/2; i++) {
      Seed s = game.seeds.get((int)random(game.seeds.size())); // gets random seed
      if (s.H > 0) continue;
      float distS = pos.dist(s.pos); // gets dist to new seed
      float distT = pos.dist(target.pos); // gets dist to current seed
      if (distS < distT) target = s; // if its smaller set new current seed
    }

    if (target.H > 0) { // if target is still not landed turn angry and set has target to false
      hasTarget = false;
      newState = "angry";
      return;
    }

    if (pos.dist(target.pos) > 60) vH = 6; // if target is far fly a bit

    vel.set(target.pos.copy().sub(pos).setMag(birdSpeed));
    game.seeds.remove(target); // removes the target seed from the seed list so that no other birds can target it
    hasTarget = true;
  }
}
