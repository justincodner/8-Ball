  //WhiteBall ball2 = new WhiteBall(100,100);
   Cue c;
 PVector x = new PVector(220,220);
color red = color(0,0,255);
 Ball testingBall = new GameBall(250,250,1,red, 5);
 boolean debug=false; //toggle on for system print used to debug when error happens
PoolTable pt;

void setup() {
   size(600,700);
   pt = new PoolTable(width-100,(int)(.6*(width-50) +.5),5);
   
   Ball mball =new WhiteBall(150,350);
   pt.start();
   pt.addBall(mball);
   
  // pt.addBall(new Ball(160,300));
  // pt.addBall(new Ball(160,400)); 
   
   pt.getBall(0).setVelocity(new PVector(0,0));
   c = new Cue(pt.getBall(0));
     print("new cue");
  // pt.getBall(1).setVelocity(new PVector(0,0));
  //   pt.getBall(1).spin = new PVector(-1, -2);
   //****************
   frameRate(5);
   //****************
}

void draw() {
  //ball2.setVelocity(new PVector(10,10));  
  //  ball2.render();

  background(100,000,150);  
  pt.render();
  if(debug)
  print("render");
  pt.cscore(c);

  if(debug)
  print("pocket score");
  pt.wbounce();
  if(debug)
   print("wbounce");
  pt.getBall(0).render();
 //  c.render();
 // println("first ball render");

   if(!c.stricken) {
      c.render();
   }
   
  for(Ball a: pt.circ()){
   a.render(); 
  }
//  detectCollision(pt.getBall(1),pt.getBall(0));

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
void keyPressed(){
  if(keyCode == 32){
    frameRate(30);
  } else if(keyCode == ENTER){
    frameRate(1);
  } else if(keyCode == RIGHT){
    frameRate++;
    //println(frameRate);
  } else if(keyCode == LEFT){
    frameRate--;
  }
}
//for testing purposes
