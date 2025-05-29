public class Player {
  private String name;
  private String ballType;
  private boolean finalShot;
  
  public Player(String name, String ballType){
    this.name = name;
    this.ballType= ballType;
    finalShot = false;
  }
  
  public void takeShot(float angle, int power) {
    // should call the cue class
    // Maybe have it so that the takeShot in just in the main
    
  }
  
  public void assignType(String type){
    
  }
  
  public void setName(String name1){
     name = name1;
  }
}
