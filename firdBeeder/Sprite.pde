class Sprite {
  float x,y,w,h;
  int sx,sy,sw,sh;
  Sprite(int index, float X, float Y, int SW, int SH, float W, float H, boolean mirrored) {
    sx = (index % 16) * 16; // get sx and sy from sprite index (each 16x16 tile on the sprite sheet are index 0-256)
    sy = (index / 16) * 16;
    if(mirrored) {
      sx += SW;
      SW *= -1;
    }
    sw = sx + SW; sh = sy + SH; // store settings
    x = X; y = Y;
    w = W; h = H;
  }
  void draw() { image(spriteSheet, x - game.camera.x, y - game.camera.y, w, h, sx, sy, sw, sh); } // actually draws the image to the screen 
}
