public class Cue{
  final private double length = 30;
  private PVector position; //head of the stick
  private double power;
  private PVector angle; //
  
  public Cue(){
    position = new PVector(0,0);
    power= 0;
    angle = new PVector(1,0); //default right
  }
  public void setAngle(){
     angle.x = mouseX - position.x;
    angle.y = position.y - mouseY;
    
    
  }
  public void setPosition(){
    
  }
  public void setPower(){
    
  }
  public void strike(double pow, double theta){
    
  }
  public void render(){
    
  }
  
  
}
