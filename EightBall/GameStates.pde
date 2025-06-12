import java.util.Scanner;

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
  private int prevStart = 14;
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
    //if(Ball)
    Ball a = new WhiteBall(x,y);
    pt.circles.add(0, a);
  }
  
  public void respawnCue() {
    stick = new Cue(pt.circles.get(0));
  }

public boolean finalShot() {
    Scanner scanner = new Scanner(System.in);
    int pocketIndex = -1;

    // Map keys '1' to '6' to pocket indices 0-5
    while (pocketIndex == -1) {
        System.out.println("Final Shot! Call your pocket (press keys 1 to 6):");
        String input = scanner.nextLine();

        if (input.length() == 1) {
            char key = input.charAt(0);
            if (key >= '1' && key <= '6') {
                pocketIndex = key - '1';  // convert char '1' to int 0, etc.
            } else {
                System.out.println("Invalid pocket. Please press keys 1 to 6.");
            }
        } else {
            System.out.println("Invalid input. Please press a single key from 1 to 6.");
        }
    }

    // Check if black ball was pocketed in the called pocket
    ArrayList<Ball> scoredBalls = pt.getScoredBalls();

    for (Ball ball : scoredBalls) {
        if (ball.type() == 2) {  // black ball
            PVector blackPos = ball.getPosition();
            PVector pocketPos = pt.pocket.get(pocketIndex);

            float dist = PVector.dist(blackPos, pocketPos);
            if (dist <= pt.pocketRadius + 5) {
                System.out.println("Black ball potted in the called pocket. Player wins.");
                return true;
            } else {
                System.out.println("Black ball NOT potted in the called pocket. Foul or loss.");
                return false;
            }
        }
    }

    System.out.println("Black ball was not potted this shot.");
    return false;
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
  public void pgame(){ 
   ArrayList<String> debug = new ArrayList<String>();
   textSize(20);
   fill(0,255,255);
 debug.add("resettingBall: "+ resettingBall);
   for(int i=0;i<debug.size();i++){
     text(debug.get(i), width-220, height-(i+2)*20);
   }
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
