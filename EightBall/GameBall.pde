public class GameBall extends Ball {
  private int type;
  private color col;
  public GameBall(float x, float y, int type, color col) {
    super(x,y);
    this.type = type;
    this.col = col;
  }
  
  public void render() {
   fill(col);
   strokeWeight(2);
   ellipse(super.position.x, super.position.y, super.radius*2,super.radius*2) ;
   super.render();
  }
}
