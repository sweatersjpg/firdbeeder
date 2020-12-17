/* ----- RENDERER -----
  basic usage:
    use R.drawSprite() to draw a sprite to the screen
    it takes 7 perameters:
      INDEX: Which 16x16 tile on the sprite sheet the desired sprite is on
          X: X position on the screen to draw the sprite on
          Y: Y position on the screen to draw the sprite on
         SW: How many pixels wide the sprite is on the sprite sheet
         SH: How many pixels high the sprite is on the sprite sheet
      WIDTH: The width of the sprite drawn on the screen
     HEIGHT: The height of the sprite drawn on the screen
    
    Example
      "R.drawSprite(1, mouseX, mouseY, 16, 16, 64, 64);"
      Will draw sprite 1 (the bird) at the coordinates (mouseX, mouseY) with the width and height of 64px
*/


class Renderer {
  ArrayList<ArrayList<Sprite>> buffer; // list of lists of sprites
  int currentLayer = -1; // -1 is automatic
  
  Renderer(int bufferSize) {
    buffer = new ArrayList<ArrayList<Sprite>>(); // initialize buffer
    for(int i=0; i<bufferSize; i++) { // populate the buffer
      buffer.add(new ArrayList<Sprite>());
    }
  }
  
  void render() {
    for(ArrayList<Sprite> l : buffer) for(Sprite s : l) { // loops through each sprite in each layer
        s.draw(); // draws the sprite
    }
  }
  
  void setLayer(int n) { // for UI and background elements to stay on the right layer
    currentLayer = n;
  }
  
  void drawSprite(int index, float x, float y, int sw, int sh, float w, float h, boolean mirrored) {
    int layer = currentLayer;
    currentLayer = -1; // reset currentLayer to default
    
    if(layer == -1) { // if current layer is set to default
      layer = (int) map(y+h - game.camera.y, 0, height, 0, buffer.size()); // get layer bassed on ypos on the screen
    }
    
    if(layer >= buffer.size()) layer = buffer.size()-1; // keep layer in bounds
    if(layer < 0) layer = 0;
    
    else buffer.get(layer).add(new Sprite(index, x, y, sw, sh, w, h, mirrored)); // add a new sprite object
  }
  void drawSprite(int index, float x, float y, int sw, int sh, float w, float h) {
    drawSprite(index, x, y, sw, sh, w, h, false);
  }
  
  void clear(int R, int G, int B) {
    background(R,G,B); // clear screen
    for(ArrayList<Sprite> l : buffer) { // clear each layer in buffer
      l.clear();
    }
  }
}
