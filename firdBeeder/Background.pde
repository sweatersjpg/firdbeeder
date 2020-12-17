class Background {
  PImage bg;
  float W;
  float H;

  Background() {
    bg = loadImage("Assets/background_firdbeeder.png");
    W = bg.width * 2;
    H = bg.height * 2;
  }

  void draw() {
    float x = 0;
    if(game.camera.x < 0) x = W-(abs(game.camera.x) % W);
    else x = game.camera.x % W;
    
    image(bg, -x, -game.camera.y, W, H);
    image(bg, -x + W, -game.camera.y, W, H);

  }

  void update() {
    if (mouseX > 350) {
      game.camera.x += 5.0;
    } else if (mouseX < 50) {
      game.camera.x -= 5.0;
    }

    if (mouseY > 350 && game.camera.y+height < H) {
      game.camera.y += 5.0;
    } else if (mouseY < 50 && game.camera.y > 0) {
      game.camera.y -= 5.0;
    }

  }
}
