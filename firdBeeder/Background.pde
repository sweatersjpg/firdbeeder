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
    if (mouseX > width-50) {
      game.camera.x += 5.0;
    } else if (mouseX < 50) {
      game.camera.x -= 5.0;
    }

    if (mouseY > height-20 && game.camera.y+height < H && (mouseX < 124 || mouseX > 124+40)) {
      game.camera.y += 5.0;
    } else if (mouseY < 50 && game.camera.y > -30) {
      game.camera.y -= 5.0;
    }

  }
}
