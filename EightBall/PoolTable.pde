import java.util.ArrayList;
import java.util.Arrays;
public class PoolTable{
  private final int pocketRadius = 13;
  private final int inset = 10;
  private final int gapRadius =pocketRadius + 3;
  final private boolean debug = false;
  private int wr, lr; //width radius is x direction
  private int frame = pocketRadius+inset+5;
  private int x,y;//center
  private ArrayList<PVector> pocket = new ArrayList<PVector>();
  private ArrayList<Ball> circles = new ArrayList<Ball>();
  private ArrayList<Ball> scoredBalls = new ArrayList<Ball>();
  private int bounce=0;
  
  public PoolTable(int wd, int len, int fr){
    wr = wd/2;
    lr = len/2;
    frame += fr;
  //  pocket = new ArrayList<int[]>();
    x= width/2;
    y=height/2;
    println("x: "+x);
    println("y: "+y);
    println("w: "+width);
    println("h: "+height);
    
    //top down left right
        
    pocket.add(new PVector(x-wr-inset,y-lr-inset));  
    pocket.add(new PVector(x-wr-inset,y+lr+inset));
    pocket.add(new PVector(x,y-lr-inset));
    pocket.add(new PVector(x,y+lr+inset));
    pocket.add(new PVector(x+wr+inset,y-lr-inset));
    pocket.add(new PVector(x+wr+inset,y+lr+inset));
    //keep frame in bounce the same

 }
 public Ball checkForBall(){
   rectMode(CENTER);
   return new Ball();
   //striped ad to arr player one
   //not strpied arr p2
 }
 
 public ArrayList<Ball> addBall(Ball apple){
    circles.add(apple);
    return circles;
 }
 public ArrayList<Ball> addBall(int index, Ball apple){
    circles.add(index, apple);
    return circles;
 }
 public ArrayList<Ball> getScoredBalls (){
    return scoredBalls;
 }
 public ArrayList<Ball> circ(){
    return circles;
 }
 
 
 public Ball getBall(int i){
    return circles.get(i);
 }
  
