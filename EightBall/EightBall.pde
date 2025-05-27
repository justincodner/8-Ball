 //WhiteBall b = new WhiteBall(60,70);
  WhiteBall ball2 = new WhiteBall(100,100);
   Cue c = new Cue(ball2);
 PVector x = new PVector(220,220);
 
 Ball b1 = new Ball(50,50);
  Ball b2 = new Ball(55,90);
void setup() {
  size(500,700);
  frameRate(20);
  b1.setVelocity(new PVector(0,1));
}

void draw() {
  ball2.setVelocity(new PVector(10,10));
  ball2.render();
 // b.setPosition(x);
  background(100,200,50);  
 // b.render();
  c.render();
  /*
  //x.x += 10*Math.random()-5;  x.y += 10*Math.random()-5;
  b1.render();
  b2.render();
  if(Math.sqrt((b1.position.x-b2.position.x) * (b1.position.x-b2.position.x) + (b1.position.y - b2.position.y) * (b1.position.y - b2.position.y)) < 20) {
    b1.collision(b2);
  }
  */
  
}
void mousePressed(){
  c.setPower();
}
