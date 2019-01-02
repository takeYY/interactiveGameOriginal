class HQ
{
  float x,
        hitPoints,
        damage,
        ratio;
  
  HQ(float x,float hitPoints,float damage,float ratio)
  {
    this.x=x;
    this.hitPoints=hitPoints;
    this.damage=damage;
    this.ratio=ratio;
  }
  
  void draw()
  {
    fill(0,200,255);
    rect(x/2,height/2,x,height);
  }
  
  void bar()
  {
    rectMode(CORNER);
    stroke(255);
    strokeWeight(2);
    fill(255);
    rect(60,10,ratio*hitPoints,20);
    fill(0,255,0);
    rect(60,10,ratio*(hitPoints-damage),20);
    noStroke();
    rectMode(CENTER);
    
    fill(0);
    textSize(20);
    text((int)hitPoints-(int)damage,width/2,20);
  }
}