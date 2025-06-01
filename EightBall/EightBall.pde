
WhiteBall b = new WhiteBall(160,170);
  WhiteBall ball2 = new WhiteBall(100,100);
   Cue c = new Cue(b);
 PVector x = new PVector(220,220);
 

 Ball b1 = new WhiteBall(160,300);
  Ball b2 = new WhiteBall(160, 400);

PoolTable pt;

void setup() {
  size(500,500);
  pt = new PoolTable(width-50,(int)(.6*(width-50) +.5),5);
println("8ball w:"+width);  frameRate(60);
  b1.setVelocity(new PVector(0,0));

  b.setVelocity(new PVector(0,4));
  b.spin = new PVector(-1,4);
}

void draw() {
  //ball2.setVelocity(new PVector(10,10));
  
  ball2.render();
  background(100,000,150);  
   pt.render();
  b.render();
  if(!c.stricken) {
    c.render();
  } 
  
  //x.x += 10*Math.random()-5;  x.y += 10*Math.random()-5;
 
  b1.render();
  b2.render();
  detectCollision(b1,b2);
  detectCollision(b,b1);
  detectCollision(b,b2);
  
  //pool table
  
}
void mousePressed(){
  c.setPower();
}
//for testing purposes
void detectCollision(Ball b1, Ball b2) {
  if(Math.sqrt((b1.position.x-b2.position.x) * (b1.position.x-b2.position.x) + (b1.position.y - b2.position.y) * (b1.position.y - b2.position.y)) < 20) {
    b1.collision(b2);
    b1.transferSpin(b2);
  } 
}
