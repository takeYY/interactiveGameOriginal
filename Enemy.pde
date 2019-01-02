class Enemy
{
  float x,
        y,
        d,
        vx,
        hitPoints;
  
  Enemy(float x,float y,float d,float vx,float hitPoints)
  {
    this.x=x;
    this.y=y;
    this.d=d;
    this.vx=vx;
    this.hitPoints=hitPoints;
  }
  
  void move()
  {
    x-=vx;
  }
  
  void draw()
  {
    fill(255,100,100);
    ellipse(x,y,d,d);
    
    textSize(d/2);
    fill(255);
    text((int)hitPoints,x,y);
  }
}