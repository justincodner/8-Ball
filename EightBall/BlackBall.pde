public class BlackBall extends Ball {
  public BlackBall(float x, float y) {
    super(x,y);
  }
  
  public void render() {
   fill(0,0,0);
   strokeWeight(2);
   ellipse(super.position.x, super.position.y, super.radius*2,super.radius*2) ;
   super.render();
  }
}
