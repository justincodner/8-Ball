GameStates game;
void setup() {
 game = new GameStates();
   size(900,700);
   frameRate(130);
   
   game.start();
}

void draw() {
//  println("start draw =======");
  background(100,000,150); 
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
