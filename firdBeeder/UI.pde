class UI {

  boolean upgradePressed;

  UI() {
    upgradePressed = false;
  }

  void draw() {
    PVector bpos = new PVector(game.camera.x + 64 * 2, game.camera.y + height - 19*2);

    if (mousePressed && !upgradePressed) {
      if (game.mouse.x > bpos.x && game.mouse.x < bpos.x + 32 && game.mouse.y > bpos.y && game.mouse.y < bpos.y + 32) {
        if (game.upgradeCost <= game.monies) {
          upgradePressed = true;
          game.upgrade();
        }
      }
    } else if (!mousePressed)  upgradePressed = false;


    R.setLayer(1000); // set layer to highest
    R.drawSprite(32, game.camera.x, game.camera.y, 200, 16, 400, 32);

    R.setLayer(1000); // set layer to highest
    R.drawSprite(48, game.camera.x, game.camera.y + height - 36*2, 200, 36, 400, 36*2);

    int buttonFrame = 20;
    if (upgradePressed) buttonFrame = 21;
    if (game.upgradeCost > game.monies) buttonFrame = 22;

    R.setLayer(1000); // set layer to highest
    R.drawSprite(buttonFrame, bpos.x, bpos.y, 16, 16, 32, 32);
  }

  void drawText() {
    //display score
    textSize(20);
    fill(255);

    text("firds bed: "+game.score, 180, 24);

    if (game.costPerSeed * game.seedsPerClick > game.monies) fill(255, 80, 80);
    text(game.seedsPerClick+" costs: $" + game.seedsPerClick*game.costPerSeed, 28, 24);
    fill(255);
    text(game.seedsPerClick, 28, 24);
    
    text("$ "+game.monies, 6, height-12);

    if (game.upgradeCost > game.monies) fill(255, 80, 80 );
    text("cost: $"+game.upgradeCost, 164, height-12);
  }
}
