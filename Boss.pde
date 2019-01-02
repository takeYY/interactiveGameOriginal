class Boss extends Enemy
{
  int   n;
  
  ArrayList<Guardians>guardiansList;      
        
  Boss(float x,float y,float d,float vx,float hitPoints,int n)
  {
    super(x,y,d,vx,hitPoints);
    
    this.n=n;
    
    guardiansList=new ArrayList<Guardians>();
  }
  
  void move()
  {
    x-=vx;
  }
  
  void draw(float hqX,float hqD)
  {
    fill(255,0,0);
    ellipse(x,y,d,d);
    
    textSize(d/4);
    fill(255);
    text((int)hitPoints,x,y);
    
    //子分の配列
    for(int i=guardiansList.size()-1;0<=i;i--)
    {
      Guardians guardians=guardiansList.get(i);
      guardians.move();
      guardians.draw(x,y);
    }
    
    //弾丸と子分の衝突
    for(int i=game.bulletList.size()-1;0<=i;i--)
    { 
      for(int j=guardiansList.size()-1;0<=j;j--)
      {
        Bullet bullet=game.bulletList.get(i);
        Guardians guardians=guardiansList.get(j);
        if(guardiansCollision(guardians.x+x,guardians.y+y,
                              guardians.d,guardians.d,
                              bullet.x,bullet.y,
                              bullet.w,bullet.h))
        {
          bullet.guardiansHit=1;
          guardians.hitPoints-=bullet.w;
        }
        bullet.needGuardiansRemove();
        if(bullet.guardiansHit==2)
        {
          game.bulletList.remove(i);
          fill(255);
          ellipse(bullet.x,bullet.y,50,50);
        }
        if((int)guardians.hitPoints<=0||
            guardians.x+x-guardians.d/2<hqX)
        guardiansList.remove(j);
        
        if(guardians.x+x-guardians.d/2<hqX)
        hqD+=guardians.hitPoints;
      }
    }
  }
  
  void guardians()
  {
    for(int i=0;i<n;i++)
    {
      Guardians guardians=new Guardians((360/n)*(i+1),(360/n)*(i+1),10,
                               (360/n)*(i+1),100,hitPoints/10);
      guardiansList.add(guardians);
    }
  }
}