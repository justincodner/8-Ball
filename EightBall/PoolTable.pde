import java.util.ArrayList;
import java.util.Arrays;
public class PoolTable{
  private final int pocketRadius = 10;
  private final int inset = 10;
  private final int gapRadius =pocketRadius + 5;
 private int wr, lr; //width radius is x direction
 private int frame = pocketRadius+inset+5;
 private ArrayList<int[]> pocket = new ArrayList<int[]>();
 private int x,y;//center
 
 public PoolTable(int wd, int len, int fr){
   wr = wd/2;
   lr = len/2;
   frame += fr;
   pocket = new ArrayList<int[]>();
   x= width/2;
   y=height/2;
   println("x: "+x);
      println("y: "+y);
      println("w: "+width);
      println("h: "+height);
      //top down left right
      
   pocket.add(new int[] {x-wr-inset,y-lr-inset});  
   pocket.add(new int[] {x-wr-inset,y+lr+inset});
   pocket.add(new int[] {x,y-lr-inset});
   pocket.add(new int[] {x,y+lr+inset});
   pocket.add(new int[] {x+wr+inset,y-lr-inset});
   pocket.add(new int[] {x+wr+inset,y+lr+inset});
 //  pocketRadius = ball.getRad()+2;
 for(int[] a : pocket){
    println("pocket: "+Arrays.toString(a));
 }

 }
 public Ball checkForBall(){
   rectMode(CENTER);
   return new Ball();
   //striped ad to arr player one
   //not strpied arr p2
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
   rect((pocket.get(0)[0]-pocket.get(0)[1])/sqrt(2),(pocket.get(0)[0]+pocket.get(0)[1]+2*inset)/sqrt(2),gapRadius,gapRadius); //top right
   rect((pocket.get(1)[0]-pocket.get(1)[1]+2*inset)/sqrt(2),(pocket.get(1)[0]+pocket.get(1)[1])/sqrt(2),gapRadius,gapRadius); //top right
   rect((pocket.get(4)[0]-pocket.get(4)[1]-2*inset)/sqrt(2),(pocket.get(4)[0]+pocket.get(4)[1])/sqrt(2),gapRadius,gapRadius); //top right
   rect((pocket.get(5)[0]-pocket.get(5)[1])/sqrt(2),(pocket.get(5)[0]+pocket.get(5)[1]-2*inset)/sqrt(2),gapRadius,gapRadius); //top right
    resetMatrix();
    rect(pocket.get(2)[0],pocket.get(2)[1]+inset,gapRadius,gapRadius);
    rect(pocket.get(3)[0],pocket.get(3)[1]-inset,gapRadius,gapRadius);
    
    //pocket
ellipseMode(RADIUS);

   for(int i=0; i< pocket.size();i++){
    
      fill(felt);
     ellipse(pocket.get(i)[0],pocket.get(i)[1],gapRadius,gapRadius);
     fill(20);
     ellipse(pocket.get(i)[0],pocket.get(i)[1],pocketRadius,pocketRadius);
    
    
   }
   strokeWeight(1);
   fill(222,0,2);
     line(x,0,x,height);
     line(0,y,width,y);
     
   //striped ad to arr player one
   //not strpied arr p2
 }
}
