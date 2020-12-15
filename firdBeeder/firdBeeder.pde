PImage spriteSheet;
Renderer R;

void setup() {
  spriteSheet = loadImage("Assets/spriteSheet.png"); // load sprite sheet
  R = new Renderer(200); // initialize the renderer with 200 layers
  
  size(400,400);
  smooth(0); // turns off image smoothing for clean pixel art
}

void draw() {
  R.clear(0,0,0); // clears screen and buffer
  
  
  
  R.render(); // renders sprites
}
