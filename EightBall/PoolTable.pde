import java.util.ArrayList;
public class PoolTable{
  private final int pocketRadius =10;
  private final int gapRadius =12;
 private int wr, lr; //width radius is x direction
 private int frame;
 private ArrayList<int[]> pocket = new ArrayList<int[]>();
 private int x,y;//center
 
 public PoolTable(int wd, int len, int fr){
   wr = wd/2;
   lr = len/2;
   frame = fr;
   pocket = new ArrayList<int[]>();
   x= width/2;
   y=height/2;
   pocket.add(new int[] {x-wr,y-lr});  
   pocket.add(new int[] {x-wr,y+lr});
   pocket.add(new int[] {x,y-lr});
   pocket.add(new int[] {x,y+lr});
   pocket.add(new int[] {x+wr,y-lr});
   pocket.add(new int[] {x+wr,y+lr});
 }
 public Ball checkForBall(){
   rectMode(CENTER);
   return new Ball();
   //striped ad to arr player one
   //not strpied arr p2
 }
  public void render(){
       fill(20);
   for(int i=0; i< pocket.size();i++){
     
     ellipse(i[0],i[1],pocketRadius,pocketRadius);
   }
     
   //striped ad to arr player one
   //not strpied arr p2
 }
}
