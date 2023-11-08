class Path {
  ArrayList<PathSegment> segments;
  ArrayList<PVector> points;
  color c;

  Path(color c) {
    segments = new ArrayList();
    points = new ArrayList();
    this.c = c;
  }
  void addPointByGrid(int x1, int y1, int x2, int y2) {
    float startX = -img.width / 2;
    float startY = -img.height / 2;

    float gx1 = startX + x1*gridSize;
    float gy1 = startY + y1*gridSize;

    float gx2 = startX + x2*gridSize;
    float gy2 = startY + y2*gridSize;
    addPoint(gx1, gy1, gx2, gy2);
  }
  void addPoint(float x1, float y1, float x2, float y2) {
    PVector start = new PVector(x1, y1, 0);
    PVector end = new PVector(x2, y2, 0);
    points.add(start);
    points.add(end);
    PathSegment s = new PathSegment(x1, y1, x2, y2, c);
    segments.add(s);
  }
  void display() {
    for (PathSegment s : segments) {
      s.display();
    }
  }
  void clear() {
    points.clear();
    segments.clear();
  }

  int getClosestSegmentIndex(PVector pos) {
    int closest = 0;
    for (int i = 1; i < segments.size(); i++) {
      PathSegment s1 = segments.get(i);
      PathSegment s2 = segments.get(closest);
      if (s1.distance(pos) < s2.distance(pos)) {
        closest = i;
      }
    }
    return closest;
  }
}
