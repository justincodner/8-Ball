public class Player {

    private String playerName;
    private int ballType; // 0 or 1
    private boolean finalShot;
    private int ballsLeft;

    // Constructor
    public Player(String name) {
        this.playerName = name;
        this.finalShot = false;
        this.ballsLeft = 8;
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

    public int getBallType() {
        return ballType;
    }

    public boolean isFinalShot() {
        return finalShot;
    }


    public int getBallsLeft() {
        return ballsLeft;
    }
}
