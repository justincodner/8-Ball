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
      
   pocket.add(new int[] {x-wr,y-lr});  
   pocket.add(new int[] {x-wr,y+lr});
   pocket.add(new int[] {x,y-lr});
   pocket.add(new int[] {x,y+lr});
   pocket.add(new int[] {x+wr,y-lr});
   pocket.add(new int[] {x+wr,y+lr});
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
   float rt2 =sqrt(2)*inset; //llonger on corners
      //45 deg rect
    rotate(-PI/4);
    fill(20,255,255);
    rect(-90,400,4,10);
   // rect(((pocket.get(0)[0]-rt2)-(pocket.get(0)[1]-rt2))/sqrt(2), (pocket.get(0)[0]-rt2)*(sqrt(2)-1)-(pocket.get(0)[1]-rt2), gapRadius,2*gapRadius);
 ///   rect(((pocket.get(1)[0]-rt2)-(pocket.get(1)[1]+rt2))/sqrt(2), (pocket.get(1)[0]-rt2)*(sqrt(2)-1)-(pocket.get(1)[1]+rt2), gapRadius,2*gapRadius);
  println("x4 (uper right): "+(((pocket.get(4)[0]+rt2)-(pocket.get(4)[1]-rt2))/sqrt(2))); 
  println("y4 (uper right): "+((pocket.get(4)[0]+rt2)*(sqrt(2)-1)-(pocket.get(4)[1]-rt2)));
   rect(((pocket.get(4)[0]+rt2)-(pocket.get(4)[1]-rt2))/sqrt(2), (pocket.get(4)[0]+rt2)*(sqrt(2)-1)-(pocket.get(4)[1]-rt2), 2*gapRadius,gapRadius);
    rect(((pocket.get(5)[0]+rt2)-(pocket.get(5)[1]+rt2))/sqrt(2), (pocket.get(5)[0]+rt2)*(sqrt(2)-1)-(pocket.get(5)[1]+rt2), 2*gapRadius,gapRadius);
    resetMatrix();
    
    //pocket
ellipseMode(RADIUS);

   for(int i=0; i< pocket.size();i++){
     float ix = 0;
     float iy = 0;
     if(i<2){
       ix=-inset;
     }else if(i>3){
       ix=inset;
    }
    if(i%2==0){
      iy = -inset;
    }else {
      iy=inset;
    }
       
     fill(felt);
     
     ellipse(pocket.get(i)[0]+ix,pocket.get(i)[1]+iy,gapRadius,gapRadius);
     fill(20);
     ellipse(pocket.get(i)[0]+ix,pocket.get(i)[1]+iy,pocketRadius,pocketRadius);
    
    
   }
   strokeWeight(1);
   fill(222,0,2);
     line(x,0,x,height);
     line(0,y,width,y);
     
   //striped ad to arr player one
   //not strpied arr p2
 }
}
