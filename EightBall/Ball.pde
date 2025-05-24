public class Ball {
 final private float radius = 25.0;
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
 public void collision(Ball otherBall) {
   
 }
 
 public void setPostition(PVector pos) {
   position = pos;
 }
 
 public void setVelocity(PVector velo) {
   velocity = velo;
 }
 public PVector getPosition(){
  return position; 
 }
 void render(){
   fill(255,0,0);
   strokeWeight(2);
  ellipse(position.x, position.y, radius*10,radius*10) ;
  println("ball x:" + position.x + ", Y: "+position.y);
 }
 
}
