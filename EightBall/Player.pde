public class Player {
  
    private String playerName;
    private String ballType; // "solid" or "striped"
    private boolean finalShot;
    private Cue cue;
    // private WhiteBall whiteBall;
    
    // Constructor
    public Player(String name, WhiteBall whiteBall) {
        this.playerName = name;
        this.ballType = null;
        this.finalShot = false;
        // this.whiteBall = whiteBall;
        this.cue = new Cue(whiteBall);
    }

    // Called each frame to let the player take their shot (PVector angle already handled in cue)
    public void takeShot() {
        cue.render();  // handles power draw, angle setting, and striking
    }

    // Assign ball type to player: "solid" or "striped"
    public void assignType(String type) {
        if (type.equals("solid") || type.equals("striped")) {
            this.ballType = type;
        }
    }

    public void setName(String name) {
        this.playerName = name;
    }

    // Set whether this is the final shot (when only 8-ball remains)
    public void setFinalShot(boolean finalShot) {
        this.finalShot = finalShot;
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
        return cue.isFired(); 
    }

}
