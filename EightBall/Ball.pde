public class Ball {
final private float radius = 10.0;

private PVector position;
private PVector velocity;
private PVector friction;
private PVector spin;

public Ball(){
    position= new PVector(220,220);
    friction= new PVector(0,0);
    velocity= new PVector(0,0);
    spin = new PVector(0,0);
 }
public Ball(float x, float y){
    position= new PVector(x,y);
    friction= new PVector(0,0);
    velocity= new PVector(0,0);
    spin = new PVector(0,0);
 }

public PVector getPosition() {
  return position;
}
public void collision(Ball otherBall) {
  PVector collisionNormal = PVector.sub(position, otherBall.position);
  float distance = collisionNormal.mag();
  float minDistance = 2 * radius;
  collisionNormal.normalize();
  float overlap = minDistance - distance;
  position.add(PVector.mult(collisionNormal, overlap / 2));
  otherBall.position.sub(PVector.mult(collisionNormal, overlap / 2));
  PVector relVelocity = PVector.sub(velocity, otherBall.velocity);
  float impulseMag = relVelocity.dot(collisionNormal);
  velocity.sub(PVector.mult(collisionNormal, impulseMag));
  otherBall.velocity.add(PVector.mult(collisionNormal, impulseMag));
 }

 public float getRad() {
   return this.radius;
 }
 

 public void setPosition(PVector pos) {
   position = pos;
 }
 
 public void setVelocity(PVector velo) {
   velocity = velo;
 }
 
 public void updatePosition() {
   position.add(velocity);
 }
 
 
 public void updateFriction() {
   float fric = .160 * 9.81 * .002;
   double angle = Math.atan(velocity.y/velocity.x);
   float vx = fric * -1 * (float) Math.cos(angle);
   float vy = fric * -1 * (float) Math.sin(angle);
   
   if(Math.abs(vx) > Math.abs(velocity.x)) {
     vx = velocity.x * -1;
   }
   
   if(Math.abs(vy) > Math.abs(velocity.y)) {
     vy = velocity.y * -1;
   }
   friction = new PVector(vx,vy);
 }
 public void updateVelocity() {
   if(Math.abs(velocity.x) > 0 || Math.abs(velocity.y) > 0) {
     updateFriction();
     velocity.add(friction);
   }
 }
 
 public void updateSpin() {
   if(Math.abs(spin.x)> 0 || Math.abs(spin.y) > 0) {
     float incX = .01;
     float incY = .01;
     if(Math.abs(spin.x) < .01) {
       incX = spin.x * -1;
     } else if(spin.x > 0) {
       incX *= -1;
     }
     
     if(Math.abs(spin.y) < .01) {
       incY = spin.y *-1;
     } else if(spin.y > 0) {
       incY *= -1;
     }
     spin.add(incX, incY);
   }
 }
 
 public boolean isInPocket() {
   //Using place holder valuues
   if(position.x < 0 || position.x > 0 || position.y < 0 || position.y > 0) {
     return true;
   } else {
     return false;
   }
 }
 void transferSpin(Ball otherBall) {
   return;
 }
 
 
void render(){
   fill(255,255,255);
   strokeWeight(2);
   ellipse(position.x, position.y, radius*2,radius*2) ;
   updateVelocity();
   updatePosition();
   updateSpin();
 }
 
}
