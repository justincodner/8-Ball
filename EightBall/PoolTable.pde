import java.util.ArrayList;
public class PoolTable{
  private final int pocketRadius = 10;
  private final int gapRadius =pocketRadius + 2;
  private final int inset = 2;
 private int wr, lr; //width radius is x direction
 private int frame = pocketRadius;
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
    fill(felt);
    rect(x-wr-frame,y-lr-frame,x+wr+frame,y+lr+frame);
  //wals
  resetMatrix();
  fill(190,150,0);
  strokeWeight(0);
     rect(x-wr-frame,y+lr,x-wr,y-lr);//left
     rect(x+wr,y+lr,x+wr+frame,y-lr);//right
     rect(x-wr,y+lr+frame,x+wr,y+lr);//top
     rect(x-wr,y-lr,x+wr,y-lr-frame);//down
     //pocket
     ellipseMode(RADIUS);
     //inset x
   float ix =0;
    //inset x
   float iy =0;
   for(int i=0; i< pocket.size();i++){
     if(i < 2){
       ix=-sqrt(2)/2;
     }else if(i<4){
       ix=0;
     }else{
       ix=sqrt(2)/2;
     }
     if(i % 2==0){ //top
       iy = sin(5*PI/4);
     }else{ 
       iy = sin(1*PI/4);
     }
     fill(felt);
     ellipse(pocket.get(i)[0],pocket.get(i)[1],gapRadius,gapRadius);
     fill(20);
     ellipse(pocket.get(i)[0],pocket.get(i)[1],pocketRadius,pocketRadius);
   }
   
     
   //striped ad to arr player one
   //not strpied arr p2
 }
}
