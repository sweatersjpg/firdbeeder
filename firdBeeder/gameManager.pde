//gameManager works as background functionality for many of the overlapping and interacting elements of the game.
//This class mostly calls other classes and objects and puts them in Arrays, or updates their positions/draws based
//on the PVectors that are present in each individual class.

class gameManager {
  Background background; //calls the Background class for later use
  ArrayList<Seed> seeds; //initializes object array lists
  ArrayList<Bird> birds;
  
  GameManager() {
    worldX = 0; //initial position of all objects at 0
    worldY = 0; //same as above
    seeds = new ArrayList<Seed>(); //creates a list of Seed objects that can be added or subtracted from
    birds = new ArrayList<Bird>(); //creates a list of Bird objects that can be added or subtracted from
  
    background = new Background();  
  }
  
  void gameLoop() {
    background.move(); //positioning the background image based on the movement of the mouse and prior positioning
    background.display; //calling the Background class to display the background image
    for(Seed s:seeds) s.update(); //updating Seed positions based on gravity and Bird consumptions
    for(Bird b:birds) b.update(); //updating Bird positions based on velocities
    for(Seed s:seeds) s.draw(); //drawing Seeds with new positions
    for(Bird b:birds) b.draw(); //drawing Seeds with new positions
  }
}
