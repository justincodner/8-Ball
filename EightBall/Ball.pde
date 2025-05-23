public class Ball {
 final private double radius = 5.0;
 private PVector position;
 private PVector velocity;
 private PVector spin;
 private PVector friction;
 
 public void collision(Ball otherBall) {
   
 }
 
 public void setPostitio(PVector pos) {
   position = pos;
 }
 
 public void setVelocity(PVector velo) {
   velocity = velo;
 }
 public PVector getPosition(){
  return position; 
 }
 
 
}
