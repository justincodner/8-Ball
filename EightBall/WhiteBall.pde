public class WhiteBall extends Ball{
 PVector spin;
 int type = 2;
 public WhiteBall(int i, int k){
   super(i,k);
 }
 
 public int type() {
   return type;
 }
 
 public void transferSpin(Ball otherBall) {
   PVector collisionDir = PVector.sub(otherBall.position, super.position);
   collisionDir.normalize();
   PVector tangentDir = new PVector(collisionDir.y, -collisionDir.x);
   
   super.velocity.add(PVector.mult(collisionDir, spin.y));
   super.velocity.add(PVector.mult(tangentDir, spin.x));

   spin = new PVector(0,0);
}
  public void render() {
   fill(255,255,255);
   strokeWeight(2);
   ellipse(super.position.x, super.position.y, super.radius*2,super.radius*2) ;
   stroke(140,170,190);
   ellipse(super.position.x, super.position.y, 2,2) ;
   stroke(0);
   super.render();
  }
}
