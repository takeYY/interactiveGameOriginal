class Game
{
  float[] near,dist;
  Player player;
  Suporter[] suporter;
  HQ     hq;
  ArrayList<Bullet>bulletList;
  ArrayList<Enemy>enemyList;
  ArrayList<Boss>bossList;
  
  Game()
  {
    cursor(CROSS);
    hq=new HQ(75,2017,0,.575);
    bulletList=new ArrayList<Bullet>();
    enemyList=new ArrayList<Enemy>();
    bossList=new ArrayList<Boss>();
    player=new Player(25,height/2,50,0,width/2,height/2);
    suporter=new Suporter[2];
    for(int i=0;i<suporter.length;i++)
    suporter[i]=new Suporter(25,(1+2*i)*height/4,50,0);
    near=new float[suporter.length];
    dist=new float[118];
  }
  
  void draw()
  {
    background(0);
    
    hq.draw();
    
    player.draw(hq.x);
    
    //弾丸の配列
    for(int i=bulletList.size()-1;0<=i;i--)
    {
      Bullet bullet=bulletList.get(i);
      bullet.move();
      bullet.draw();
    }
    
    //敵の配列
    for(int i=enemyList.size()-1;0<=i;i--)
    {
      Enemy enemy=enemyList.get(i);
      for(int j=0;j<suporter.length;j++)
      {
        dist[i]=dist(suporter[j].x,suporter[j].y,enemy.x,enemy.y);
        if(dist[i]<near[j])
        {
          near[j]=dist[i];
          suporter[j].Mx=enemy.x;
          suporter[j].My=enemy.y;
        }
        if(i==0)
        near[j]=width*height;
      }
      enemy.move();
      enemy.draw();
    }
    
    //ボスの配列
    for(int i=bossList.size()-1;0<=i;i--)
    {
      Boss boss=bossList.get(i);
      boss.move();
      boss.draw(hq.x,hq.damage);
    }
    
    //弾丸と敵が衝突した際の動作
    for(int i=bulletList.size()-1;0<=i;i--)
    {
      for(int j=enemyList.size()-1;0<=j;j--)
      {
        Bullet bullet=bulletList.get(i);
        Enemy  enemies=enemyList.get(j);
        
        if(enemyCollision(enemies.x,enemies.y,enemies.d,enemies.d,
                          bullet.x,bullet.y,bullet.w,bullet.h))
        {
          bullet.enemyHit=1;
          enemies.hitPoints-=bullet.w;
        }
        bullet.needEnemyRemove();
        if(bullet.enemyHit==2)
        {
          bulletList.remove(i);
          fill(255);
          ellipse(bullet.x,bullet.y,50,50);
        }
        if((int)enemies.hitPoints<=0||
            enemies.x-enemies.d/2<hq.x)
          enemyList.remove(j);
        if(enemies.x-enemies.d/2<hq.x)
        hq.damage+=enemies.hitPoints;
      }
      
      //弾丸とボスが衝突した際の動作
      for(int j=bossList.size()-1;0<=j;j--)
      {
        Bullet bullet=bulletList.get(i);
        Boss   bosses=bossList.get(j);
        
        //弾丸とボスの衝突判定
        if(bossCollision(bosses.x,bosses.y,bosses.d,bosses.d,
                          bullet.x,bullet.y,bullet.w,bullet.h))
        {
          bullet.bossHit=1;
          bosses.hitPoints-=bullet.w;
        }
        bullet.needBossRemove();
        if(bullet.bossHit==2)
        {
          bulletList.remove(i);
          fill(255);
          ellipse(bullet.x,bullet.y,50,50);
        }
        if((int)bosses.hitPoints<=0||
            bosses.x-bosses.d/2<hq.x)
          bossList.remove(j);
        if(bosses.x-bosses.d/2<hq.x)
        hq.damage+=bosses.hitPoints;
      }
    }
    
    for(int i=0;i<suporter.length;i++)
    {
      if(keyPressed&&key==' '&&suporter[i].clicked==0)
      suporter[i].clicked=1;
      if(0<suporter[i].clicked&&suporter[i].clicked<20*fps)
      suporter[i].draw();
      if(20*fps<=suporter[i].clicked&&suporter[i].clicked<=30*fps)
      suporter[i].clicked++;
      if(30*fps<suporter[i].clicked)
      suporter[i].clicked=0;
    }
    fill(255);
    textSize(20);
    if((int)suporter[0].clicked==0)
    text("Suporters are available",width/2,40);
    else
    text("Cool down time is 00:"+(30*fps-(int)suporter[0].clicked)/60,
         width/2,40);
    
    if(frameCount%(fps/2)==0&&frameCount<=180*fps)
    enemyApear();
    if(frameCount%(20*fps)==0&&frameCount<=30*fps)
    bossApear();
    
    hq.bar();
    fill(255);
    if(0<(150*fps-frameCount)/fps)
    text("Game ends in "+(180*fps-frameCount)/fps+"s",9*width/10,9*height/10);
    
    if(5*fps<frameCount&&enemyList.size()==0&&bossList.size()==0)
    {
      state=CLEAR;
      result=new Result();
    }
    
    if(hq.hitPoints<=hq.damage)
    {
      state=GAME_OVER;
      result=new Result();
    }
  }
  
  void enemyApear()
  {
    Enemy enemy=new Enemy(random(width,2*width),random(100,height-100),
                          random(30,50),random(.5,2),random(30,50));
    enemyList.add(enemy);
  }
  
  void bossApear()
  {
    Boss boss=new Boss(random(2*width,2.5*width),random(300,height-300),
                       50,1,1000,20);
    bossList.add(boss);
    boss.guardians();
  }
}

boolean enemyCollision(float x1,float y1,float w1,float h1,
                       float x2,float y2,float w2,float h2)
{
  if(x1+w1/2<x2-w2/2||x2+w2/2<x1-w1/2) return false;
  if(y1+h1/2<y2-h2/2||y2+h2/2<y1-h1/2) return false;
  return true;
}



boolean bossCollision(float x1,float y1,float w1,float h1,
                       float x2,float y2,float w2,float h2)
{
  if(x1+w1/2<x2-w2/2||x2+w2/2<x1-w1/2) return false;
  if(y1+h1/2<y2-h2/2||y2+h2/2<y1-h1/2) return false;
  return true;
}



boolean guardiansCollision(float x1,float y1,float w1,float h1,
                       float x2,float y2,float w2,float h2)
{
  if(x1+w1/2<x2-w2/2||x2+w2/2<x1-w1/2) return false;
  if(y1+h1/2<y2-h2/2||y2+h2/2<y1-h1/2) return false;
  return true;
}