PImage spriteSheet;
Renderer R;
GameManager game;

float GRAV = 1;

void setup() {
  spriteSheet = loadImage("Assets/spriteSheet.png"); // load sprite sheet
  R = new Renderer(200); // initialize the renderer with 200 layers
  
  game = new GameManager();
  
  size(400,500);
  smooth(0); // turns off image smoothing for clean pixel art
  frameRate(30);
}

void draw() {
  R.clear(180,180,180); // clears screen and buffer
  
  game.gameLoop();
  
  R.render(); // renders sprites
  
  //display score
  textSize(32);
  fill(0);
  text(game.score, 350, 50);
  
  
}

void mousePressed() {
  // if(has enough money)
  if (mouseButton == LEFT && mouseY < height - 36) {
    for(int i = 0; i < game.seedsPerClick; i++) game.seeds.add(new Seed(game.mouse.x, game.mouse.y, 1));
    // game.money -= game.costPerSeed * game.seedsPerClick;
  }
}
