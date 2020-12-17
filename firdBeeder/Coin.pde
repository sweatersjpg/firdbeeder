class Coin {
  PVector pos;
  float H;
  float vH;
  float frame;
  
  Coin(PVector birdPos) {
    game.coins.add(this); // adds itself to coin list
    pos = new PVector(birdPos.x, birdPos.y);
    H = 0;
    vH = 4;
  }
  
  void update() {
    H += vH;
    vH -= GRAV/2;
    
    if(H <= 3.5) {
      vH = -vH*0.4;
      H = 3;
    }
    
    
    
  }
  
  void draw() {
    frame += 0.25;
    frame %= 4; 
    
    println(pos.x + " " +pos.y);
    
    R.setLayer((int)map(pos.y - game.camera.y, 0, width, 0, R.buffer.size())); // sets layer bassed on actual position (not just on screen position)
    R.drawSprite(16 + (int)frame, pos.x - 10, pos.y - 10 - H, 10, 10, 10*2, 10*2);
  }
  
  
}
