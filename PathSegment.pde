class PathSegment {
  PVector start;
  PVector end;
  float r;
  color c;

  PathSegment(float x1, float z1, float x2, float z2) {
    start = new PVector(x1, 0, z1);
    end = new PVector(x2, 0, z2);
    this.r = 2;
    this.c = #7E9558;
  }

  void display() {
    strokeWeight(r * 2);
    stroke(c);
    line(start.x, start.z, start.y, end.x, end.z, end.y);

    if (debug) {
      // Dibuja puntos para marcar el inicio y el final
      pushMatrix();
      translate(start.x, start.z, start.y);
      stroke(255, 0, 0);
      sphere(5);
      popMatrix();

      pushMatrix();
      translate(end.x, end.z, end.y);
      stroke(0, 0, 255);
      sphere(5);
      popMatrix();
    }
  }
  float distance(PVector pos) {
    PVector v = PVector.sub(pos, start);
    PVector w = PVector.sub(end, start);
    w.normalize();
    w.setMag(v.dot(w));
    w.add(start);
    float normalDist = pos.dist(w);
    float startDist = pos.dist(start);
    float endDist = pos.dist(end);
    if (contains(w)) {
      return normalDist;
    } else {
      return min(startDist, endDist);
    }
  }
  boolean contains(PVector pos) {
    float A = pos.dist(start);
    float B = pos.dist(end);
    float C = start.dist(end);
    return A + B - C < 0.01;
  }
  ArrayList<PVector> getAheadPoints(PVector predicted, float pathAhead) {
    ArrayList<PVector> result = new ArrayList();
    PVector v = PVector.sub(predicted, start);
    PVector w = PVector.sub(end, start);
    w.normalize();
    float projection = v.dot(w);
    w.setMag(projection);
    PVector normal = PVector.add(w, start);
    if (projection > 0) {
      w.setMag(w.mag() + pathAhead);
    } else {
      w.setMag(w.mag() - pathAhead);
    }
    PVector ahead = PVector.add(w, start);
    result.add(normal);
    result.add(ahead);
    return result;
  }
}
