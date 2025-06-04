public class BlackBall extends Ball {
  int type = 3;
  public BlackBall(float x, float y) {
    super(x,y);
  }
  public int type() {
    return type;
  }
  
  public void render() {
    super.render();
   fill(0,0,0);
   strokeWeight(2);
   ellipse(super.position.x, super.position.y, super.radius*2,super.radius*2) ;
   fill(255,255,255);
   ellipse(super.position.x, super.position.y-1, 7,7);
   fill(0,0,0);
   strokeWeight(2);
   textSize(12);
   text(8, super.position.x-3,super.position.y+4);
  }
}
