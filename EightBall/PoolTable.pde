import java.util.ArrayList;
import java.util.Arrays;
public class PoolTable{
  private final int pocketRadius = 10;
  private final int inset = 20;
  private final int gapRadius =pocketRadius + 3;
  private int wr, lr; //width radius is x direction
  private int frame = pocketRadius+inset+5;
  private int x,y;//center
  private ArrayList<PVector> pocket = new ArrayList<PVector>();
  private ArrayList<Ball> circles = new ArrayList<Ball>();
  
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
 public ArrayList<Ball> circ(){
    return circles;
 }
 
 
 public Ball getBall(int i){
    return circles.get(i);
 }
  
 public Ball cscore(Cue st){
   //returns ball scored.null if nothing
   //checks entire circles
   println(circles.size());
   for(int i = 0; i<circles.size(); i++){
     for(int k = 0; k<pocket.size(); k++){
       //CHANGE VLAUE
       if(PVector.dist(circles.get(i).getPosition(),pocket.get(k)) <20){
         println(circles);
         st.setBall(circles.get(i+1));
         return circles.remove(i);
       }
     }
   }
    return null;
 }
 public Ball wbounce(){
   //returns ball bounced.null if nothing
   //checks entire circles
   PVector t = new PVector(0,0);
   for(int i = 0; i<circles.size(); i++){
     if(circles.get(i).getPosition().x>= x+wr-circles.get(i).getRad() || circles.get(i).getPosition().x<= x-wr+circles.get(i).getRad()){ //right wall
       t =circles.get(i).getVelocity();
       t.x*=-1;
       circles.get(i).setVelocity(t);
       return circles.get(i);
     } else if(circles.get(i).getPosition().y>= y-lr+circles.get(i).getRad() || circles.get(i).getPosition().x<= x+lr-circles.get(i).getRad()){ //bottom
       t=circles.get(i).getVelocity();
       t.y*=-1;
       circles.get(i).setVelocity(t);
       return circles.get(i);
     }
   }
   return null;
  }
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
    rect(-90,400,4,10);
   rect((pocket.get(0).x-pocket.get(0).y)/sqrt(2),(pocket.get(0).x+pocket.get(0).y+2*inset)/sqrt(2),gapRadius,inset+gapRadius); //top right
   rect((pocket.get(1).x-pocket.get(1).y+2*inset)/sqrt(2),(pocket.get(1).x+pocket.get(1).y)/sqrt(2),gapRadius+inset,gapRadius); //top right
   rect((pocket.get(4).x-pocket.get(4).y-2*inset)/sqrt(2),(pocket.get(4).x+pocket.get(4).y)/sqrt(2),gapRadius+inset,gapRadius); //top right
   rect((pocket.get(5).x-pocket.get(5).y)/sqrt(2),(pocket.get(5).x+pocket.get(5).y-2*inset)/sqrt(2),gapRadius,gapRadius+inset); //top right
    resetMatrix();
    rect(pocket.get(2).x,pocket.get(2).y+inset,gapRadius,inset);
    rect(pocket.get(3).x,pocket.get(3).y-inset,gapRadius,inset);
    
    //pocket
    ellipseMode(RADIUS);
    for(int i=0; i< pocket.size();i++){
      fill(felt);
      ellipse(pocket.get(i).x,pocket.get(i).y,gapRadius,gapRadius);
      fill(20);
      ellipse(pocket.get(i).x,pocket.get(i).y,pocketRadius,pocketRadius);
   }
   
   for(Ball bob :circles){
      bob.render(); 
   }
   ptble();
   if(circles.size()>0){
     circles.get(0).pball();
   }
   strokeWeight(1);
   fill(222,0,2);
   line(x,0,x,height);
   line(0,y,width,y);
   //striped ad to arr player one
   //not strpied arr p2
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
}
