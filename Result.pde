class Result
{
  
  void draw()
  {
    fill(0,15);
    rect(width/2,height/2,width,height);
    
    filter(BLUR);
    fill(255);
    textSize(50);
    if(state==CLEAR)
    {
      text("Game Clear!!",width/2,5*height/11);
      textSize(35);
      text("Press R key to go to Main Menu",width/2,6*height/11);
    } else
    {
      text("Game Over!!",width/2,5*height/11);
      textSize(35);
      text("Tips:Press SPACE key to use Suporters",width/2,6*height/11);
      text("Press R key to go to Main Menu",width/2,7*height/11);
    }
    
    if(keyPressed&&key=='r')
    {
      state=MAIN_MENU;
      setup();
    }
  }
}