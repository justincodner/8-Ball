public class WhiteBall extends Ball{
 PVector spin;
 public WhiteBall(int i, int k){
   super(i,k);
 }
 
 public void transferSpin(Ball otherBall) {
  PVector collisionNormal = PVector.sub(super.position, otherBall.position);
  collisionNormal.normalize();
  collisionNormal = new PVector(collisionNormal.x*spin.x, collisionNormal.y*spin.y);
  super.velocity.add(collisionNormal);
  
 }
}
