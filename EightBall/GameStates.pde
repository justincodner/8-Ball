public class GameStates{
  int playerTurn;
  boolean playerOneFinal;
  boolean playerTwoFinal;
  Player player1;
  Player player2;
  PoolTable pt = new PoolTable(width-100,(int)(.6*(width-50) +.5),5);
  
  
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
  }
}
