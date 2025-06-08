public class Ball {
final private float radius = 5.0;

private PVector position;
private PVector velocity;
private PVector friction;
private double ta = 0;

public Ball(){
    position= new PVector(220,220);
    friction= new PVector(0,0);
    velocity= new PVector(0,0);
 }
public Ball(float x, float y){
    position= new PVector(x,y);
    friction= new PVector(0,0);
    velocity= new PVector(0,0);
 }
 
 public int type() {
   return -1;
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
   public PVector getPosition() {
    return position;
   }
  public PVector getVelocity() {
    return this.velocity;
  }
 

 public void setPosition(PVector pos) {
   position = pos;
 }
 
 public void setVelocity(PVector velo) {
   velocity = velo;
 }
 
 public void updatePosition() {
   //println("ball update pos");
   position.add(velocity);
 }
 
 public void updateVelocity() {
   if(Math.abs(velocity.x) > 0 || Math.abs(velocity.y) > 0) {
     updateFriction();
     velocity.add(friction);
   //  println(velocity);
   }
 }
 //ADDING THE FRICTION
 public void updateFriction() {
   float fric = .160 * 9.81 * .001;
   double angle = Math.atan2(velocity.y,velocity.x);
   ta =angle;
   //println("velocity dir angle: " +angle);
   //decrements
   float vx = fric * -1 * (float) Math.cos(angle);
   float vy = fric * -1 * (float) Math.sin(angle);
   
   ///if maginite of x-increment velocity
   if(Math.abs(vx) > Math.abs(velocity.x)) {
     vx = velocity.x * -1;
     
   }
   
   if(Math.abs(vy) > Math.abs(velocity.y)) {
     vy = velocity.y * -1;
    
   }
   
   friction = new PVector(vx,vy);
   //println(friction);
 }
 public boolean isInPocket() {
   //Using place holder valuues
   if(position.x < 0 || position.x > 0 || position.y < 0 || position.y > 0) {
     return true;
   } else {
     return false;
   }
 }
 public void transferSpin(Ball otherBall) {
   //implemented only in white ball
   return;
 }
 public String toString(){
   return "ball";
 }
 
 
void render(){
   updateVelocity();
   updatePosition();
 //  updateSpin();
 }
  public void pball(){ 
    //ball debug window;
   ArrayList<String> debug = new ArrayList<String>();
   textSize(20);
   fill(10,240,0);
   debug.add("position: " +position);
   debug.add("Vel mag: " +velocity.mag());
   debug.add("Velocity: " +velocity);
   debug.add("Vel Angle: " +(ta*180/PI));
   debug.add("Fsub f: " +friction.mag());
    debug.add("friction: " +friction);
   
   for(int i=0;i<debug.size();i++){
     text(debug.get(i), 20,height-30- i*20);
   }
  }
}
