class Creature {
    Ray[] rays;
    PVector position, direction;
    float size, FieldOfView, speed;
    int rayAmount;
    

    Creature(PVector position_, int rayAmount_, float FieldOfView_, float speed_){
        speed = speed_;
        FieldOfView = FieldOfView_;
        position = position_;
        direction = new PVector(0,speed);
        rays = new Ray[0];
        rayAmount = rayAmount_;
        for(int i = 0; i <= rayAmount; i++){
            float angle = (-FieldOfView/2) + i*(FieldOfView/rayAmount);
            rays = (Ray[])append(rays, new Ray(angle));
            
        }
        size = 20;
        //print(rays);
        //rays[0].printOut();

    }

    private void moveFoward(Wall[] walls){
        boolean move = true;
        for(Wall wall: walls){
            //if(doesCollideFront(wall)) move = false;
        }
        direction.setMag(speed);
        if(move){
            position.add(direction);
        }
        
        
    }
    private void moveBackward(Wall[] walls){
        boolean move = true;
        for(Wall wall: walls){
            //if(doesCollideBack(wall)) move = false;
        }
        direction.setMag(speed);
        if(move){
            position.sub(direction);
        }
        
        
    }
    private void turnRight(){
        direction.rotate(0.05);
    }
    private void turnLeft(){
        direction.rotate(-0.05);
    }
    void update(boolean isUp, boolean isDown, boolean isLeft, boolean isRight, Wall[] walls){
        direction.setMag(speed);
        if(isUp) moveFoward(walls);
        if(isDown) moveBackward(walls);
        if(isLeft) turnLeft();
        if(isRight) turnRight();
        if(position.x > width2D- 11) position.x = width2D - 11;
        if(position.y > height2D - 11) position.y = height2D - 11;
        if(position.x < 11) position.x = 11;
        if(position.y < 11) position.y = 11;
        
        for(Ray ray : rays){
            ray.update(position, direction, walls);
        }
        
    }

    void draw(){
        for(int i = 0; i < rays.length; i++){
            rays[i].draw();
            
        }
        firstPersonDraw();
        push();
        translate(position.x,position.y);
        fill(255);
        stroke(0,255,0);
        ellipse(0, 0, size, size);
        line(0,0,direction.x,direction.y);
        pop();

    }

    void firstPersonDraw(){
        float fpWidth = width - width2D;
        float fpRectWidth = fpWidth / rayAmount;
        float distance;
        //print(fpWidth,"\n");
        
        for(int i = 0; i < rays.length; i++){
            if(rays[i].intersectPoint.x != -1){
                distance = rays[i].position.dist(rays[i].intersectPoint);
                distance *= cos(radians(i * (FieldOfView/rayAmount)-(FieldOfView/2)));
            }
            else distance = 1000000000;
            push();
            fill(255/sqrt(distance/10));
            stroke(255/sqrt(distance/10));
            rectMode(CENTER);
            rect(i*fpRectWidth+width2D+fpRectWidth/2,height/2,fpRectWidth,height/sqrt(distance/10));




            pop();
        }
        
    }



    boolean doesCollideFront(Wall wall){
        PVector returnValue;
        direction.setMag(20);
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
        //print(t,"   ",u,"\n");
        if((t>-1 && u > -1 && t < 1 && u < 1)){
            return true;
            
        }
        return false;


    }
    boolean doesCollideBack(Wall wall){
        PVector returnValue;
        direction.setMag(20);
        float x1 = wall.a.x;
        float y1 = wall.a.y;
        float x2 = wall.b.x;
        float y2 = wall.b.y;
        float x3 = position.x - direction.x;
        float y3 = position.y - direction.y;
        float x4 = position.x;
        float y4 = position.y;
        
        float den = (x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4);
        float t = ((x1 - x3)*(y3 - y4) - (y1 - y3)*(x3 - x4))/den;
        float u = -((x1 - x2)*(y1 - y3) - (y1 - y2)*(x1 - x3))/den;
        //print(t,"   ",u,"\n");
        if((t>-1 && u > -1 && t < 1 && u < 1)){
            return true;
            
        }
        return false;


    }

    

}