class Guardians
{
  float x,
        y,
        d,
        r,
        rad,
        theta,
        hitPoints;
        
  Guardians(float x,float y,float d,float theta,float r,float hitPoints)
  {
    this.x=x;
    this.y=y;
    this.d=d;
    this.theta=theta;
    this.r=r;
    this.hitPoints=hitPoints;
  }
  
  void move()
  {
    rad=radians(theta);
    x=r*cos(rad);
    y=-r*sin(rad);
    theta+=2;
  }
  
  void draw(float X,float Y)
  {
    fill(255,0,0);
    ellipse(x+X,y+Y,d,d);
  }
}