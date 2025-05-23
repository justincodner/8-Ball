public class Cue{
  final private float length = 30;
//  private PVector position; //head of the stick
  private float power;
  private PVector angle; //
  private boolean positionSet;
  private WhiteBall ball;
  private float angleScalar;
  
  public Cue(){
    power= 0;
    angle = new PVector(1,0); //default right
  }
  //drag cue 
  //
  public void setAngle(){
    //position follow cartesian quadrants
    // mouse on stick
    angle.x = mouseX - ball.getPosition().x;
    angle.y = ball.getPosition().y - mouseY;
    angle.normalize();
    
    
  }
  /*
  public void setPosition(){
    position.x= mouseX.
  }
  */
  public void setPower(){
    if(mousePressed){
     while(mousePressed){
       power = ball.getPosition().dist(new PVector(mouseX,mouseY));
     }
    }
    
  }
  public void strike(float pow){
    
  }
  public void render(){
    if(angle.y >= 0){
      rotate(acos(angle.x));
    } else{
       rotate(-1*acos(angle.x));
    }
    rect(20*angle.x,20*angle.y,5,length);
    
  }
}
/*
mouseX  
mouseY  
pmouseX  
pmouseY  
mousePressed  
mouseReleased()  
mouseClicked()  
mouseMoved()  
mouseDragged()  
mouseButton  
mouseWheel()  
*/
