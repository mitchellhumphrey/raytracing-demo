class Ray {
    PVector position, direction, connentsAt, intersectPoint;
    float angleOffset;
    Ray(float angleOffset_){
        angleOffset = angleOffset_;
        position = new PVector(0,1);
        direction = new PVector(0,7);
    }

    void update(PVector position_, PVector direction_, Wall[] walls){
        direction = new PVector(direction_.x, direction_.y);
        direction.rotate(radians(angleOffset));
        position = position_;

        PVector[] points = new PVector[0];
        PVector temp;
        for (Wall wall : walls){
            temp = doesIntersect(wall);
            if(temp.x != -1){
                points = (PVector[])append(points,temp);
            }
        }
        if(points.length == 0){
            intersectPoint = new PVector(-1,-1);
        }
        else{
            PVector shortest = points[0];
            for(int i = 0; i < points.length; i++){
                if(position.dist(points[i]) < position.dist(shortest)){
                    shortest = points[i];
                }
            }
            intersectPoint = shortest;
        }




    }
    void draw(){
        push();
        stroke(255,0,0);
        //translate(position.x, position.y);


        if(intersectPoint.x != -1){
            line(position.x, position.y, intersectPoint.x, intersectPoint.y);
            fill(255,0,0);
            ellipse(intersectPoint.x, intersectPoint.y, 10,10);
        }
        else {
            line(position.x, position.y,position.x + direction.x*10,position.y + direction.y*10);

        }

        

        pop();
    }
    void printOut(){
        print(angleOffset, position, direction, "\n");
    }

    PVector doesIntersect(Wall wall){
        PVector returnValue;
        float x1 = wall.a.x;
        float y1 = wall.a.y;
        float x2 = wall.b.x;
        float y2 = wall.b.y;
        float x3 = position.x;
        float y3 = position.y;
        float x4 = position.x + direction.x;
        float y4 = position.y + direction.y;
        
        float den = (x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4);
        float t = ((x1 - x3)*(y3 - y4) - (y1 - y3)*(x3 - x4))/den;
        float u = -((x1 - x2)*(y1 - y3) - (y1 - y2)*(x1 - x3))/den;
        if(t>0 && t<1){
            if(u>0){
                float xVal = (x1 + t*(x2 - x1));
                float yVal = (y1 + t*(y2 - y1));
                returnValue = new PVector(xVal,yVal);
            }
            else returnValue = new PVector(-1,-1);
            
        }
        else returnValue = new PVector(-1,-1);
        return returnValue;
    }
    void firstPersonDraw(int rayAmount,int index){
        float distance; 
        if(intersectPoint.x != -1){
            distance = position.dist(intersectPoint);
        }
        else distance = 1000000;
        
        float fpwidth = width - width2D;
        float rectWidth = fpwidth/rayAmount;
        push();
        stroke(0,0,255);
        rectMode(CENTER);
        rect((index*rectWidth)+width2D, height/2,(1/sqrt(distance)),fpwidth);
        pop();
        
    }




}