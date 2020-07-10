class Point {
    float x,y;
    Point(float x_, float y_){
        x = x_;
        y = y_;
    }
    void moveAbs(float x_, float y_){
        x = x_;
        y = y_;
    }
    void moveRel(float x_, float y_){
        x = x_;
        y = y_;
    }
    void draw(){
    push();
    stroke(0,255,255);
    point(x,y);
    pop();
  }
};