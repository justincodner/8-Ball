public class GameStates{
  int playerTurn;
  boolean playerOneFinal;
  boolean playerTwoFinal;
  Player player1;
  Player player2;
  Player currentPlayer;
  PoolTable pt = new PoolTable(700-200,(int)(.6*(700-200) +.5),5);
  int ballNum;
  int start0=0;
  int start1=0;
  Cue stick;
  boolean easy = true;
  boolean ballsAssigned = false;
  boolean afterBreak = false;
  PVector chosenPocket;
  
  
  public GameStates() {
    playerTurn = 0;
    playerOneFinal = false;
    playerTwoFinal = false;
  }
  
  public void start(String name1, String name2) {
    player1 = new Player(name1);
    player2 = new Player(name2);
    playerTurn = 0;
    player1.turn = true;
    player2.turn = false;
    pt.start();
    Ball white = new WhiteBall(150,350);
    stick =new Cue(white);
    pt.circles.add(0,white);
    currentPlayer = player1;
  }
  
  public void renderGame() {
    if(!isGameOver()) {
      
    
      //visuals
      textSize(30);
      if(ballsAssigned) {
        if(player1.ballType == 0) {
          if(playerTurn == 0) {
           text("It is Player1's Turn(Solid)", 20,20);
        } else {
          text("It is Player2's Turn(Striped)", 20,20);
        }
        } else {
          if(playerTurn == 0) {
           text("It is Player1's Turn(Striped)", 20,20);
        } else {
          text("It is Player2's Turn(Solid)", 20,20);
        }
        }
      } else {
        if(playerTurn == 0) {
           text("It is Player1's Turn", 20,20);
        } else {
          text("It is Player2's Turn", 20,20);
        }
      }
      pt.render();
      if(!stick.stricken) {
        stick.render();
        if(easy) {
            stick.drawLine();
        }
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
        if(pt.whitePocketed()) {
          respawnWhiteBall(150, 350);
        }
        
        playerTurn = 1 - playerTurn; // Toggles 0/1
        if(playerTurn ==0) {
          currentPlayer = player1;
        } else {currentPlayer = player2;}
      }
        
      //spawning a cue if necessary
      if(pt.ballStop() && stick.stricken) {
        respawnCue();
        afterBreak = true;
      }
      
    
    }

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


   public void spinInterface() {
    
   }  

}
