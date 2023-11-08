class PathSegment {
  PVector start;
  PVector end;
  color c;

  PathSegment(float x1, float z1, float x2, float z2, color c) {
    start = new PVector(x1, pathY, z1);
    end = new PVector(x2, pathY, z2);
    this.c = c;
  }
  void display() {
    beginShape();
    strokeWeight(8);
    strokeJoin(ROUND);
    stroke(c);
    noFill();
    vertex(start.x, start.z, start.y);

    int numVertices = 10; 
    for (int i = 1; i <= numVertices; i++) {
      float alpha = float(i) / numVertices;
      float x = lerp(start.x, end.x, alpha);
      float y = lerp(start.y, end.y, alpha);
      float z = lerp(start.z, end.z, alpha);
      vertex(x, z, y);
    }

    vertex(end.x, end.z, end.y);
    endShape();
    
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

  void displayLine() {
    strokeWeight(8);
    stroke(c);
    strokeJoin(ROUND);
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
