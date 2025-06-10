Cue c;
PVector x = new PVector(220,220);
color red = color(0,0,255);
Ball testingBall = new GameBall(250,250,1,red, 5);
boolean debug=false; //toggle on for system print used to debug when error happens
//boolean debug=true;
PoolTable pt;
Ball mball;

GameStates game = new GameStates();
void setup() {
   size(700,700);
   
   
   pt = new PoolTable(width-200,(int)(.6*(width-200) +.5),5);

    println("# BALLS:"+pt.circ().size());
   mball =new WhiteBall(200,350);
   pt.start();
   pt.addBall(0,mball);
   
   pt.getBall(0).setVelocity(new PVector(0,0));
   c = new Cue(pt.getBall(0));
   //****************
   frameRate(120);
   //****************
   println("# BALLS:"+pt.circ().size());
   
}

void draw() {
  if(debug)
  println("start draw =======");
  background(100,000,150); 
  pt.render();
  if(debug) {
  print("pt render, ");
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
    frameRate+=5;
    //println(frameRate);
  } else if(keyCode == LEFT){
    frameRate-=5;
  }
  if(key == 'R'||key== 'r'){
    println("key pressed r");
  }
  if(key == 'r' && pt.getScoredBalls().indexOf(mball) == -1){
    c.reset();
  }
}
//for testing purposes
