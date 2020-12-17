class Coin {
  PVector pos;
  PVector vel;
  float H;
  float vH;
  float frame;

  boolean gotten;

  Coin(PVector birdPos) {
    game.coins.add(this); // adds itself to coin list
    vel = new PVector();
    pos = new PVector(birdPos.x, birdPos.y);
    H = 0;
    vH = 4;
    gotten = false;
  }

  void update() {
    pos.add(vel);

    H += vH;
    vH -= GRAV/2;

    if (H <= 3.5) {
      vH = -vH*0.4;
      H = 3;
    }

    if (gotten) {
      PVector target = new PVector(game.camera.x, game.camera.y + height); // targets the bottom left
      PVector dir = target.copy().sub(pos).setMag(0.8);
      vel.add(dir);
      
      if(pos.x < game.camera.x || pos.y > game.camera.y+height) {
        game.coins.remove(this);
        
        // game.money += 5;
        
        return;
      }
    } else if (game.mouse.dist(pos) < 32) {
      gotten = true;
    }
  }

  void draw() {
    frame += 0.25;
    frame %= 4; 

    if(!gotten) R.setLayer((int)map(pos.y - game.camera.y, 0, height, 0, R.buffer.size()-2)); // sets layer bassed on actual position (not just on screen position)
    else R.setLayer(R.buffer.size()-1); // set layer to highest
    R.drawSprite(16 + (int)frame, pos.x - 10, pos.y - 10 - H, 10, 10, 10*2, 10*2);
  }
}
