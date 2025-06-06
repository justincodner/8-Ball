public class Player {

    private String playerName;
    private int ballType; // "solid" or "striped"
    private boolean finalShot;
    private Cue cue;
    private int ballsLeft;
    private boolean turn;

    // Constructor
    public Player(String name) {
        this.playerName = name;
        this.finalShot = false;
        this.ballsLeft = 0;
        this.turn = true;
    }
    public void setWhiteBall(Ball whiteball){
      this.cue = new Cue(whiteball);
    }

    // Called each frame to let the player take their shot
    public void takeShot() {
        if (turn) {
            cue.render();  // handles aiming, power draw, and striking
        }
    }

    // Assigns solid or striped
    public void type(int type) {
        if (type == 1 || type == 0) {
            this.ballType = type;
        }
    } 

    public void setName(String name) {
        this.playerName = name;
    }

    public void setFinalShot(boolean finalShot) {
        this.finalShot = finalShot;
    }


    public void subtractBall() {
        ballsLeft--;
    }

    public String getPlayerName() {
        return playerName;
    }

    public String getBallType() {
        return ballType;
    }

    public boolean isFinalShot() {
        return finalShot;
    }

    public Cue getCue() {
        return cue;
    }

    public boolean hasStruck() {
        return cue.isFired(); // requires isFired() in Cue class
    }


    public int getBallsLeft() {
        return ballsLeft;
    }
}
