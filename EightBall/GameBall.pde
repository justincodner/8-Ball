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
  
  public int type() {
    return type;
  }
  
  public void render() {
   super.render();
   fill(col);
   strokeWeight(1);
   ellipse(super.position.x, super.position.y, super.radius,super.radius);
   fill(255,255,255);
   ellipse(super.position.x, super.position.y, 6,6);
   strokeWeight(1);
   if(type == 1) {
     arc(super.position.x, super.position.y, super.radius,super.radius, QUARTER_PI, 3 * QUARTER_PI, CHORD);
      arc(super.position.x, super.position.y, super.radius,super.radius, 5*QUARTER_PI, 7 * QUARTER_PI, CHORD);
    }
    strokeWeight(2);
    textSize(10);
    fill(0,0,0);
    if(num < 10) {
      text(num, super.position.x-3,super.position.y+4);
    } else {
      text(num,super.position.x-5,super.position.y+4);
    }
}
}
