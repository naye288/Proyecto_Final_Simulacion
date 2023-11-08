class GeeseSystem {

    ArrayList<Goose> geese;

    GeeseSystem() {
        geese = new ArrayList<Goose>();
    }

    // Este método actualiza y dibuja a la vez
    void update() {
        for (Goose goose : geese) {
            goose.follow(paths.get(1));
            goose.wander();
            goose.flock(geese);
            goose.update();
            goose.display();
        }
    }

    void addAgent(float x, float y, float z, float mass) {
        Goose goose = new Goose(x, y, z, mass);
        goose.randomVel(1);
        geese.add(goose);
    }


}
