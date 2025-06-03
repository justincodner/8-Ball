  //WhiteBall ball2 = new WhiteBall(100,100);
   Cue c;
 PVector x = new PVector(220,220);
color red = color(0,0,255);
PoolTable pt;

void setup() {
   size(600,700);
   pt = new PoolTable(width-100,(int)(.6*(width-50) +.5),5);
   
   Ball mball =new WhiteBall(150,350);
   pt.start();
   pt.addBall(mball);
   //pt.addBall(new Ball(160,300));
   //pt.addBall(new Ball(160,400)); 
   print("adasddkdas");
   //pt.getBall(0).setVelocity(new PVector(0,0));
   c = new Cue(pt.getBall(pt.circles.size()-1));
   //pt.getBall(1).setVelocity(new PVector(0,0));
//   pt.getBall(1).spin = new PVector(-1, -2);
   //============================
   frameRate(20);
   //===========================
}

void draw() {
  //ball2.setVelocity(new PVector(10,10));  
  //  ball2.render();

  background(100,000,150);  
  pt.render();
  pt.cscore(c);
  //pt.wbounce();
  //pt.getBall(0).render();
   //c.render();
  
   if(!c.stricken) {
     
      c.render();
   }
   
  //x.x += 10*Math.random()-5;  x.y += 10*Math.random()-5;
  
  
  //detectCollision(pt.getBall(1),pt.getBall(0));
  /*for(int i=0; i< pt.circ().size();i++){
     println("qweq");
     for(int k=i; k< pt.circ().size();k++){
        println("qweq");
        detectCollision(pt.getBall(k),pt.getBall(i));
         
     }
  } 
  */
 
  //pool table
  
}
void mousePressed(){
  c.setPower();
}
//for testing purposes
