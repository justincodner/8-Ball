public class WhiteBall extends Ball{
 private PVector spin;
 private int type = 2;
 public WhiteBall(float i, float k){
   super(i,k);
   spin = new PVector(0,0);
 }
 public int type() {
   return type;
 }
 public void setSpin(PVector spin) {
   this.spin = spin;
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
   stroke(255);
   fill(255);
   strokeWeight(2);
   ellipse(super.position.x, super.position.y, super.radius,super.radius);
   stroke(140,170,190);
   ellipse(super.position.x, super.position.y, 2,2);
   stroke(0);
   super.render();
  }
}
