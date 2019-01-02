class Bullet
{
  float x,
        y,
        angle,
        speed,
        w,
        h;
  int   enemyHit=0,
        bossHit=0,
        guardiansHit=0;
  
  Bullet(float x,float y,float angle,float speed,float w,float h)
  {
    this.x=x;
    this.y=y;
    this.angle=angle;
    this.speed=speed;
    this.w=w;
    this.h=h;
  }
  
  void move()
  {
    angle=angle%360;
    x+=cos(radians(angle))*speed;
    y+=sin(radians(angle))*speed;
  }
  
  void draw()
  {
    fill(255);
    ellipse(x-w/2,y,w,h);
  }
  
  void needEnemyRemove()
  {
    if(x<0||width<x||y<0||height<y||enemyHit==1)
    enemyHit=2;
  }
  
  void needBossRemove()
  {
    if(x<0||width<x||y<0||height<y||bossHit==1)
    bossHit=2;
  }
  
  void needGuardiansRemove()
  {
    if(x<0||width<x||y<0||height<y||guardiansHit==1)
    guardiansHit=2;
  }
}