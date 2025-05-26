 WhiteBall b = new WhiteBall(60,60);
 Cue c = new Cue(b);
 PVector x = new PVector(220,220);
 
 Ball b1 = new Ball(50,50);
  Ball b2 = new Ball(55,90);
void setup() {
  size(500,700);
  frameRate(60);
  b1.setVelocity(new PVector(0,1));
}

void draw() {
  b.setPosition(x);
  background(100,200,50);  
  b.render();
  c.render();
  //x.x += 10*Math.random()-5;  x.y += 10*Math.random()-5;
  b1.render();
  b2.render();
  b1.updateVelocity();
  b2.updateVelocity();
  b1.updatePosition();
  b2.updatePosition();
  if(Math.sqrt((b1.position.x-b2.position.x) * (b1.position.x-b2.position.x) + (b1.position.y - b2.position.y) * (b1.position.y - b2.position.y)) < 20) {
    b1.transferVelocity(b2);
  }
  
}
void mousePressed(){
  c.setPower();
}
