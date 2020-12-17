//gameManager works as background functionality for many of the overlapping and interacting elements of the game.
//This class mostly calls other classes and objects and puts them in Arrays, or updates their positions/draws based
//on the PVectors that are present in each individual class.

class GameManager {
  Background background; //calls the Background class for later use
  ArrayList<Seed> seeds; //initializes object array lists
  ArrayList<Bird> birds;
  ArrayList<Coin> coins;
  PVector camera;
  PVector mouse;
  
  int score;
  
  GameManager() {
    camera = new PVector(0,0);
    mouse = new PVector(0,0);
    
    seeds = new ArrayList<Seed>(); //creates a list of Seed objects that can be added or subtracted from
    birds = new ArrayList<Bird>(); //creates a list of Bird objects that can be added or subtracted from
    coins = new ArrayList<Coin>();
    background = new Background();
    
    //score begins at 0
    score = 0;
  }
  
  void gameLoop() {
    background.update(); //positioning the background image based on the movement of the mouse and prior positioning
    background.draw(); //calling the Background class to display the background image
    
    spawnCycle();
    
    mouse.set(mouseX, mouseY).add(camera);
    
    //if(mousePressed && frameCount%2==0) seeds.add(new Seed(mouseX, mouseY, 1));
    
    for(Seed s:seeds) s.update(); //updating Seed positions based on gravity and Bird consumptions
    
    // we loop through birds backwards so they can delete themselves without error
    for(int i=birds.size()-1;i>=0;i--) birds.get(i).update(); //updating Bird positions based on velocities
    for(int i=coins.size()-1;i>=0;i--) coins.get(i).update(); //updating coins position and checking mouse over
    
    for(Seed s:seeds) s.draw(); //drawing Seeds with new positions
    for(Bird b:birds) b.draw(); //drawing Seeds with new positions
    for(Coin c:coins) c.draw(); //drawing Seeds with new positions
        
  }
  
  void spawnCycle() { //initiates spawn parameters for the Bird class
    if(seeds.size()/(birds.size()+1) > 5) { //activates the function when a certain number of seeds are generated: in this case, six
      birds.add(new Bird()); //when the six seeds have been created, spawns in a bird by calling in class Bird
    }
  }
  
  void coinGrab() {
   //if the mouse collides with the coin position
   //send the coin to the bottom left using a PVector
   //1 frame at a time
   //if the coin collides with the bottom left PVector location
   //despawn the coin
    
    
  }
}
