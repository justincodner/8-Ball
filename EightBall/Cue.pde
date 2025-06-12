public class Cue{
  //defaults 
  final private float length = 200;
  final private PVector up = new PVector(0,1); //why no static
  final private static int minPower = 3;
  final private static int maxPower = 140;
  final private static int space = 2;
  final private float powerScale =.3;
  private PVector centerPos; //center of the stick b4 rotate
  private PVector angle; //
  private PVector tprint = new PVector(0,0); //
  private float angleToY; //radians
  private float angleLock;
  private float power;
  private float setPower;
  private boolean powerDraw;
  private boolean powerDrawn;
  private boolean stricken = false;
  private Ball ball;
  private float hPower; //highest pwoer b4 cue released

  public Cue(Ball b){
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
  public Ball setBall(Ball b){
    Ball alpha = ball;
    ball = b;
    return alpha;
  }
  public void setPosition(float d){
     //reorienting new x, y based on how far cue is 
    //diag + cue - ball over twice the cue = x
    PVector cueVec = angle.copy().setMag(length / 2 + d+space+ball.getRad()); // cue vector
    PVector diagVec = (PVector.add(cueVec,ball.getPosition()));
    centerPos.x = (float)(diagVec.magSq()+Math.pow(cueVec.mag(),2)
                  - Math.pow(ball.getPosition().mag(),2))/(2 * cueVec.mag()); //dist cue center to ogn
    centerPos.y = centerPos.x*tan(angleToY -atan(diagVec.x/diagVec.y));
  }
  public void setPower(){
    if(mousePressed){
      if(powerDrawn==false){
        
         hPower =power; 
      }
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
      power-=hPower/10;
    } else if(powerDrawn && power <= 0){
      powerDrawn = false;
      tprint=new PVector((float) Math.sin(angleToY) * hPower * .8, (float) Math.cos(angleToY) * hPower * .8);
      println("ball set vel:"+tprint);
      println("current power (cue hit ball)"+power);
            println("hPower (cue hit ball)"+hPower);
       println("angle to y: "+ (angleToY *180/PI));
      ball.setVelocity(ball.getVelocity().add(new PVector((float) Math.sin(angleToY) * -hPower * .1* powerScale, (float) Math.cos(angleToY) * -hPower * .1 * powerScale)));
      power =0;
      hPower=0;
      stricken = true;
    }
  }
  
  public void reset(){
    stricken = false;
    print("rawr    ");
  }
  public boolean isFired(){
     return stricken; 
  }
  //packeges ever
  public void render(){
    strike();
    setAngle();
    setPower();
    pcue();
    float rot = PI/2-angleToY;
    rotate(rot);
    rectMode(CENTER);
    strokeWeight(0);
    fill(200,100,20);
    rect(centerPos.x,centerPos.y,length,10);
    fill(255);
    rect(centerPos.x,centerPos.y,2,2);
    resetMatrix();
  }
  public void pcue(){ 
    /*
   ArrayList<String> debug = new ArrayList<String>();
   textSize(20);
   fill(0,255,255);
   debug.add("Power: " +power);
   debug.add("hPower: " +hPower);
   debug.add("angle to y: "+ (angleToY *180/PI));
  // debug.add("angle vector: "+ angle);
   debug.add("PowerDraw: "+ powerDraw);
   debug.add("PowerDrawn: "+ powerDrawn);
   debug.add("Power: " +power);
   debug.add("ball set vel: "+ tprint);
   debug.add("Mouse X: "+ mouseX);
   debug.add("Mouse Y: "+ mouseY);
//   debug.add("ball set vel: "+ tprint);
  
   for(int i=0;i<debug.size();i++){
     text(debug.get(i), 20, i*20);
   }
   */
  }
  
  public float getAngle() {
    return angleToY;
  }
  
  
}
