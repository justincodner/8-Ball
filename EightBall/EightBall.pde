  //WhiteBall ball2 = new WhiteBall(100,100);
   Cue c;
 PVector x = new PVector(220,220);
color red = color(0,0,255);
 Ball testingBall = new GameBall(250,250,1,red, 5);
 boolean debug=false; //toggle on for system print used to debug when error happens
PoolTable pt;

void setup() {

   size(700,700);
   pt = new PoolTable(width-200,(int)(.6*(width-200) +.5),5);
    println("# BALLS:"+pt.circ().size());
   Ball mball =new WhiteBall(105,350);
   pt.start();
   pt.addBall(0,mball);
   
    println("# BALLS:"+pt.circ().size());
   pt.getBall(0).setVelocity(new PVector(0,-6));
   c = new Cue(pt.getBall(0));
   //****************
   frameRate(60);
   //****************
   println("# BALLS:"+pt.circ().size());
}

void draw() {
  println("start draw =======");
  //ball2.setVelocity(new PVector(10,10));  
  //  ball2.render();

  background(100,000,150); 
  pt.wbounce();
  pt.render();
  if(debug) 
  print("render");
  //pt.cscore(c);

  if(debug){
  print("pocket score");
  
   println("bound top: " + pt.topBound(pt.circ().get(0)));
    println("bound bottom: " + pt.bottomBound(pt.circ().get(0)));
     println("left bound: " + pt.leftBound(pt.circ().get(0)));
      println("right bound: " + pt.rightBound(pt.circ().get(0)));
  }
  
  if(debug)
   print("wbounce");

 // println("first ball render");

   if(!c.stricken) {
      c.render();
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
