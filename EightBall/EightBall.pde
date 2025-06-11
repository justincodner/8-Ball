GameStates game = new GameStates();

void setup() {
   size(700,700);
   frameRate(120);
   
   game.start("dylan","bob");
   /*
   pt = new PoolTable(width-200,(int)(.6*(width-200) +.5),5);
   println("# BALLS:"+pt.circ().size());
   Ball mball =new WhiteBall(124,350);
   pt.start();
   pt.addBall(0,mball);
   
   pt.getBall(0).setVelocity(new PVector(0,0));
   c = new Cue(pt.getBall(0));
   //****************
   frameRate(3000);
   //****************
   println("# BALLS:"+pt.circ().size());
   */
}

void draw() {
  println("start draw =======");

  background(100,000,150); 
  game.renderGame();
  /*
  pt.wbounce();
  if(debug)
   print("wbounce, ");
  pt.render();
  if(debug) 
  print("pt render, ");
  pt.cscore(c);

  if(debug){
  print("pocket score");
  
   println("bound top: " + pt.topBound(pt.circ().get(0)));
    println("bound bottom: " + pt.bottomBound(pt.circ().get(0)));
     println("left bound: " + pt.leftBound(pt.circ().get(0)));
      println("right bound: " + pt.rightBound(pt.circ().get(0)));
  }

 // println("first ball render");

   if(!c.stricken) {
      c.render();
   }
 
  //pool table
  */
  
}
void mousePressed(){
  game.stick.setPower();
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
