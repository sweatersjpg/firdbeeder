class UI {

  boolean upgradePressed;

  UI() {
    upgradePressed = false;
  }

  void draw() {
    PVector bpos = new PVector(game.camera.x + 64 * 2, game.camera.y + height - 19*2);

    if (mousePressed && !upgradePressed) {
      if (game.mouse.x > bpos.x && game.mouse.x < bpos.x + 32 && game.mouse.y > bpos.y && game.mouse.y < bpos.y + 32) {
        upgradePressed = true;
        // buy new upgrade
      }
    } else if (!mousePressed)  upgradePressed = false;


    R.setLayer(1000); // set layer to highest
    R.drawSprite(32, game.camera.x, game.camera.y, 200, 16, 400, 32);

    R.setLayer(1000); // set layer to highest
    R.drawSprite(48, game.camera.x, game.camera.y + height - 36*2, 200, 36, 400, 36*2);

    int buttonFrame = 20;
    if (upgradePressed) buttonFrame = 21;
    // else if (cant buy new upgrade) buttonFrame = 22;

    R.setLayer(1000); // set layer to highest
    R.drawSprite(buttonFrame, bpos.x, bpos.y, 16, 16, 32, 32);
  }
  
  void drawText() {
    
  }
}
