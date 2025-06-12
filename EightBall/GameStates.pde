public class GameStates{
  private int playerTurn;
  private boolean playerOneFinal;
  private boolean playerTwoFinal;
  private Player player1;
  private Player player2;
  private Player currentPlayer;
  private PoolTable pt = new PoolTable(600,(int)(.6*(700-200) +.5),5);
  private int start0=0;
  private int start1=0;
  private Cue stick;
  private boolean easy = true;
  private boolean ballsAssigned = false;
  private boolean afterBreak = false;
  private PVector chosenPocket;
  private PVector currentSpin;
  private boolean resettingBall = false;
  private boolean mouseUp = true;
  public GameStates() {
    playerTurn = 0;
    playerOneFinal = false;
    playerTwoFinal = false;
  }
  
  public void start(String name1, String name2) {
    player1 = new Player(name1);
    player2 = new Player(name2);
    playerTurn = 0;
    pt.start();
    Ball white = new WhiteBall(150,350);
    stick =new Cue(white);
    pt.circles.add(0,white);
    currentPlayer = player1;
    currentSpin = new PVector(0,0);
  }
  
  public void renderGame() {
    pgame();
    if(resettingBall){ 
      pt.circ().get(0).setPosition(new PVector(mouseX,mouseY));
      pt.render();
      mouseUp = false;
    }else 
    if(!isGameOver()) {
      //visuals
      textSize(30);
      if(ballsAssigned) {
        if(player1.ballType == 0) {
          if(playerTurn == 0) {
           text("It is Player1's Turn(Solid)", 20,50);
        } else {
          text("It is Player2's Turn(Striped)", 20,50);
        }
        } else {
          if(playerTurn == 0) {
           text("It is Player1's Turn(Striped)", 20,50);
        } else {
          text("It is Player2's Turn(Solid)", 20,50);
        }
        }
      } else {
        if(playerTurn == 0) {
           text("It is Player1's Turn", 20,50);
        } else {
          text("It is Player2's Turn", 20,50);
        }
      }
      pt.render();
      if(!stick.stricken) {
        if(!mouseUp && !mousePressed){ //stored says mouse down, irl mouse up -->
          mouseUp = true;
        }
        if(mouseUp){
         stick.render();
        }
        if(easy) {
            stick.drawLine();
        }
        drawSpinInterface();
        spinControlKeys();
      }
      
      //game mechanics
      if(!ballsAssigned) {
        assignBallTypes();
      }
      if(isFinalShot()) {
        choosePocket(5);
        finalShot();
      }
      
      //turn switching
      if(isTurnOver()) {
        print("turn over, ");
        if(pt.whitePocketed()){
          pt.circ().add(0, new WhiteBall(mouseX,mouseY));
          print("addBall, ");
          resettingBall =true;
        }
        playerTurn = 1 - playerTurn; // Toggles 0/1
        if(playerTurn ==0) {
          currentPlayer = player1;
        } else {currentPlayer = player2;}
      } 
      //spawning a cue if necessary
      if(pt.ballStop() && stick.stricken) {
        respawnCue();
        pt.circles.get(0).setSpin(new PVector(0,0));
        currentSpin = new PVector(0,0);
        afterBreak = true;
      }
    }
  }
  public void wbset(int x, int y){
    //sets ball inc ureent position
    
      println("access granted");
   //   pt.circ().get(0).setPosition(new PVector(x,y));
   
      resettingBall=false;
    
  }
  public boolean isGameOver() {
    for(Ball e : pt.circles) {
      if(e.type() == 3) {
        return false;
      }
    } 
    return true;
  }
  
  public boolean isTurnOver() {
    if(stick.stricken && pt.ballStop()){
      if(ballsAssigned) {
          int count = 0;
          for(Ball ball: pt.circles) {
            if(ball.type() == currentPlayer.ballType) {
              count++;
            }
          }
          if(count == currentPlayer.getBallsLeft()) {
            return true;
          } else {
            currentPlayer.ballsLeft = count;
          }
          if(pt.whitePocketed()) {
            return true;
          }
        
        return false;
      } else {
        if(pt.whitePocketed()) {
            return true;
          }
        int count = 0;
        start0 =0;
        start1=0;
        for(Ball ball:pt.circles) {
          if(ball.type() == 1) {
            start1++;
            count++;
          }
          if(ball.type() == 0) {
            start0++;
            count++;
          }
        }
        if(count == 14) {
          
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }
  
  public void respawnWhiteBall(float x, float y) {
    //if(Ball)
    Ball a = new WhiteBall(x,y);
    pt.circles.add(0, a);
  }
  
  public void respawnCue() {
    stick = new Cue(pt.circles.get(0));
  }

  public boolean isFinalShot() {
     if(currentPlayer.getBallsLeft() == 0) return true;
     return false;
  }
  public void choosePocket(int index) {
    if (index >= 0 && index < pt.pocket.size()) {
      chosenPocket = pt.pocket.get(index);
    }
  }
  
  public void finalShot() {
    if (isFinalShot() && pt.ballStop()) {
      // Check if the black ball was pocketed
      Ball black = null;
      for (Ball b : pt.scoredBalls) {
        if (b.type() == 3) {
          black = b;
          break;
        }
      }
  
      if (black != null) {
        // Find which pocket it went into
        PVector blackPos = black.getPosition();
        for (PVector pocket : pt.pocket) {
          if (PVector.dist(blackPos, pocket) < pt.pocketRadius) {
            if (pocket == chosenPocket) {
              println(currentPlayer.getPlayerName() + " wins! Correct pocket.");
            } else {
              println(currentPlayer.getPlayerName() + " loses! Wrong pocket.");
            }
            return;
          }
        }
      } else {
        println("Black ball not pocketed. Turn over.");
      }
    }
  }
  public void assignBallTypes() {
  
  if(afterBreak && stick.stricken) {
    int count0 = 0;
    int count1 = 0;
    for(Ball b : pt.circles) {
      if(b.type() == 0) {
        count0++;
      } 
      if(b.type()==1) {
        count1++;
      }
    }
      if(count0 <start0) { // Only assign if it's a solid or striped ball
        if (playerTurn == 0) {
          player1.type(0);
          player2.type(1);
        } else {
          player2.type(0);
          player1.type(1);
        }
        ballsAssigned = true;
        return;
      }
      if(count1<start1) {
        if (playerTurn == 0) {
          player1.type(1);
          player2.type(0);
        } else {
          player2.type(0);
          player1.type(1);
        }
        ballsAssigned = true;
        return;
      }
    }
  }


//GETTERS
  public Cue getCue(){
    return this.stick;
  }
  public PoolTable getTable(){
    return this.pt;
  }
   
  public boolean getWBState(){
   return resettingBall; 
  }
  public void setWBState(boolean k){
   resettingBall = k; 
  }
  public void spinControlKeys() {
    PVector moveDir = new PVector(0, 0);    
    if (keyPressed) {
      if(keyCode == UP) {
        moveDir.y -= 1;
      }
      if(keyCode == DOWN) {
        moveDir.y += 1;
      }
      if(keyCode == LEFT) {
        moveDir.x -= 1;
      }
      if(keyCode == RIGHT) {
        moveDir.x += 1;
      }
    }
    
    if(moveDir.mag() > 0) {
      moveDir.normalize().mult(2);
      currentSpin.add(moveDir);
      if(currentSpin.mag() > 45) {
        currentSpin.normalize().mult(45);
      }
      updateSpin();
    }
  }  
  
 public void updateSpin() {
    Ball whiteBall = pt.circles.get(0);
    float distanceRatio = currentSpin.mag() / 45;
    PVector spinVec = currentSpin.copy();
    spinVec.y = -spinVec.y;  // Invert Y for proper physics
    spinVec.normalize();
    spinVec.mult(distanceRatio*.7);   
    whiteBall.setSpin(spinVec);
  }
  
 public void drawSpinInterface() {
    fill(255,255,255);
    ellipse(350, 600, 50, 50);
    fill(255, 0, 0);
    ellipse(350 + currentSpin.x, 600 + currentSpin.y,10, 10);
  }
  public void pgame(){ 
   ArrayList<String> debug = new ArrayList<String>();
   textSize(20);
   fill(0,255,255);
 debug.add("resettingBall: "+ resettingBall);
   for(int i=0;i<debug.size();i++){
     text(debug.get(i), width-220, height-(i+2)*20);
   }
 }

}
