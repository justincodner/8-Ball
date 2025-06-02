public class Player {

    private String playerName;
    private String ballType; // "solid" or "striped"
    private boolean finalShot;
    private Cue cue;
    private int ballsPocketed;
    private boolean player1Turn;
    private boolean player2Turn;

    // Constructor
    public Player(String name, WhiteBall whiteBall) {
        this.playerName = name;
        this.ballType = null;
        this.finalShot = false;
        this.cue = new Cue(whiteBall);
        this.ballsPocketed = 0;
        this.player1Turn = true;
        this.player2Turn = false;
    }

    // Called each frame to let the player take their shot
    public void takeShot() {
        if (player1Turn || player2Turn) {
            cue.render();  // handles aiming, power draw, and striking
        }
    }

    // Assigns solid or striped
    public void assignType(String type) {
        if (type.equals("solid") || type.equals("striped")) {
            this.ballType = type;
        }
    }

    public void setName(String name) {
        this.playerName = name;
    }

    public void setFinalShot(boolean finalShot) {
        this.finalShot = finalShot;
    }


    public void addPocketedBall() {
        ballsPocketed++;
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


    public int getBallsPocketed() {
        return ballsPocketed;
    }
}
