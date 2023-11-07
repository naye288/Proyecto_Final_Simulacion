class Goose {

    PVector pos;
    PVector vel;
    PVector acc;
    float maxSpeed;
    float mass;
    float r;
    color c;

    float maxSteeringForce;
    float lookAhead;
    float pathAhead;

    Goose(float x, float y, float z, float mass) {
        pos = new PVector(x, y, z);
        vel = new PVector(0, 0, 0);
        acc = new PVector(0, 0, 0);
        this.mass = mass;
        r = sqrt(mass);
        c = color(random(128, 255), 0, random(128, 255), 255);

        maxSpeed = 2;
        maxSteeringForce = 1;
        pathAhead = 30;
        lookAhead = 30;
    }

    void update() {
        vel.add(acc);
        vel.limit(maxSpeed);
        pos.add(vel);
        acc.mult(0);
    } 

    void display() {
        strokeWeight(1);
        stroke(255);
        fill(c);
        pushMatrix();
        translate(pos.x, pos.y, pos.z);
        rotate(vel.heading());
        beginShape();
        vertex(r * 5, 0, 0);
        vertex(-2.0/3.0 * r * 3, -2.0/3.0 * r * 5, 0);
        vertex(-r/3.0, 0);
        vertex(-2.0/3.0 * r * 3, 2.0/3.0 * r * 5, 0);
        endShape(CLOSE);
        popMatrix();
    }

    void randomVel(float mag) {
        vel = PVector.random2D();
        vel.setMag(mag);
    }



}
