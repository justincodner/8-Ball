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
 public void collision(Ball otherBall) {
   
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
 public PVector getPosition(){
  return position; 
 }
 void render(){
   fill(255,255,255);
   strokeWeight(2);
  ellipse(position.x, position.y, radius*2,radius*2) ;
  //println("ball x:" + position.x + ", Y: "+position.y);
 }
 
}
