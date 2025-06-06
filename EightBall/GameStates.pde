public class GameStates{
  int playerTurn;
  boolean playerOneFinal;
  boolean playerTwoFinal;
  Player player1;
  Player player2;
  PoolTable pt = new PoolTable(width-100,(int)(.6*(width-50) +.5),5);
  int ballNum;
  
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
    Cue stick =new Cue(white);
    pt.circles.add(0,white);
  }
  
  public boolean isGameOver() {
    for(Ball e : pt.circles) {
      if(e.type() == 3) {
        return true;
      }
    } 
    return false;
  }
  
  public boolean isTurnOver() {
    //Work on ts func later
    
    if(pt.ballStop()) {
      for(Ball ball: pt.circles) {
      
      }
      if(pt.whitePocketed()) {
        return true;
      }
    }
    return false;
  }
  
  public void renderGame() {
    while(!isGameOver()) {
    
    
    }
    pt.render();
    textSize(30);
    if(playerTurn == 0) {
       text("It is Player1's Turn", 20,20);
    } else {
      text("It is Player2's Turn", 20,20);
    }
  }
 /* 
  public boolean isfinalShot(){
   int currentPlayerType;
    if (playerTurn == 0) {
      playerType = player1.type();
    } else {
      currentPlayerType = player2.type();
    }
    for(Ball b: pt.circles) {
      if(b.type() == currentPlayerType) return false;
    }
    return true;
  }*/
}
