public class Ball {
final private float radius = 10.0;

private PVector position;
private PVector velocity;
private PVector spin;
private PVector friction;

public Ball(){
    position= new PVector(220,220);
    friction= new PVector(0,0);
    velocity= new PVector(0,0);
    spin= new PVector(0,0);
 }
public Ball(int x, int y){
    position= new PVector(x,y);
    friction= new PVector(0,0);
    velocity= new PVector(0,0);
    spin= new PVector(0,0);
 }

public PVector getPosition() {
  return position;
}
public void collision(Ball otherBall) {
   transferVelocity(otherBall);
   transferSpin(otherBall);
 }
 
 public void transferVelocity(Ball otherBall) {
   PVector otherPos = otherBall.position;
   float dx = (otherPos.x-position.x);
   float dy = (otherPos.y-position.y);
   float nxHat = dx / (2 * radius);
   float nyHat = dy / (2 *radius);
   float v1 = velocity.x * nxHat + velocity.y * nyHat;
   float v2 = otherBall.velocity.x * nxHat + otherBall.velocity.y * nyHat;
   velocity.add(-v1 + v2, -v1+v2);
   otherBall.velocity.add(-v2+v1,-v2+v1);
 }
 
 public void transferSpin(Ball otherBall) {
   
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
   float fric = .160 * 9.81 * .0005;
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
   if(velocity.x > 0 && velocity.y > 0) {
     updateFriction();
     velocity.add(friction);
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
 
 
 
void render(){
   fill(255,255,255);
   strokeWeight(2);
  ellipse(position.x, position.y, radius*2,radius*2) ;
  textSize(20);
  fill(255,0,0);
  text("Ball velocity: "+ velocity, 10,160);
  //println("ball x:" + position.x + ", Y: "+position.y);
 }
 
}
