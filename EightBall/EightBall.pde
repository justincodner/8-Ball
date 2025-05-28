 WhiteBall b = new WhiteBall(60,70);
  WhiteBall ball2 = new WhiteBall(100,100);
   Cue c = new Cue(b);
 PVector x = new PVector(220,220);
 
 Ball b1 = new Ball(119.8,300);
  Ball b2 = new Ball(100, 400);
void setup() {
  size(500,700);
  frameRate(60);
  b1.setVelocity(new PVector(0,3));
}

void draw() {
  //ball2.setVelocity(new PVector(10,10));
  ball2.render();
  background(100,200,50);  
  b.render();
  if(!c.stricken) {
    c.render();
  } 
  
  //x.x += 10*Math.random()-5;  x.y += 10*Math.random()-5;
  int count = 0;
  if(Math.sqrt((b1.position.x-b2.position.x) * (b1.position.x-b2.position.x) + (b1.position.y - b2.position.y) * (b1.position.y - b2.position.y)) < 20 && count == 0) {
    b1.collision(b2);
    count++;
  }
  b1.render();
  b2.render();
  
  
}
void mousePressed(){
  c.setPower();
}
