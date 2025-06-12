GameStates game;
void setup() {
 game = new GameStates();
   size(700,700);
   frameRate(130);
   
   game.start();
   /*
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
   */
}

void draw() {
//  println("start draw =======");
  background(120,70,250); 
  //print("made background, ");
  game.renderGame();
  
}
void mousePressed(){

  if(game.getWBState()){
    print("final set ball");
    game.wbset(mouseX,mouseY);

  } else {
    print("setting cue power ========, ");
  //  game.getCue().setPower();
  }
}
void keyPressed(){
  if(key == ' ') {
    game.toggleEasy();
  }
  if(keyCode == 32){
    frameRate(30);
  } else if(keyCode == ENTER){
    frameRate(2);
  } else if(key == 'u'){
       frameRate(60);
  }
  if(key == 'R'||key== 'r'){
    println("key pressed r");
  }
 // if(key == 'r' && game.getTable().getScoredBalls().indexOf(mball) == -1){
    if(key == 'r'){
    game.getCue().reset();
    println("reset done...");
  }
}
