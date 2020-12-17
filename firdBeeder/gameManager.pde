//gameManager works as background functionality for many of the overlapping and interacting elements of the game.
//This class mostly calls other classes and objects and puts them in Arrays, or updates their positions/draws based
//on the PVectors that are present in each individual class.

class GameManager {
  Background background; //calls the Background class for later use
  ArrayList<Seed> seeds; //initializes object array lists
  ArrayList<Bird> birds;
  PVector world = new PVector();
  
  GameManager() {
    seeds = new ArrayList<Seed>(); //creates a list of Seed objects that can be added or subtracted from
    birds = new ArrayList<Bird>(); //creates a list of Bird objects that can be added or subtracted from
    background = new Background();  
  }
  
  void gameLoop() {
    background.update(); //positioning the background image based on the movement of the mouse and prior positioning
    background.draw(); //calling the Background class to display the background image
    
    //if(mousePressed && frameCount%2==0) seeds.add(new Seed(mouseX, mouseY, 1));
    
    for(Seed s:seeds) s.update(); //updating Seed positions based on gravity and Bird consumptions
    for(Bird b:birds) b.update(); //updating Bird positions based on velocities
    for(Seed s:seeds) s.draw(); //drawing Seeds with new positions
    for(Bird b:birds) b.draw(); //drawing Seeds with new positions
  }
}
