public class GameStates{
  int playerTurn;
  boolean playerOneFinal;
  boolean playerTwoFinal;
  Player player1;
  Player player2;
  Player currentPlayer = player1;
  PoolTable pt = new PoolTable(width-100,(int)(.6*(width-50) +.5),5);
  int ballNum;
  Cue stick;
  boolean easy;
  
  
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
    if(pt.ballStop()) {
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
    }
    return false;
  }
  
  public void respawnWhiteBall(float x, float y) {
    Ball a = new WhiteBall(x,y);
    pt.circles.add(0, a);
  }
  
  public void respawnCue() {
    Cue stick = new Cue(pt.circles.get(0));
  }
  
  public void renderGame() {
    if(!isGameOver()) {
      
    //visuals
    textSize(30);
    if(playerTurn == 0) {
       text("It is Player1's Turn", 20,20);
    } else {
      text("It is Player2's Turn", 20,20);
    }
    pt.render();
    if(!stick.stricken) {
      stick.render();
      if(easy) {
          stick.drawLine();
      }
    }
    
    //game mechanics
    
    
    //add in final shot mechanics here
    if(playerTurn == 0) {
      if(isTurnOver()) {
        currentPlayer = player2;
        playerTurn = 1;
        if(pt.whitePocketed()) {
          respawnWhiteBall(150,350);
        }
      }
      
    } else {
      if(isTurnOver()) {
        currentPlayer = player1;
        playerTurn = 0;
        if(pt.whitePocketed()) {
          respawnWhiteBall(150,350);
        }
      }
    
    }
      
    //spawning a cue if necessary
    if(pt.ballStop() && stick.stricken) {
      respawnCue();
    }
    
    
    
    
    }
  }

  public boolean isFinalShot() {
     if(currentPlayer.getBallsLeft() == 0) return true;
     return false;
  }
  
  public void finalShot(){
    if(isFinalShot() == true) {
      
    }
  }

/*
  public boolean isfinalShot(){
    for(Ball e: pt.circles){
   //   if(player1.type(1) == e.type() || player2.type(0) == e.type()) return false;

   int currentPlayerType;
    if (playerTurn == 0) {
      playerType = player1.type();
    } else {
      currentPlayerType = player2.type();
    }
    for(Ball b: pt.circles) {
      if(b.type() == currentPlayerType) 
      return false;
    }
    return true;
  }
}
 public boolean isfinalShot(){
    if(player1.getBallsLeft() == 0 || player2.getBallsLeft(2) == 0)
    return true;
    return false;
  }
  public void changeTurn() {
    if(isTurnOver() == true){}
    
  }
  
  public void choosePocket(){
    if(isFinalShot == true){} 
  }
  */
}
