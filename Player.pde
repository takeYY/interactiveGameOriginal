class Player
{
  float x,
        y,
        d,
        angle,
        Mx,
        My,
        clicked;
  boolean isShotgun = false;
  
  Player(float x,float y,float d,float clicked,float Mx,float My)
  {
    this.x=x;
    this.y=y;
    this.d=d;
    this.clicked=clicked;
    this.Mx=Mx;
    this.My=My;
  }
  
  void draw(float hqX)
  {
    fill(0,0,255);
    ellipse(x,y,d,d);
    keyPressed();
    
    if(mousePressed)
    {
      clicked++;
      Mx=mouseX;
      My=mouseY;
    }
    
    if(!isShotgun)
    {
      fill(255);
      text("1",x,y-d);
      if(hqX<Mx&&frameCount%(fps/12)==0)
      {
        bulletShoot();
        clicked++;
      }
    }else
    {
      fill(255);
      text("2",x,y-d);
      if(hqX<Mx&&frameCount%fps/24==0)
      {
        bulletShoot();
        clicked++;
      }
    }
    
    aim();
  }
  
  void aim()
  {
    strokeWeight(5);
    if(mousePressed||0<clicked)
    {
      stroke(255,0,0);
      line(x,y,Mx,My);
    }
    stroke(0,255,0);
    line(x,y,mouseX,mouseY);
    noStroke();
  }
  
  void bulletShoot()
  {
    angleUpdate(Mx,My);
    Bullet bullet=new Bullet(x,y,random(angle-5,angle+5),3,20,20);
    game.bulletList.add(bullet);
  }
  
  void angleUpdate(float mx,float my)
  {
    angle=degrees(atan2(my-y,mx-x));
  }
  
  void keyPressed()
  {
    if(key=='2')
    {
      isShotgun = true;
    }else if(key=='1')
    {
      isShotgun = false;
    }
  }
}