 public void cscore(Cue st){
   //returns ball scored.null if nothing
   //checks entire circles
   int prevSize =0;
   for(int i = 0; i<circles.size(); i++){
     prevSize= circles.size();
     for(int k = 0; k<pocket.size() && prevSize==circles.size(); k++){
       //CHANGE VLAUE
       if(PVector.dist(circles.get(i).getPosition(),pocket.get(k)) <pocketRadius){
     
        // if(circles.size()>0)
         //  st.setBall(circles.get(i+1));
         scoredBalls.add(circles.remove(i));
       }
      // print(i+", ");
     }
   }
 }
 public Ball wbounce(){
   //returns ball bounced.null if nothing
   //checks entire circles
  // println("Ball bounce");
   PVector t = new PVector(0,0);
   fill(255,255,0);
   strokeWeight(2);
   for(int i = 0; i<circles.size(); i++){
     if(circles.get(i).getPosition().x> x+wr-circles.get(i).getRad()){
        bounce++;
        circles.get(i).setPosition(new PVector(x+wr-circles.get(i).getRad(),circles.get(i).getPosition().y));
       t =circles.get(i).getVelocity();
       t.x*=-1;
       circles.get(i).setVelocity(t);
        return circles.get(i);
     }else if(circles.get(i).getPosition().x< x-wr+circles.get(i).getRad()){//right wall
        bounce++;
        circles.get(i).setPosition(new PVector(x-wr+circles.get(i).getRad(),circles.get(i).getPosition().y));
       t =circles.get(i).getVelocity();
       t.x*=-1;
       circles.get(i).setVelocity(t);
        return circles.get(i);
     }else if(circles.get(i).getPosition().y> y+lr-circles.get(i).getRad()){
        bounce++;
        circles.get(i).setPosition(new PVector(circles.get(i).getPosition().x,y+lr-circles.get(i).getRad()));
       t =circles.get(i).getVelocity();
       t.y*=-1;
       circles.get(i).setVelocity(t);
        return circles.get(i);
     }else if(circles.get(i).getPosition().y< y-lr+circles.get(i).getRad()){
        bounce++;
        circles.get(i).setPosition(new PVector(circles.get(i).getPosition().x,y-lr+circles.get(i).getRad()));
       t =circles.get(i).getVelocity();
       t.y*=-1;
       circles.get(i).setVelocity(t);
        return circles.get(i);
     }//bottom wall
     
   }
   return null;
  }
  public boolean topBound(Ball oi){
    return oi.getPosition().y<= y-lr+5;
  }
  public boolean bottomBound(Ball oi){
    return oi.getPosition().y>=y+lr-5;
  }
  public boolean leftBound(Ball oi){
    return oi.getPosition().y<=x-wr+5;
  }
  public boolean rightBound(Ball oi){
    return oi.getPosition().y>=x+wr-5;
  }
  /*
  public void checkBound(){
    for(for(int i = 0; i<circles.size(); i++){)
  }
  */
  public void render(){
    color felt = color(40,170,20);
    rectMode(CORNERS);
    //table (corners)
    fill(felt);
    rect(x-wr-frame,y-lr-frame,x+wr+frame,y+lr+frame);
    
    //wall frames (corners)
    fill(120,70,40);
    strokeWeight(0);
    rect(x-wr-frame,y+lr+frame,x-wr,y-lr-frame);//left +corn
    rect(x+wr,y+lr+frame,x+wr+frame,y-lr-frame);//right+conr
    rect(x-wr,y+lr+frame,x+wr,y+lr);//top
    rect(x-wr,y-lr,x+wr,y-lr-frame);//down
    
    rectMode(RADIUS);   
    rotate(-PI/4);
    fill(felt);
    rect((pocket.get(0).x-pocket.get(0).y)/sqrt(2),(pocket.get(0).x+pocket.get(0).y+3*inset)/sqrt(2),gapRadius,sqrt(2)*(1.5*inset)); //top left
    rect((pocket.get(1).x-pocket.get(1).y+3*inset)/sqrt(2),(pocket.get(1).x+pocket.get(1).y)/sqrt(2),sqrt(2)*(1.5*inset),gapRadius); //bottom left
    rect((pocket.get(4).x-pocket.get(4).y-3*inset)/sqrt(2),(pocket.get(4).x+pocket.get(4).y)/sqrt(2),sqrt(2)*(1.5*inset),gapRadius); //top right
    rect((pocket.get(5).x-pocket.get(5).y)/sqrt(2),(pocket.get(5).x+pocket.get(5).y-3*inset)/sqrt(2),gapRadius,sqrt(2)*(1.5*inset)); //bottom right
    resetMatrix();
    rect(pocket.get(2).x,pocket.get(2).y+inset,gapRadius,inset);
    rect(pocket.get(3).x,pocket.get(3).y-inset,gapRadius,inset);
    
    //pocket
    ellipseMode(RADIUS);
    for(int i=0; i< pocket.size();i++){
      fill(felt);
      ellipse(pocket.get(i).x,pocket.get(i).y, gapRadius,gapRadius);
      fill(20);
      ellipse(pocket.get(i).x,pocket.get(i).y,pocketRadius,pocketRadius);
   }
   //collision detection
   for(int i = 0; i < circles.size()-1; i++) {
     for(int e = i+1 ; e < circles.size(); e++) {
       detectCollision(circles.get(i),circles.get(e));
       
     }
   }
   if (debug)
   println("combination collision detection, ");
   
   for(Ball bob :circles){
      bob.render(); 
   }
   if (debug)
   println("pt circle render, ");
   ptble();
   if(circles.size()>0){
     circles.get(0).pball();
   }
   if (debug)
   println("pt whiteball render, ");
   strokeWeight(1);
   stroke(222,0,2);
   line(x,0,x,height);
   line(0,y,width,y);
   //boucnewalls
   line(x+wr-5,0,x+wr-5,height);
   line(x-wr+5,0,x-wr+5,height);
   line(0,y+lr-5,width,y+lr-5);
   line(0,y-lr+5,width,y-lr+5);
   stroke(0);
   //striped ad to arr player one
   //not strpied arr p2
   if (debug)
   println("pt render finished, ");
 }
 public void ptble(){ 
   ArrayList<String> debug = new ArrayList<String>();
   textSize(20);
   fill(0,255,255);
// debug.add("ball set vel: "+ tprint);
   for(int i=0;i<debug.size();i++){
     text(debug.get(i), 20, height-i*20);
   }
  }
  
  public void start() {
    color[] ballCol = {color(255,255,0), color(173,216,230), color(255,71,76), color(0,0,139), color(255,165,0), color(0,255,0), color(139,0,0)};
    for(int i = 0; i < 7; i++) {
      circles.add(new GameBall(0,0,0, ballCol[i],i+1));
      circles.add(new GameBall(0,0,1,ballCol[i],i+8));
    }
    float l = (float) Math.sqrt(3);
    Ball black = new BlackBall(450-20*l,350);
    java.util.Collections.shuffle(circles);
    PVector[] positions ={new PVector(450,390), new PVector(450,370), new PVector(450,350), new PVector(450,330), new PVector(450,310),
                          new PVector(450-10*l,380),new PVector(450-10*l,360), new PVector(450-10*l,340), new PVector(450-10*l,320),
                          new PVector(450-20*l, 370), new PVector(450-20*l, 330), 
                          new PVector(450-30*l, 360), new PVector(450-30*l, 340),
                          new PVector(450-40*l, 350) };
    for(int i = 0; i < circles.size(); i++) {
      circles.get(i).setPosition(positions[i]);
    }
    circles.add(black);
  }
  
  void detectCollision(Ball tb1, Ball tb2) {
  if(Math.sqrt((tb1.position.x-tb2.position.x) * (tb1.position.x-tb2.position.x) + (tb1.position.y - tb2.position.y) * (tb1.position.y - tb2.position.y)) < 10) {
    tb1.collision(tb2);
  //  print(tb1.position.x +" "+tb1.position.y + "and" +tb2.position.x+" "+tb2.position.y);
    //tb1.transferSpin(tb2); //<==
  }
  }
  
  public boolean ballStop() {
    for(Ball ball : circles) {
      if(ball.velocity.x !=0 || ball.velocity.y!=0) {
        return false;
      }
    }
    return false;
  }
  
  public boolean whitePocketed() {
    if(circles.get(0).type() == 2) {
      return false;
    }
    
    return true;
  } 
}
