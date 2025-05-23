public class Cue{
  final private float length = 200;
//  private PVector position; //head of the stick
  private float power;
  private PVector angle; //
  private boolean positionSet;
  private WhiteBall ball;
  
  public Cue(WhiteBall b){
    ball = b;
    power= 0;
    angle = new PVector(1,0); //default right
  }
  //drag cue 
  //
  public void setAngle(){
    //position follow cartesian quadrants
    // mouse on stick
   
    angle.x = - mouseX + ball.getPosition().x;
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
    setAngle();
    if(angle.y >= 0){
      rotate(acos(angle.x));
    } else{
       rotate(-1*acos(angle.x));
    }
    strokeWeight(0);
    fill(200,200,100);
    rect(20*angle.x + ball.getPosition().x,20*angle.y+ball.getPosition().y,2,length);
  //  rect(20*angle.x-2,20*angle.y,2,length);
    println(angle.x + " 0||0 "+ angle.y);
    pMouse();
    
  }
  public void pMouse(){ 
    println("Mouse: x:" + mouseX + ", Y: "+mouseY);
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
