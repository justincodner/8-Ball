public class Cue{
  final private float length = 200;
  final private PVector up = new PVector(0,1); //why no static
  final private static int space = 10;
  private float angleToY; //radians
  private float angleLock;
  private PVector centerPos; //center of the stick b4 rotate
  private float power;
  private PVector angle; //
  private boolean powerDraw;
  private boolean powerDrawn;
  private WhiteBall ball;
  
  public Cue(WhiteBall b){
    ball = b;
    power= 0;
    angle = new PVector(1,0); //default right
    centerPos = new PVector(0,0);
    angleLock =0;
  }
  //drag cue 
  //
  public void setAngle(){
    // set amnt of rotation mouse on stick
    angle.x = mouseX - ball.getPosition().x;
    angle.y = mouseY- ball.getPosition().y ;
    angle.limit(ball.getRad()+space+100);
    if(angle.mag() < ball.getRad()+space+20){
       angle.setMag(ball.getRad()+space+20); 
    }
    
    angleToY = acos(up.dot(angle) / (angle.mag())); 
    if(mouseX < ball.getPosition().x){
      angleToY*= -1;
    }
    if(powerDraw){
    setPosition(power);
    }else if(powerDrawn){
      setPosition(power);
    }else{
     setPosition(0); 
    }
    
  }

  public void setPosition(float d){
     //reorienting new x, y
    //diag + cue - ball over twice the cue = x
    PVector cueVec = angle.copy().setMag(length / 2 + d+space+ball.getRad()); // cue vector
    PVector diagVec = (PVector.add(cueVec,ball.getPosition()));
    centerPos.x = (float)(diagVec.magSq()+Math.pow(cueVec.mag(),2)
                  - Math.pow(ball.getPosition().mag(),2))/(2 * cueVec.mag()); //dist cue center to ogn
    centerPos.y = centerPos.x*tan(angleToY -atan(diagVec.x/diagVec.y));
  }
  public void setPower(){
    if(mousePressed){
      powerDraw =true;
       power += (new PVector(mouseX-pmouseX,mouseY-pmouseY)).limit(40).mag();
      
    
    }
    
  }
  public void strike(){
    if(power >0){
      power-=15;
    } else{
    power =0;
    }
  }
  //packeges ever
  public void render(){
    strike();
    setAngle();
    setPower();
    rotate(PI/2-angleToY);
    rectMode(CENTER);
    strokeWeight(0);
    fill(200,100,20);
    rect(centerPos.x,centerPos.y,length,10);
    fill(255);
    rect(centerPos.x,centerPos.y,2,2);
    rotate(-1*(PI/2-angleToY));
  /*  strokeWeight(2);
    line(0,0,ball.getPosition().x,ball.getPosition().y);
    p(2);
  */  
  }
  public void p(int i){ 
    if(i == 1){
      println("Mouse: x:" + mouseX + ", Y: "+mouseY);
    }else if(i==2){
      println("angletoy: "+ (angleToY *180/PI));
    }
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
