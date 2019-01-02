class Suporter extends Player
{
  Suporter(float x,float y,float d,float clicked)
  {
    super(x,y,d,clicked,0,0);
  }
  
  void draw()
  {
    fill(255,0,255);
    ellipse(x,y,d,d);
    
    clicked++;
    
    if(0<clicked&&frameCount%(fps/6)==0)
    {
      bulletShoot();
    }
    aim();
  }
  
  void aim()
  {
    strokeWeight(5);
    if(0<clicked)
    {
      stroke(255,0,0);
      line(x,y,Mx,My);
    }
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
}