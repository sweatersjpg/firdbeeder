/*

FIRD BEEDER by
Chris, Cody, Raul, and Sam

A lot of this is uncommented because I ran out of time adding extra features

click to place seeds and watch the magic happen, it starts slow but has an exponential progression

*/



PImage spriteSheet;
Renderer R;
GameManager game;
TitleScreen title;

void setup() {
  spriteSheet = loadImage("Assets/spriteSheet.png"); // load sprite sheet
  R = new Renderer(200); // initialize the renderer with 200 layers
  
  game = new GameManager();
  title = new TitleScreen();
  
  size(400,500);
  smooth(0); // turns off image smoothing for clean pixel art
  frameRate(30);
}

void draw() {
  if(title.gameStart) {
    R.clear(180,180,180); // clears screen and buffer
    game.gameLoop();
  } else {
    R.clear(0,0,0); // clears screen and buffer
    title.draw();
  }
  
  R.render(); // renders sprites
  
  if(title.gameStart) game.ui.drawText();
  
}

void mousePressed() {
  if(game.costPerSeed * game.seedsPerClick <= game.monies && mouseButton == LEFT && mouseY < height - 36) {
    for(int i = 0; i < game.seedsPerClick; i++) game.seeds.add(new Seed(game.mouse.x, game.mouse.y, 1));
    game.monies -= game.costPerSeed * game.seedsPerClick;
  }
}
