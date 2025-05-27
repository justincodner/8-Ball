public class Cue{
  //defaults 
  final private float length = 200;
  final private PVector up = new PVector(0,1); //why no static
  final private static int minPower = 5;
  final private static int maxPower = 100;
  final private static int space = 2;
  
  private PVector centerPos; //center of the stick b4 rotate
  private PVector angle; //
  private float angleToY; //radians
  private float angleLock;
  private float power;
  private float setPower;
  private boolean powerDraw;
  private boolean powerDrawn;
  private WhiteBall ball;
  
  public Cue(WhiteBall b){
    ball = b;
    power= 0;
    angle = new PVector(1,0); //default right
    centerPos = new PVector(0,0);
    angleLock =0;
    setPower =0;
  }
  //drag cue 
  //
  public void setAngle(){
    PVector theta = angle.copy();
    float thetaRadians = angleToY;
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
      angle=theta;
      angleToY = thetaRadians;
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
       //power += (new PVector(mouseX-pmouseX,mouseY-pmouseY)).limit(40).mag();
       power = PVector.dist(ball.getPosition(), new PVector(mouseX, mouseY)) - length/2 ;
       if(power>maxPower){
         power =maxPower;
       } else if (power < minPower){
         power =minPower;
       }
    }
  }
  public void strike(){
    if(power >0 && !mousePressed){
      powerDrawn = true;
      powerDraw = false;
      power-=11;
    } else if(powerDrawn && power <= 0){
      powerDrawn = false;
      println("suppsoed to transfer powe rhere");
      ball.setVelocity(angle.copy().setMag(setPower/maxPower).mult(-1));
      power =0;
    }
  }
  //packeges ever
  public void render(){
    strike();
    setAngle();
    setPower();
    p();
    rotate(PI/2-angleToY);
    rectMode(CENTER);
    strokeWeight(0);
    fill(200,100,20);
    rect(centerPos.x,centerPos.y,length,10);
    fill(255);
    rect(centerPos.x,centerPos.y,2,2);
    rotate(-1*(PI/2-angleToY));
  }
  public void p(){ 
   textSize(20);
   fill(0,0,255);
   text("Power: " +power,20,20);
   text("angle to y: "+ (angleToY *180/PI),20,50);
   text("angle vector: "+ angle,20,80);
   text("PowerDraw: "+ powerDraw,20,110);
   text("PowerDrawn: "+ powerDrawn,20,140);
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
