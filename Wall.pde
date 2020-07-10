class Wall {
  PVector a,b;
  Wall(PVector a_, PVector b_){
    a = a_;
    b = b_;
  }
  Wall(float x1, float y1, float x2, float y2){
    a = new PVector(x1,y1);
    b = new PVector(x2,y2);
  }
  void draw(){
    push();
    stroke(255);
    strokeWeight(2);
    line(a.x, a.y, b.x, b.y);
    pop();
  }
};
