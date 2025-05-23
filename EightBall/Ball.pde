public class Ball {
 final private float radius = 5.0;
 private PVector position;
 private PVector velocity;
 private PVector spin;
 private PVector friction;
 
 public Ball() {
   velocity = new PVector(0,0);
   spin = new PVector(0,0);
   friction = new PVector(0,0);
 }
 
 public void collision(Ball otherBall) {
   transferVelocity(otherBall);
   transferSpin(otherBall);
 }
 
 public void transferVelocity(Ball otherBall) {
   //transfer energy with conservation
 }
 
 public void transferSpin(Ball otherBall) {
   //transfer the spin
 }
 
 public void setPosition(PVector pos) {
   position = pos;
 }
 
 public void setVelocity(PVector velo) {
   velocity = velo;
 }
 
 public void updateVelocity() {
   velocity.add(friction);
   velocity.add(spin); 
 }
 
 public boolean isInPocket() {
   //Using place holder valuues
   if(position.x < 0 || position.x > 0 || position.y < 0 || position.y > 0) {
     return true;
   } else {
     return false;
   }
 }
 
 
 
 public void render() {
   //implemented in sub classes
 }
 
 
}
