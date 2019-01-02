class MainMenu
{
  
  void draw()
  {
    fill(0,15);
    rect(width/2,height/2,width,height);
    
    textSize(75);
    fill(255);
    text("Defence Game",width/2,height/2);
    
    textSize(20);
    text("click to play game",width/2,7*height/11);
    
    if(mousePressed)
    {
      frameCount=0;
      state=GAME;
      game=new Game();
    }
  }
}