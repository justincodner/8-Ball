import java.util.Scanner;
public class GameStates{
  private int playerTurn;
  int pocketIndex = -1;
  private boolean finalShot;
  private Player player1;
  private Player player2;
  private Player currentPlayer;
  private PoolTable pt = new PoolTable(width-100,(int)(.6*(width-200) +.5),5);
  private int start0=0;
  private int start1=0;
  private int prevStart = 14;
  private Cue stick;
  private boolean easy = true;
  private boolean ballsAssigned = false;
  private boolean afterBreak = false;
  private PVector chosenPocket;
  private PVector currentSpin;
  private boolean resettingBall = true;
  private boolean mouseUp = true;
  private boolean firstMove = true;
  private PVector finalBlackPos;
   
  
  public GameStates() {
    playerTurn = 0;
    finalShot = false;
  }
  
  public void start() {
    player1 = new Player();
    player2 = new Player();
    playerTurn = 0;
    pt.start();
    Ball white = new WhiteBall(150,350);
    stick =new Cue(white);
    pt.circles.add(0,white);
    currentPlayer = player1;
    currentSpin = new PVector(0,0);
    finalBlackPos = pt.circles.get(pt.circles.size()-1).position;
    
    
    
    //testing
    player1.type(0);
    player2.type(1);
    for(int i = 1; i < 15; i++) {
      pt.circles.remove(1);
    }
    ballsAssigned = true;
    player1.ballsLeft = 0;
    player2.ballsLeft = 0;
    //finalShot = true;
  }
  
  public void renderGame() {
    if(resettingBall){ 
      pt.circ().get(0).setPosition(new PVector(mouseX,mouseY));
      pt.render();
      mouseUp = false;
    }else 
    if(!isGameOver()) {
      //visuals
      fill(0,0,0);
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
            drawLine();
        }
        drawSpinInterface();
        spinControlKeys();
      }
      
      finalBlackPos = pt.circles.get(pt.circles.size()-1).position;
      if(isFinalShot()) {
        finalShot();
      }
      
      //game mechanics
      if(!ballsAssigned) {
        assignBallTypes();
      }
      
      //turn switching
      if(isTurnOver()) {
        if(pt.whitePocketed()){
          respawnWhiteBall(mouseX,mouseY);
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
    } else {
      
      if(finalShot) {
        for(int i = 0; i < 6; i++) {
          println(pt.pocket.get(i).x + " " + pt.pocket.get(i));
        }
        if(PVector.dist(chosenPocket, finalBlackPos)< 50) {
          print("pooop");
          playerTurn = 1 - playerTurn;
          finalShot = false;
        }
      }
      textAlign(CENTER);
      textSize(32);
      fill(255, 0, 0);
      String winnerName;
      String loserName;
      if (playerTurn == 0) {
      winnerName = "player2";
      loserName = "player1";
      } else {
        winnerName = "Player 1";
        loserName = "Player 2";
    }

    text(winnerName + " wins", width / 2, height / 2 - 20);
    text(loserName + " loses", width / 2, height / 2 + 20);

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
        if(count == prevStart) {
          return true;
        } else {
          prevStart = start0+start1;
          return false;
        }
      }
    }
    return false;
  }
  
  public void respawnWhiteBall(float x, float y) {
    Ball a = new WhiteBall(x,y);
    pt.circles.add(0, a);
    resettingBall =true;
  }
  
  public void respawnCue() {
    stick = new Cue(pt.circles.get(0));
  }
  public boolean isFinalShot() {
     if(currentPlayer.getBallsLeft() == 0) {
       finalShot = true;
       return true;
     } else {
       finalShot = false;
       return false;
       
     }
  }
  public void choosePocket(int index) {
    if (index >= 0 && index < pt.pocket.size()) {
      chosenPocket = pt.pocket.get(index);
    }
  }
public void finalShot() {

    // Map keys '1' to '6' to pocket indices 0-5
    textSize(32);
    fill(0);
    text("Final Shot: Call your pocket  (press keys 1 to 6):", width/2, 50);
    text("1  3  5\n2  4  6",width/2, 80);
    text("Aim for pocket: "+(pocketIndex+1), width/2, 150);
    choosePocket(pocketIndex);
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
  public void spinControlKeys() {
    PVector moveDir = new PVector(0, 0);    
    if(keyPressed) {
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
      moveDir.normalize();
      currentSpin.add(moveDir);
      if(currentSpin.mag() > 40) {
        currentSpin.normalize().mult(40);
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
    noStroke();
    fill(255,255,255);
    ellipse(350, 600, 50, 50);
    fill(255, 0, 0);
    ellipse(350 + currentSpin.x, 600 + currentSpin.y,10, 10);
  }
  
  public void toggleEasy() {
        if(easy) {
          easy = false;
        } else {
          easy = true;
        }
      }
  
  public void drawLine() {
    Ball ball = pt.circles.get(0);
    PVector start = ball.position.copy();
    PVector direction = new PVector(cos(-1*stick.getAngle() - PI/2), sin(-1*stick.getAngle() - PI/2));
    direction.normalize();
    PVector end = start.copy().add(PVector.mult(direction,15));
    Ball firstHitBall = null;
    PVector collisionPoint = null;



    //first line
    for(int steps = 0; steps<1000; steps++) {
      end.add(direction);
      if(get((int)end.x, (int)end.y) != color(40, 170, 20)) {
        break;
      }   
      for(Ball b : pt.circles) {
        if (b == ball) continue;
        float distance = PVector.dist(end, b.position);
        float minDistance = b.radius*2;
        if(distance <= minDistance) {
          firstHitBall = b;
          PVector toBall = PVector.sub(b.position, end);
          toBall.normalize();
          collisionPoint = PVector.add(end, PVector.mult(toBall, 10));
          steps = 1000;
          break;
          }
       }
    }
    stroke(255);
    strokeWeight(2);
    line(start.x, start.y, end.x, end.y);


    //second line
    if(firstHitBall != null) {
      PVector hitDirection = PVector.sub(firstHitBall.position, end);
      hitDirection.normalize(); 
      noFill();
      stroke(255);
      ellipse(collisionPoint.x, collisionPoint.y, 8, 8);
      PVector hitStart = firstHitBall.position.copy();
      PVector hitEnd = hitStart.copy();
      hitEnd.add(PVector.mult(hitDirection,15));
      for(int steps = 0; steps < 1000; steps++) {
        hitEnd.add(hitDirection);
        if(get((int)hitEnd.x, (int)hitEnd.y) != color(40, 170, 20)) {
          break;
        }
      }
      stroke(255);
      strokeWeight(2);
      line(hitStart.x, hitStart.y, hitEnd.x, hitEnd.y);  
    }
  }

}
