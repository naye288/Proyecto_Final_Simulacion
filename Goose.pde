class Goose {

  PVector pos;
  PVector vel;
  PVector acc;
  float maxSpeed; // Velocidad máxima del agente
  float mass; // Masa del agente
  float r; // Radio del agente
  color c; // Color del agente

  float maxSteeringForce;
  float lookAhead;
  float pathAhead;

  // Para el comportamiento de deambular
  float wanderRadius; // radio de deambular
  float wanderNoise; // variable para el noise
  float wanderNoiseInc; // incremento del noise

  // Para el comportamiento de bandada
  float alignmentRadio;
  float alignmentRatio;
  float separationRadio;
  float separationRatio;
  float cohesionRadio;
  float cohesionRatio;

  Goose(float x, float y, float z, float mass) {
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
    this.mass = mass;
    r = sqrt(mass);
    c = color(random(128, 255), 0, random(128, 255), 255);

    maxSpeed = 1;
    maxSteeringForce = 1;
    pathAhead = 30;
    lookAhead = 30;

    // Para el comportamiento de deambular
    wanderRadius = 20;
    wanderNoise = random(100);
    wanderNoiseInc = 0.005;

    // Para el comportamiento de bandada
    cohesionRadio = 150;
    cohesionRatio = 1;

    alignmentRadio = 80;
    alignmentRatio = 1;

    separationRadio = 10;
    separationRatio = 3;
  }

  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acc.add(f);
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, pos);
    PVector steering = PVector.sub(desired, vel);
    steering.limit(maxSteeringForce);
    applyForce(steering);
  }

  void wander() {
    PVector desired = vel.copy();
    desired.setMag(lookAhead);
    desired.add(pos);

    PVector target = vel.copy();
    target.setMag(wanderRadius);
    target.rotate(map(noise(wanderNoise), 0, 1, -PI, PI));
    wanderNoise += wanderNoiseInc;
    desired.add(target);

    seek(desired);
  }

  void flock(ArrayList<Goose> geese) {
    PVector alignResult = new PVector(0, 0, 0);
    PVector separateResult = new PVector(0, 0, 0);
    PVector cohereResult = new PVector(0, 0, 0);
    int alignCount = 0;
    int separateCount = 0;
    int cohereCount = 0;

    for (Goose a : geese) {
      if (a != this) {
        float distance = pos.dist(a.pos);

        if (distance < alignmentRadio) {
          alignResult.add(a.vel);
          alignCount++;
        }

        if (distance < separationRadio) {
          PVector dif = PVector.sub(pos, a.pos);
          dif.normalize();
          dif.div(distance);
          separateResult.add(dif);
          separateCount++;
        }

        if (distance < cohesionRadio) {
          cohereResult.add(a.pos);
          cohereCount++;
        }
      }
    }

    if (alignCount > 0) {
      alignResult.div(alignCount);
      alignResult.setMag(alignmentRatio);
      alignResult.limit(maxSteeringForce);
      applyForce(alignResult);
    }

    if (separateCount > 0) {
      separateResult.div(separateCount);
      separateResult.setMag(separationRatio);
      separateResult.limit(maxSteeringForce);
      applyForce(separateResult);
    }

    if (cohereCount > 0) {
      cohereResult.div(cohereCount);
      cohereResult.sub(pos);
      cohereResult.setMag(cohesionRatio);
      cohereResult.limit(maxSteeringForce);
      applyForce(cohereResult);
    }
  }

  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    strokeWeight(1);
    stroke(255);
    fill(c);
    rotate(vel.heading());
    beginShape();
    vertex(r, 0, 0);
    vertex(-2.0/3.0 * r, -2.0/3.0 * r, 0);
    vertex(-r/3.0, 0);
    vertex(-2.0/3.0 * r, 2.0/3.0 * r, 0);
    endShape(CLOSE);
    popMatrix();
  }

  void randomVel(float mag) {
    vel = PVector.random2D();
    vel.setMag(mag);
  }
}
