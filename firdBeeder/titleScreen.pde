class TitleScreen {
  
  boolean gameStart;
  
  TitleScreen() {
    gameStart = false;
  }
  
  void draw() {
    
    float y = 10*sin((frameCount+50)/30.0);
    
    R.drawSprite(96, width/2 - 49, 60+10*sin((frameCount+50)/30.0), 49, 34, 49*2, 34*2);
    
    R.drawSprite(100, width/2 - 181, 158+10*sin((frameCount)/30.0), 181, 32, 181*2, 32*2);
    
    R.drawSprite(144, width/2 - 106, 240+10*sin((frameCount+10)/30.0), 106, 18, 106*2,18*2);
    
    if(mouseOver()) R.drawSprite(176, width/2 - 168, 340, 168, 36, 168*2,36*2);
    else R.drawSprite(224, width/2 - 168, 340, 168, 36, 168*2,36*2);
    
    if(mouseOver() && mousePressed) {
      game = new GameManager();
      gameStart = true;
    }
  }
  
  boolean mouseOver() {
    println(mouseX, mouseY);
    float x = width/2 - 168, y = 340, w = 168*2, h = 36*2;
    return (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h);
  }
  
}
