class Background {

  Background() {
    //img = loadImage("firdbeeder background.png");
  }

  void draw() {
    //image(img, -game.world.x, -game.world.y, 800, 400);
    //image(img, -game.world.x+800, -game.world.y, 800, 400);
    //image(img, -game.world.x, -game.world.y+400, 800, 400);
    //image(img, -game.world.x+800, -game.world.y+400, 800, 400);
  }

  void update() {
    if (mouseX > 350) {
      game.world.x += 5.0;
    } else if (mouseX < 50) {
      game.world.y -= 5.0;
    }

    if (game.world.x > 800) {
      game.world.x-=800;
    }
    if (game.world.x < 0) {
      game.world.x+=800;
    }
    
    if (mouseY > 350) {
      game.world.y += 5.0;
    } else if (mouseY < 50) {
      game.world.y -= 5.0;
    }

    if (game.world.y > 400) {
      game.world.y-=400;
    }
    if (game.world.y < 0) {
      game.world.y+=400;
    }
  }
}
