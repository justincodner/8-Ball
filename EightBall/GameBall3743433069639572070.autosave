public class GameBall extends Ball {
  private int type;
  private int num;
  private color col;
  public GameBall(float x, float y, int type, color col, int num) {
    super(x,y);
    this.type = type;
    this.col = col;
    this.num = num;
  }
  
  public void render() {
   super.render();
   fill(col);
   strokeWeight(2);
   ellipse(super.position.x, super.position.y, super.radius*2,super.radius*2);
   fill(255,255,255);
   ellipse(super.position.x, super.position.y-1, 7,7);
   strokeWeight(1);
   if(type == 1) {
     arc(super.position.x, super.position.y, super.radius*2,super.radius*2, QUARTER_PI, 3 * QUARTER_PI, CHORD);
      arc(super.position.x, super.position.y, super.radius*2,super.radius*2, 5*QUARTER_PI, 7 * QUARTER_PI, CHORD);
    }
    strokeWeight(2);
    textSize(12);
    fill(0,0,0);
    text(num, super.position.x-3,super.position.y+4);
}
}
