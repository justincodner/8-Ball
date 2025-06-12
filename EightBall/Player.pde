public class Player {

    private int ballType; // 0 or 1
    private int ballsLeft;

    // Constructor
    public Player() {
        this.ballsLeft = 8;
    }
    
    
    // Assigns solid or striped
    public void type(int type) {
        if (type == 1 || type == 0) {
            this.ballType = type;
        }
    } 


    public void subtractBall() {
        ballsLeft--;
    }

    public int getBallType() {
        return ballType;
    }


    public int getBallsLeft() {
        return ballsLeft;
    }
}
