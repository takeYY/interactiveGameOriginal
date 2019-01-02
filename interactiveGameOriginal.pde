final int  MAIN_MENU=0,
           GAME=1,
           CLEAR=2,
           GAME_OVER=3,
           fps=60;
int        state=MAIN_MENU;

//グローバル定数
MainMenu mainMenu;
Game game;
Result result;

void setup()
{
  size(1280,720);
  noStroke();
  textAlign(CENTER,CENTER);
  rectMode(CENTER);
  frameRate(fps);
  
  mainMenu=new MainMenu();
}

void draw()
{
  switch(state)
  {
    case MAIN_MENU:
    mainMenu.draw();
    break;
    
    case GAME:
    game.draw();
    break;
    
    case CLEAR:
    result.draw();
    break;
    
    case GAME_OVER:
    result.draw();
    break;
  }
}